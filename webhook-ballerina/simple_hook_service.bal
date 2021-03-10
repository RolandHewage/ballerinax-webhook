public type SimpleWebhookService service object {
    remote function onStartup(StartupMessage message) returns Acknowledgement|StartupError?;
    
    remote function onEvent(EventNotification message) returns Acknowledgement?;
};