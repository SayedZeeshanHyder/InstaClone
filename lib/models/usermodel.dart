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

  UserModel(
      {this.name,
        this.profileUrl,
        this.followers,
        this.following,
        this.createdAt,
        this.heartActivities,
        this.searchHistory,
        this.bio,
        this.posts});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bio = json["bio"];
    profileUrl = json['profileUrl'];
    followers = json['followers'].cast<String>();
    following = json['following'].cast<String>();
    createdAt = json['createdAt'];
    if (json['heartActivities'] != null) {
      heartActivities = <HeartActivities>[];
      json['heartActivities'].forEach((v) {
        heartActivities!.add(HeartActivities.fromJson(v));
      });
    }
    searchHistory = json['searchHistory'].cast<String>();
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
    data['bio'] = bio;
    // ignore: unnecessary_this
    data['profileUrl'] = this.profileUrl;
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
  String? caption;
  List<String>? img;
  List<String>? likes;
  List<Comments>? comments;

  Posts({this.caption, this.img, this.likes, this.comments});

  Posts.fromJson(Map<String, dynamic> json) {
    caption = json['caption'];
    img = json['img'].cast<String>();
    likes = json['likes'].cast<String>();
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['caption'] = caption;
    data['img'] = img;
    data['likes'] = likes;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
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