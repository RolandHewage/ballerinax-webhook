# Sample Webhook Service #

* This repository contains sample webhook service implemented on top of `ballerina websub module`.

## Prerequisites ##

* Ballerina SL Alpha2+
* Open JDK 11

## Project Structure ##

* In this module we have used following webhook service type for the WebHook.

```ballerina
public type SimpleWebhookService service object {
    remote function onStartup(StartupMessage message) returns Acknowledgement|StartupError?;
    
    remote function onEvent(EventNotification message) returns Acknowledgement?;
};
```

* Sample usage of the above service type would be as follows.

```ballerina
import ballerina/http;
import ballerina/log;

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
```
