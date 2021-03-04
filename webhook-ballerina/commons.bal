public type StartupMessage record {
    string hubName;
    string subscriberId;
};

public type EventNotification record {
    string hubName;
    string eventId;
    string message;
};

type CommonResponse record {|
    map<string|string[]> headers?;
    map<string> body?;
|};

public type Acknowledgement record {
    *CommonResponse;
};