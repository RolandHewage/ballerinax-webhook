public type GithubWebhookService service object {
    remote function onPing(PingEvent message);
};