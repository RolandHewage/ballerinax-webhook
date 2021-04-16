public type Payload record {
    string eventType;
    json eventData;
};
public type StartupMessage record {
    string hubName;
    string subscriberId;
};

public type EventNotification record {
    string hubName;
    string eventId;
    string message;
};

public type EventNotification1 record {
    string hubName1;
    string eventId1;
};

type CommonResponse record {|
    map<string|string[]> headers?;
    map<string> body?;
|};

public type Acknowledgement record {
    *CommonResponse;
};