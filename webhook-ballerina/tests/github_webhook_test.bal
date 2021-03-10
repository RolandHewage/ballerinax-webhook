import ballerina/test;
import ballerina/websub;
import ballerina/log;
import ballerina/http;

listener Listener webhookListener = new (9090);

@websub:SubscriberServiceConfig {
    leaseSeconds: 36000
}
service /subscriber on webhookListener {
    remote function onPing(PingEvent message) {
        log:print("Received ping-event ", startupMsg = message);
    }
}

http:Client httpClient = checkpanic new("http://localhost:9090/subscriber");

@test:Config {}
function testOnPingEvent() returns @tainted error? {
    http:Request request = new;
    request.setPayload(requestBody);

    var response = check httpClient->post("/", request);
    if (response is http:Response) {
        test:assertEquals(response.statusCode, 202);
    } else {
        test:assertFail("Webhook startup test failed");
    }
}

json requestBody = {
  "zen": "Anything added dilutes everything else.",
  "hook_id": 109948940,
  "hook": {
    "type": "Repository",
    "id": 109948940,
    "name": "web",
    "active": true,
    "events": [
      "*"
    ],
    "config": {
      "content_type": "json",
      "url": "https://smee.io/****************",
      "insecure_ssl": "0"
    },
    "updated_at": "2019-05-15T15:20:49Z",
    "created_at": "2019-05-15T15:20:49Z",
    "url": "https://api.github.com/repos/Octocoders/Hello-World/hooks/109948940",
    "test_url": "https://api.github.com/repos/Octocoders/Hello-World/hooks/109948940/test",
    "ping_url": "https://api.github.com/repos/Octocoders/Hello-World/hooks/109948940/pings",
    "last_response": {
      "code": null,
      "status": "unused",
      "message": null
    }
  },
  "repository": {
    "id": 186853261,
    "node_id": "MDEwOlJlcG9zaXRvcnkxODY4NTMyNjE=",
    "name": "Hello-World",
    "full_name": "Octocoders/Hello-World",
    "private": false,
    "owner": {
      "login": "Octocoders",
      "id": 38302899,
      "node_id": "MDEyOk9yZ2FuaXphdGlvbjM4MzAyODk5",
      "avatar_url": "https://avatars1.githubusercontent.com/u/38302899?v=4",
      "gravatar_id": "",
      "url": "https://api.github.com/users/Octocoders",
      "html_url": "https://github.com/Octocoders",
      "followers_url": "https://api.github.com/users/Octocoders/followers",
      "following_url": "https://api.github.com/users/Octocoders/following{/other_user}",
      "gists_url": "https://api.github.com/users/Octocoders/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/Octocoders/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/Octocoders/subscriptions",
      "organizations_url": "https://api.github.com/users/Octocoders/orgs",
      "repos_url": "https://api.github.com/users/Octocoders/repos",
      "events_url": "https://api.github.com/users/Octocoders/events{/privacy}",
      "received_events_url": "https://api.github.com/users/Octocoders/received_events",
      "type": "Organization",
      "site_admin": false
    },
    "html_url": "https://github.com/Octocoders/Hello-World",
    "description": null,
    "fork": true,
    "url": "https://api.github.com/repos/Octocoders/Hello-World",
    "forks_url": "https://api.github.com/repos/Octocoders/Hello-World/forks",
    "keys_url": "https://api.github.com/repos/Octocoders/Hello-World/keys{/key_id}",
    "collaborators_url": "https://api.github.com/repos/Octocoders/Hello-World/collaborators{/collaborator}",
    "teams_url": "https://api.github.com/repos/Octocoders/Hello-World/teams",
    "hooks_url": "https://api.github.com/repos/Octocoders/Hello-World/hooks",
    "issue_events_url": "https://api.github.com/repos/Octocoders/Hello-World/issues/events{/number}",
    "events_url": "https://api.github.com/repos/Octocoders/Hello-World/events",
    "assignees_url": "https://api.github.com/repos/Octocoders/Hello-World/assignees{/user}",
    "branches_url": "https://api.github.com/repos/Octocoders/Hello-World/branches{/branch}",
    "tags_url": "https://api.github.com/repos/Octocoders/Hello-World/tags",
    "blobs_url": "https://api.github.com/repos/Octocoders/Hello-World/git/blobs{/sha}",
    "git_tags_url": "https://api.github.com/repos/Octocoders/Hello-World/git/tags{/sha}",
    "git_refs_url": "https://api.github.com/repos/Octocoders/Hello-World/git/refs{/sha}",
    "trees_url": "https://api.github.com/repos/Octocoders/Hello-World/git/trees{/sha}",
    "statuses_url": "https://api.github.com/repos/Octocoders/Hello-World/statuses/{sha}",
    "languages_url": "https://api.github.com/repos/Octocoders/Hello-World/languages",
    "stargazers_url": "https://api.github.com/repos/Octocoders/Hello-World/stargazers",
    "contributors_url": "https://api.github.com/repos/Octocoders/Hello-World/contributors",
    "subscribers_url": "https://api.github.com/repos/Octocoders/Hello-World/subscribers",
    "subscription_url": "https://api.github.com/repos/Octocoders/Hello-World/subscription",
    "commits_url": "https://api.github.com/repos/Octocoders/Hello-World/commits{/sha}",
    "git_commits_url": "https://api.github.com/repos/Octocoders/Hello-World/git/commits{/sha}",
    "comments_url": "https://api.github.com/repos/Octocoders/Hello-World/comments{/number}",
    "issue_comment_url": "https://api.github.com/repos/Octocoders/Hello-World/issues/comments{/number}",
    "contents_url": "https://api.github.com/repos/Octocoders/Hello-World/contents/{+path}",
    "compare_url": "https://api.github.com/repos/Octocoders/Hello-World/compare/{base}...{head}",
    "merges_url": "https://api.github.com/repos/Octocoders/Hello-World/merges",
    "archive_url": "https://api.github.com/repos/Octocoders/Hello-World/{archive_format}{/ref}",
    "downloads_url": "https://api.github.com/repos/Octocoders/Hello-World/downloads",
    "issues_url": "https://api.github.com/repos/Octocoders/Hello-World/issues{/number}",
    "pulls_url": "https://api.github.com/repos/Octocoders/Hello-World/pulls{/number}",
    "milestones_url": "https://api.github.com/repos/Octocoders/Hello-World/milestones{/number}",
    "notifications_url": "https://api.github.com/repos/Octocoders/Hello-World/notifications{?since,all,participating}",
    "labels_url": "https://api.github.com/repos/Octocoders/Hello-World/labels{/name}",
    "releases_url": "https://api.github.com/repos/Octocoders/Hello-World/releases{/id}",
    "deployments_url": "https://api.github.com/repos/Octocoders/Hello-World/deployments",
    "created_at": "2019-05-15T15:20:42Z",
    "updated_at": "2019-05-15T15:20:45Z",
    "pushed_at": "2019-05-15T15:20:33Z",
    "git_url": "git://github.com/Octocoders/Hello-World.git",
    "ssh_url": "git@github.com:Octocoders/Hello-World.git",
    "clone_url": "https://github.com/Octocoders/Hello-World.git",
    "svn_url": "https://github.com/Octocoders/Hello-World",
    "homepage": null,
    "size": 0,
    "stargazers_count": 0,
    "watchers_count": 0,
    "language": "Ruby",
    "has_issues": false,
    "has_projects": true,
    "has_downloads": true,
    "has_wiki": true,
    "has_pages": false,
    "forks_count": 0,
    "mirror_url": null,
    "archived": false,
    "disabled": false,
    "open_issues_count": 0,
    "license": null,
    "forks": 0,
    "open_issues": 0,
    "watchers": 0,
    "default_branch": "master"
  },
  "sender": {
    "login": "Codertocat",
    "id": 21031067,
    "node_id": "MDQ6VXNlcjIxMDMxMDY3",
    "avatar_url": "https://avatars1.githubusercontent.com/u/21031067?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/Codertocat",
    "html_url": "https://github.com/Codertocat",
    "followers_url": "https://api.github.com/users/Codertocat/followers",
    "following_url": "https://api.github.com/users/Codertocat/following{/other_user}",
    "gists_url": "https://api.github.com/users/Codertocat/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/Codertocat/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/Codertocat/subscriptions",
    "organizations_url": "https://api.github.com/users/Codertocat/orgs",
    "repos_url": "https://api.github.com/users/Codertocat/repos",
    "events_url": "https://api.github.com/users/Codertocat/events{/privacy}",
    "received_events_url": "https://api.github.com/users/Codertocat/received_events",
    "type": "User",
    "site_admin": false
  }
};