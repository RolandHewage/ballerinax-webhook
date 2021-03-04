import ballerina/websub;

public type WebhookConfigurations record {|
    *websub:SubscriberServiceConfiguration;
|};

public annotation WebhookConfigurations WebhookConfig on service;