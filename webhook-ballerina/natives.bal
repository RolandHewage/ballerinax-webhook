import ballerina/jballerina.java;

isolated function callOnPingMethod(GithubWebhookService webhookService, PingEvent msg) = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;
