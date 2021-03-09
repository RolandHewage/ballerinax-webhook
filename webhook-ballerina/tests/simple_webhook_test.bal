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
    
    remote function onEvent(EventNotification message) returns Acknowledgement {
        log:print("Received event-notification-message ", notificationMsg = message);
        return {};
    }
}

http:Client httpClient = checkpanic new("http://localhost:9090/subscriber");

@test:Config {}
function testOnEventNotificationSuccess() returns @tainted error? {
    http:Request request = new;
    json payload =  {"action": "publish", "mode": "remote-hub"};
    request.setPayload(payload);

    var response = check httpClient->post("/", request);
    if (response is http:Response) {
        test:assertEquals(response.statusCode, 202);
    } else {
        test:assertFail("UnsubscriptionIntentVerification test failed");
    }
}