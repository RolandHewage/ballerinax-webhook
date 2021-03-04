import ballerina/websub;
import ballerina/http;
// import ballerina/log;

public class Listener {
    private websub:Listener subscriberListener;
    private WebSubService? subscriberService;

    public isolated function init(int|http:Listener listenTo, http:ListenerConfiguration? config = ()) returns error? {
        self.subscriberListener = check new(listenTo, config);
        self.subscriberService = ();
    }

    public function attach(SimpleWebhookService s, string[]|string? name = ()) returns error? {
        // var configuration = retrieveSubscriberServiceAnnotations(s);
        // if (configuration is websub:SubscriberServiceConfiguration) {
        //     self.subscriberService = new;
        //     check self.subscriberListener.attach(<WebSubService> self.subscriberService, name);
        // } else {
        //     return error ListenerError("Could not find the required service-configurations");
        // }
        self.subscriberService = new (s);
        check self.subscriberListener.attach(<WebSubService>self.subscriberService, name);
    }

    public isolated function detach(SimpleWebhookService s) returns error? {
        check self.subscriberListener.detach(<WebSubService>self.subscriberService);
    }

    public function 'start() returns error? {
        check self.subscriberListener.'start();
    }

    public isolated function gracefulStop() returns error? {
        return self.subscriberListener.gracefulStop();
    }

    public isolated function immediateStop() returns error? {
        return self.subscriberListener.immediateStop();
    }
}