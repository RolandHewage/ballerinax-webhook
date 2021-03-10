import ballerina/websub;
import ballerina/log;

service class WebSubService {
    *websub:SubscriberService;
    
    private GithubWebhookService webhookService;

    public isolated function init(GithubWebhookService webhookService) {
        self.webhookService = webhookService;
    }

    remote function onEventNotification(websub:ContentDistributionMessage event) 
                        returns websub:Acknowledgement|websub:SubscriptionDeletedError|error? {
        log:print("onEventNotification invoked ", contentDistributionMessage = event);
        if (event.content is json) {
            json retrievedPayload = <json>event.content;
            if (retrievedPayload.zen is string) {
                PingEvent message = check retrievedPayload.cloneWithType(PingEvent);
                var response = callOnPingMethod(self.webhookService, message);
            }
        }

        return {};
    }
}