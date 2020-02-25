import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) =>
    List<NotificationModel>.from(
        json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  String id;
  Repository repository;
  Subject subject;
  String reason;
  bool unread;
  String url;

  NotificationModel({
    this.id,
    this.repository,
    this.subject,
    this.reason,
    this.unread,
    this.url,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        repository: Repository.fromJson(json["repository"]),
        subject: Subject.fromJson(json["subject"]),
        reason: json["reason"],
        unread: json["unread"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "repository": repository.toJson(),
        "subject": subject.toJson(),
        "reason": reason,
        "unread": unread,
        "url": url,
      };
}

List<Repository> repositoryListFromJson(dynamic list) =>
    List<Repository>.from(list.map((x) => Repository.fromJson(x)));

class Repository {
  int id;
  String nodeId;
  String name;
  String fullName;
  Owner owner;
  bool private;
  String htmlUrl;
  String description;
  bool fork;
  String url;
  String archiveUrl;
  String assigneesUrl;
  String blobsUrl;
  String branchesUrl;
  String collaboratorsUrl;
  String commentsUrl;
  String commitsUrl;
  String compareUrl;
  String contentsUrl;
  String contributorsUrl;
  String deploymentsUrl;
  String downloadsUrl;
  String eventsUrl;
  String forksUrl;
  String gitCommitsUrl;
  String gitRefsUrl;
  String gitTagsUrl;
  String gitUrl;
  String issueCommentUrl;
  String issueEventsUrl;
  String issuesUrl;
  String keysUrl;
  String labelsUrl;
  String languagesUrl;
  String mergesUrl;
  String milestonesUrl;
  String notificationsUrl;
  String pullsUrl;
  String releasesUrl;
  String sshUrl;
  String stargazersUrl;
  String statusesUrl;
  String subscribersUrl;
  String subscriptionUrl;
  String tagsUrl;
  String teamsUrl;
  String treesUrl;
  String createAt;
  String updatedAt;
  String pushedAt;
  int stargazersCount;
  int watchersCount;
  String homePage;
  String language;
  int forksCount;
  int openIssuesCount;
  License license;

  Repository({
    this.id,
    this.nodeId,
    this.name,
    this.fullName,
    this.owner,
    this.private,
    this.htmlUrl,
    this.description,
    this.fork,
    this.url,
    this.archiveUrl,
    this.assigneesUrl,
    this.blobsUrl,
    this.branchesUrl,
    this.collaboratorsUrl,
    this.commentsUrl,
    this.commitsUrl,
    this.compareUrl,
    this.contentsUrl,
    this.contributorsUrl,
    this.deploymentsUrl,
    this.downloadsUrl,
    this.eventsUrl,
    this.forksUrl,
    this.gitCommitsUrl,
    this.gitRefsUrl,
    this.gitTagsUrl,
    this.gitUrl,
    this.issueCommentUrl,
    this.issueEventsUrl,
    this.issuesUrl,
    this.keysUrl,
    this.labelsUrl,
    this.languagesUrl,
    this.mergesUrl,
    this.milestonesUrl,
    this.notificationsUrl,
    this.pullsUrl,
    this.releasesUrl,
    this.sshUrl,
    this.stargazersUrl,
    this.statusesUrl,
    this.subscribersUrl,
    this.subscriptionUrl,
    this.tagsUrl,
    this.teamsUrl,
    this.treesUrl,
    this.createAt,
    this.updatedAt,
    this.pushedAt,
    this.stargazersCount,
    this.watchersCount,
    this.homePage,
    this.language,
    this.forksCount,
    this.openIssuesCount,
    this.license,
  });

  factory Repository.fromJson(Map<String, dynamic> json) => Repository(
        id: json["id"],
        nodeId: json["node_id"],
        name: json["name"],
        fullName: json["full_name"],
        owner: Owner.fromJson(json["owner"]),
        private: json["private"],
        htmlUrl: json["html_url"],
        description: json["description"],
        fork: json["fork"],
        url: json["url"],
        archiveUrl: json["archive_url"],
        assigneesUrl: json["assignees_url"],
        blobsUrl: json["blobs_url"],
        branchesUrl: json["branches_url"],
        collaboratorsUrl: json["collaborators_url"],
        commentsUrl: json["comments_url"],
        commitsUrl: json["commits_url"],
        compareUrl: json["compare_url"],
        contentsUrl: json["contents_url"],
        contributorsUrl: json["contributors_url"],
        deploymentsUrl: json["deployments_url"],
        downloadsUrl: json["downloads_url"],
        eventsUrl: json["events_url"],
        forksUrl: json["forks_url"],
        gitCommitsUrl: json["git_commits_url"],
        gitRefsUrl: json["git_refs_url"],
        gitTagsUrl: json["git_tags_url"],
        gitUrl: json["git_url"],
        issueCommentUrl: json["issue_comment_url"],
        issueEventsUrl: json["issue_events_url"],
        issuesUrl: json["issues_url"],
        keysUrl: json["keys_url"],
        labelsUrl: json["labels_url"],
        languagesUrl: json["languages_url"],
        mergesUrl: json["merges_url"],
        milestonesUrl: json["milestones_url"],
        notificationsUrl: json["notifications_url"],
        pullsUrl: json["pulls_url"],
        releasesUrl: json["releases_url"],
        sshUrl: json["ssh_url"],
        stargazersUrl: json["stargazers_url"],
        statusesUrl: json["statuses_url"],
        subscribersUrl: json["subscribers_url"],
        subscriptionUrl: json["subscription_url"],
        tagsUrl: json["tags_url"],
        teamsUrl: json["teams_url"],
        treesUrl: json["trees_url"],
        createAt: json['created_at'],
        updatedAt: json['updated_at'],
        pushedAt: json['pushed_at'],
        stargazersCount: json['stargazers_count'],
        watchersCount: json['watchers_count'],
        homePage: json['homePage'],
        language: json['language'],
        forksCount: json['forks_count'],
        openIssuesCount: json['open_issues_count'],
        license: License.fromJson(json['license']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "node_id": nodeId,
        "name": name,
        "full_name": fullName,
        "owner": owner.toJson(),
        "private": private,
        "html_url": htmlUrl,
        "description": description,
        "fork": fork,
        "url": url,
        "archive_url": archiveUrl,
        "assignees_url": assigneesUrl,
        "blobs_url": blobsUrl,
        "branches_url": branchesUrl,
        "collaborators_url": collaboratorsUrl,
        "comments_url": commentsUrl,
        "commits_url": commitsUrl,
        "compare_url": compareUrl,
        "contents_url": contentsUrl,
        "contributors_url": contributorsUrl,
        "deployments_url": deploymentsUrl,
        "downloads_url": downloadsUrl,
        "events_url": eventsUrl,
        "forks_url": forksUrl,
        "git_commits_url": gitCommitsUrl,
        "git_refs_url": gitRefsUrl,
        "git_tags_url": gitTagsUrl,
        "git_url": gitUrl,
        "issue_comment_url": issueCommentUrl,
        "issue_events_url": issueEventsUrl,
        "issues_url": issuesUrl,
        "keys_url": keysUrl,
        "labels_url": labelsUrl,
        "languages_url": languagesUrl,
        "merges_url": mergesUrl,
        "milestones_url": milestonesUrl,
        "notifications_url": notificationsUrl,
        "pulls_url": pullsUrl,
        "releases_url": releasesUrl,
        "ssh_url": sshUrl,
        "stargazers_url": stargazersUrl,
        "statuses_url": statusesUrl,
        "subscribers_url": subscribersUrl,
        "subscription_url": subscriptionUrl,
        "tags_url": tagsUrl,
        "teams_url": teamsUrl,
        "trees_url": treesUrl,
      };
}

class License {
  String name;

  License({this.name});

  factory License.fromJson(Map<String, dynamic> json) =>
      json == null ? null : License(name: json['name']);
}

class Owner {
  String login;
  int id;
  String nodeId;
  String avatarUrl;
  String gravatarId;
  String url;
  String htmlUrl;
  String followersUrl;
  String followingUrl;
  String gistsUrl;
  String starredUrl;
  String subscriptionsUrl;
  String organizationsUrl;
  String reposUrl;
  String eventsUrl;
  String receivedEventsUrl;
  String type;
  bool siteAdmin;

  Owner({
    this.login,
    this.id,
    this.nodeId,
    this.avatarUrl,
    this.gravatarId,
    this.url,
    this.htmlUrl,
    this.followersUrl,
    this.followingUrl,
    this.gistsUrl,
    this.starredUrl,
    this.subscriptionsUrl,
    this.organizationsUrl,
    this.reposUrl,
    this.eventsUrl,
    this.receivedEventsUrl,
    this.type,
    this.siteAdmin,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        login: json["login"],
        id: json["id"],
        nodeId: json["node_id"],
        avatarUrl: json["avatar_url"],
        gravatarId: json["gravatar_id"],
        url: json["url"],
        htmlUrl: json["html_url"],
        followersUrl: json["followers_url"],
        followingUrl: json["following_url"],
        gistsUrl: json["gists_url"],
        starredUrl: json["starred_url"],
        subscriptionsUrl: json["subscriptions_url"],
        organizationsUrl: json["organizations_url"],
        reposUrl: json["repos_url"],
        eventsUrl: json["events_url"],
        receivedEventsUrl: json["received_events_url"],
        type: json["type"],
        siteAdmin: json["site_admin"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "id": id,
        "node_id": nodeId,
        "avatar_url": avatarUrl,
        "gravatar_id": gravatarId,
        "url": url,
        "html_url": htmlUrl,
        "followers_url": followersUrl,
        "following_url": followingUrl,
        "gists_url": gistsUrl,
        "starred_url": starredUrl,
        "subscriptions_url": subscriptionsUrl,
        "organizations_url": organizationsUrl,
        "repos_url": reposUrl,
        "events_url": eventsUrl,
        "received_events_url": receivedEventsUrl,
        "type": type,
        "site_admin": siteAdmin,
      };
}

class Subject {
  String title;
  String url;
  String latestCommentUrl;
  String type;

  Subject({
    this.title,
    this.url,
    this.latestCommentUrl,
    this.type,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        title: json["title"],
        url: json["url"],
        latestCommentUrl: json["latest_comment_url"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "url": url,
        "latest_comment_url": latestCommentUrl,
        "type": type,
      };
}
