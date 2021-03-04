import ballerina/websub;
import ballerina/log;
// import ballerina/jballerina.java;

@websub:SubscriberServiceConfig {
    leaseSeconds: 36000
}
service class WebSubService {
    private SimpleWebhookService webhookService;

    public isolated function init(SimpleWebhookService webhookService) {
        self.webhookService = webhookService;
    }

    remote function onEventNotification(websub:ContentDistributionMessage event) 
                        returns websub:Acknowledgement|websub:SubscriptionDeletedError? {
        log:print("onEventNotification invoked ", contentDistributionMessage = event);

        StartupMessage message = {
            hubName: "Simple Hub",
            subscriberId: "sub-id-01"
        };

        // var response = callOnStartupMethod(self.webhookService, message);

        return {};
    }
}