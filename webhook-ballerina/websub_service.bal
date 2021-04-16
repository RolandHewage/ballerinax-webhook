import ballerina/websub;
import ballerina/log;

service class WebSubService {
    *websub:SubscriberService;
    
    private SimpleWebhookService webhookService;

    public isolated function init(SimpleWebhookService webhookService) {
        self.webhookService = webhookService;
    }

    remote function onEventNotification(websub:ContentDistributionMessage event) 
                        returns websub:Acknowledgement|websub:SubscriptionDeletedError? {
        log:print("onEventNotification invoked ", contentDistributionMessage = event);
        // if (event.content is json) {
        //     Payload payload = checkpanic event.content.cloneWithType(Payload);
        //     string eventType = payload["eventType"];
        //     json eventData = payload["eventData"];
        //     match (eventType) {
        //         "start" => {
        //             StartupMessage message = checkpanic eventData.cloneWithType(StartupMessage);
        //             var response = callOnStartupMethod(self.webhookService, message);
        //             if (response is StartupError) {
        //                 return error websub:SubscriptionDeletedError(response.message());
        //             }
        //         }
        //         "notify" => {
        //             EventNotification message = checkpanic eventData.cloneWithType(EventNotification);
        //             var response = callOnEventMethod(self.webhookService, message);
        //         }
        //         "EDIT" => {
        //             log:print("onEditEvent invoked ");
        //             EventNotification1 message = {hubName1:"", eventId1:""};
        //             var response = callOnEditMethod(self.webhookService, message);
        //         }
        //         "appendRow" => {
        //             log:print("onAppendRowEvent invoked ");
        //             EditEventInfo message = checkpanic eventData.cloneWithType(EditEventInfo);
        //             var response = callOnAppendRowMethod(self.webhookService, message);
        //         }
        //         "updateRow" => {
        //             log:print("onUpdateRowEvent invoked ");
        //             EditEventInfo message = checkpanic eventData.cloneWithType(EditEventInfo);
        //             var response = callOnUpdateRowMethod(self.webhookService, message);
        //         }
        //         _ => {}
        //     }
        // }

        return {};
    }
}