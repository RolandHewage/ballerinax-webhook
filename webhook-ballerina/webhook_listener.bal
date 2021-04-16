import ballerina/websub;
import ballerina/http;
import ballerina/log;
import ballerinax/googleapis_drive as drive;

public class Listener {
    private websub:Listener subscriberListener;
    private websub:SubscriberService? subscriberService;

    private http:Listener httpListener;
    private drive:Client driveClient;
    private OnEventService eventService;

    private string specificGsheetId;
    private boolean isValidGsheet = false;

    private drive:WatchResponse watchResponse;
    private string channelUuid;
    private string watchResourceId;
    private string currentToken;

    private json[] currentFileStatus = [];

    private SheetListenerConfiguration config;

    public isolated function init(int|http:Listener listenTo, SheetListenerConfiguration config, http:ListenerConfiguration? sconfig = ()) returns error? {
        self.subscriberListener = check new(listenTo, sconfig);
        self.subscriberService = ();

        self.config = config;
    }

    public function attach(SimpleWebhookService s, string[]|string? name = ()) returns error? {
        var configuration = retrieveSubscriberServiceAnnotations(s);
        if (configuration is websub:SubscriberServiceConfiguration) {
            self.subscriberService = new WebSubService(s);
            check self.subscriberListener.initialize(<websub:SubscriberService>self.subscriberService, configuration, name);
        } else {
            return error ListenerError("Could not find the required service-configurations");
        }
    }

    public isolated function detach(SimpleWebhookService s) returns error? {
        check self.subscriberListener.detach(<WebSubService>self.subscriberService);
    }

    public function 'start() returns error? {
        check self.subscriberListener.'start();

        self.driveClient = check new (self.config.driveClientConfiguration);
        self.eventService = self.config.eventService;
        if (self.config.specificGsheetId is string) {
            self.isValidGsheet = check checkMimeType(self.driveClient, self.config.specificGsheetId.toString());
        }
        if (self.isValidGsheet == true) {
            self.specificGsheetId = self.config.specificGsheetId.toString();
            self.watchResponse = check startWatchChannel(self.config.callbackURL, self.driveClient, self.specificGsheetId);
            check getCurrentStatusOfFile(self.driveClient, self.currentFileStatus, self.specificGsheetId);
        } else {
            self.specificGsheetId = EMPTY_STRING;
            self.watchResponse = check startWatchChannel(self.config.callbackURL, self.driveClient);
            check getCurrentStatusOfDrive(self.driveClient, self.currentFileStatus);
        }
        self.channelUuid = self.watchResponse?.id.toString();
        self.watchResourceId = self.watchResponse?.resourceId.toString();
        self.currentToken = self.watchResponse?.startPageToken.toString();
        log:print("Watch channel started in Google, id : " + self.channelUuid);
    }

    public isolated function gracefulStop() returns error? {
        return self.subscriberListener.gracefulStop();
    }

    public isolated function immediateStop() returns error? {
        return self.subscriberListener.immediateStop();
    }
}

isolated function retrieveSubscriberServiceAnnotations(SimpleWebhookService serviceType) returns websub:SubscriberServiceConfiguration? {
    typedesc<any> serviceTypedesc = typeof serviceType;
    return serviceTypedesc.@websub:SubscriberServiceConfig;
}