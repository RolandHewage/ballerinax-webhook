import ballerina/websub;
import ballerina/http;

public class Listener {
    private websub:Listener subscriberListener;
    private websub:SubscriberService? subscriberService;

    public isolated function init(int|http:Listener listenTo, http:ListenerConfiguration? config = ()) returns error? {
        self.subscriberListener = check new(listenTo, config);
        self.subscriberService = ();
    }

    public function attach(GithubWebhookService s, string[]|string? name = ()) returns error? {
        var configuration = retrieveSubscriberServiceAnnotations(s);
        if (configuration is websub:SubscriberServiceConfiguration) {
            self.subscriberService = new WebSubService(s);
            check self.subscriberListener.initialize(<websub:SubscriberService>self.subscriberService, configuration, name);
        } else {
            return error ListenerError("Could not find the required service-configurations");
        }
    }

    public isolated function detach(GithubWebhookService s) returns error? {
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

isolated function retrieveSubscriberServiceAnnotations(GithubWebhookService serviceType) returns websub:SubscriberServiceConfiguration? {
    typedesc<any> serviceTypedesc = typeof serviceType;
    return serviceTypedesc.@websub:SubscriberServiceConfig;
}