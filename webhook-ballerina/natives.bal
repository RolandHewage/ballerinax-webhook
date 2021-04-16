import ballerina/jballerina.java;

isolated function callOnStartupMethod(SimpleWebhookService webhookService, StartupMessage msg) 
                                returns Acknowledgement|StartupError? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

isolated function callOnEventMethod(SimpleWebhookService webhookService, EventNotification msg) 
                                returns Acknowledgement? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

isolated function callOnEditMethod(SimpleWebhookService webhookService, EventNotification1 msg) 
                                returns Acknowledgement? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

isolated function callOnAppendRowMethod(SimpleWebhookService webhookService, EditEventInfo msg) 
                                returns Acknowledgement? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;

isolated function callOnUpdateRowMethod(SimpleWebhookService webhookService, EditEventInfo msg) 
                                returns Acknowledgement? = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
