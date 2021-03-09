import ballerina/websub;
// import ballerina/jballerina.java;

isolated function retrieveSubscriberServiceAnnotations(SimpleWebhookService serviceType) returns websub:SubscriberServiceConfiguration? {
    typedesc<any> serviceTypedesc = typeof serviceType;
    return serviceTypedesc.@websub:SubscriberServiceConfig;
}