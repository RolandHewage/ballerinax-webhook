# Sample Webhook Service #

* This repository contains sample webhook service implemented on top of `ballerina websub module` (specifically for GitHub Webhooks).

## Prerequisites ##

* Ballerina SL Alpha2+
* Open JDK 11

## Project Structure ##

* In this module we have used following webhook service type for the WebHook (only one GitHub Webhook `ping` action supported here).

```ballerina
public type GithubWebhookService service object {
    remote function onPing(PingEvent message);
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
    remote function onPing(PingEvent message) {
        log:print("Received ping-event ", startupMsg = message);
    }
}
```