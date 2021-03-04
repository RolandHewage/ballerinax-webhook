import ballerina/websub;
import ballerina/jballerina.java;

isolated function retrieveSubscriberServiceAnnotations(websub:SubscriberService serviceType) returns websub:SubscriberServiceConfiguration? {
    typedesc<any> serviceTypedesc = typeof serviceType;
    return serviceTypedesc.@websub:SubscriberServiceConfig;
}

isolated function printMessage() = @java:Method {
    'class: "io.ballerinax.webhook.WebhookNativeOperationHandler"
} external;