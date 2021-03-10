import ballerina/test;
import ballerina/websub;
import ballerina/log;
import ballerina/http;

listener Listener webhookListener = new (9090);

@websub:SubscriberServiceConfig {
    leaseSeconds: 36000
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

@test:Config {}
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