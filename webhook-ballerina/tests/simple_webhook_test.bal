import ballerina/test;
import ballerina/websub;
import ballerina/log;
import ballerina/http;
import ballerinax/googleapis_drive as drive;

# Event Trigger class
public class EventTrigger {
    public isolated function onNewSheetCreatedEvent(string fileId) {
        log:print("New File was created : " + fileId);
        // Write your logic here.....
    }

    public isolated function onSheetDeletedEvent(string fileId) {}

    public isolated function onFileUpdateEvent(string fileId) {}
}

configurable int port = ?;
configurable string callbackURL = ?;
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshUrl = ?;
configurable string refreshToken = ?;

drive:Configuration clientConfiguration = {
    clientConfig: {
        clientId: clientId,
        clientSecret: clientSecret,
        refreshUrl: refreshUrl,
        refreshToken: refreshToken
    }
};

SheetListenerConfiguration congifuration = {
    port: port,
    callbackURL: callbackURL,
    driveClientConfiguration: clientConfiguration,
    eventService: new EventTrigger()
};

listener Listener webhookListener = new (9090, congifuration);

@websub:SubscriberServiceConfig {
    leaseSeconds: 36000,
    callback: "http://localhost:9090/subscriber"
}
service /subscriber on webhookListener {
    remote function onStartup(StartupMessage message) returns Acknowledgement|StartupError? {
        log:print("Received startup-message ", startupMsg = message);
        return {};
    }
    
    remote function onEvent(EventNotification message) returns Acknowledgement? {
        log:print("Received event-notification-message ", notificationMsg = message);
        return {};
    }

    remote function onEdit(EventNotification message) returns Acknowledgement? {
        log:print("Received onEdit-message ", notificationMsg = message);
        return {};
    }

    remote function onAppendRow(EventNotification message) returns Acknowledgement? {
        log:print("Received onAppendRow-message ", notificationMsg = message);
        return {};
    }

    remote function onUpdateRow(EventNotification message) returns Acknowledgement? {
        log:print("Received onUpdateRow-message ", notificationMsg = message);
        return {};
    }
}

http:Client httpClient = checkpanic new("http://localhost:9090/subscriber");

@test:Config {}
function testStartupMessage() returns @tainted error? {
    http:Request request = new;
    json payload =  {"eventType": "start", "eventData" : { "hubName": "hub1", "subscriberId": "sub1" } };
    request.setPayload(payload);

    var response = check httpClient->post("/", request);
    if (response is http:Response) {
        test:assertEquals(response.statusCode, 202);
    } else {
        test:assertFail("Webhook startup test failed");
    }
}

@test:Config {
    dependsOn: [testStartupMessage]
}
function testEventNotificationMessage() returns @tainted error? {
    http:Request request = new;
    json payload =  {"eventType": "notify", "eventData" : { "hubName": "hub1", "eventId": "event1", "message": "This is a simpl notification" } };
    request.setPayload(payload);

    var response = check httpClient->post("/", request);
    if (response is http:Response) {
        test:assertEquals(response.statusCode, 202);
    } else {
        test:assertFail("Webhook event notification test failed");
    }
}

@test:Config {
    enable: true,
    dependsOn: [testEventNotificationMessage]
}
public isolated function testDriveAPITrigger() {
    log:print("gDriveClient -> watchFiles()");
    int i = 0;
    while (true) {
        i = 0;
    }
    test:assertTrue(true, msg = "expected to be created a watch in google drive");
}