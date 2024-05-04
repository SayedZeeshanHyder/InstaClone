class UserModel {
  String? name;
  String? profileUrl;
  List<String>? followers;
  List<String>? following;
  DateTime? createdAt;
  List<HeartActivities>? heartActivities;
  List<String>? searchHistory;
  List<Posts>? posts;
  String? bio;
  String? webLink;
  String? email;
  String? phone;
  String? gender;
  String? uid;

  UserModel(
      {this.name,
        this.email,
        this.phone,
        this.gender,
        this.profileUrl,
        this.followers,
        this.following,
        this.createdAt,
        this.heartActivities,
        this.searchHistory,
        this.bio,
        this.webLink,
        this.uid,
        this.posts});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    uid = json['uid'] ?? "";
    webLink = json['webLink'] ?? "";
    phone = json['phone'] ?? "";
    gender = json['gender'] ?? "";
    email = json['email'] ?? "";
    bio = json["bio"] ?? "";
    profileUrl = json['profileUrl'] ?? "";
    followers = json['followers'].cast<String>() ?? [];
    following = json['following'].cast<String>() ?? [];
    createdAt = json['createdAt'] ?? DateTime.now();
    if (json['heartActivities'] != null) {
      heartActivities = <HeartActivities>[];
      json['heartActivities'].forEach((v) {
        heartActivities!.add(HeartActivities.fromJson(v));
      });
    }
    searchHistory = json['searchHistory'].cast<String>() ?? [];
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['gender'] = gender;
    data['phone'] = phone;
    data['webLink'] = webLink;
    data['email'] = email;
    data['bio'] = bio;
    data['uid'] = uid;
    data['profileUrl'] = profileUrl;
    data['followers'] = followers;
    data['following'] = following;
    data['createdAt'] = createdAt;
    if (heartActivities != null) {
      data['heartActivities'] =
          heartActivities!.map((v) => v.toJson()).toList();
    }
    data['searchHistory'] = searchHistory;
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HeartActivities {
  String? heartImg;
  String? title;
  String? body;

  HeartActivities({this.heartImg, this.title, this.body});

  HeartActivities.fromJson(Map<String, dynamic> json) {
    heartImg = json['heartImg'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['heartImg'] = heartImg;
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}

class Posts {
  Posts({
    required this.tags,
    required this.by,
    required this.uid,
    required this.isImage,
    required this.images,
    required this.caption,
    required this.comments,
    required this.likes,
    required this.profileUrl,
    required this.time,
  });
  late final List<dynamic> tags;
  late final String by;
  late final String uid;
  late final bool isImage;
  late final List<dynamic> images;
  late final String caption;
  late final List<dynamic> comments;
  late final List<dynamic> likes;
  late final String profileUrl;
  late final DateTime time;
  late final String postId;
  late final List<dynamic> notification;

  Posts.fromJson(Map<String, dynamic> json){
    tags = json['tags'];
    postId = json['postId'];
    by = json['by'];
    uid = json['uid'];
    isImage = json['isImage'];
    images = List.castFrom<dynamic, dynamic>(json['images']);
    caption = json['caption'];
    comments = List.castFrom<dynamic, dynamic>(json['comments']);
    likes = List.castFrom<dynamic, dynamic>(json['likes']);
    profileUrl = json['profileUrl'];
    time = json['time'];
    notification = List.castFrom<dynamic, dynamic>(json['notification']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['postId'] = postId;
    data['notification'] = notification;
    data['tags'] = tags;
    data['by'] = by;
    data['uid'] = uid;
    data['isImage'] = isImage;
    data['images'] = images;
    data['caption'] = caption;
    data['comments'] = comments;
    data['likes'] = likes;
    data['profileUrl'] = profileUrl;
    data['time'] = time;
    return data;
  }
}

class Comments {
  String? time;
  String? profileUrl;
  String? by;
  String? message;
  List<Replies>? replies;

  Comments({this.time, this.profileUrl, this.by, this.message, this.replies});

  Comments.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    profileUrl = json['profileUrl'];
    by = json['by'];
    message = json['message'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['profileUrl'] = profileUrl;
    data['by'] = by;
    data['message'] = message;
    if (replies != null) {
      data['replies'] = replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Replies {
  String? by;
  String? reply;

  Replies({this.by, this.reply});

  Replies.fromJson(Map<String, dynamic> json) {
    by = json['by'];
    reply = json['reply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['by'] = by;
    data['reply'] = reply;
    return data;
  }
}
