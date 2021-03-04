public type SimpleWebhookService service object {
    remote function onEvent(EventNotification message) returns Acknowledgement|NotificationError;

    remote function onStartup(StartupMessage message) returns Acknowledgement|StartupError?;
};