// To parse this JSON data, do
//
//     final exploreVideoData = exploreVideoDataFromJson(jsonString);

import 'dart:convert';

ExploreVideoData exploreVideoDataFromJson(String str) => ExploreVideoData.fromJson(json.decode(str));

String exploreVideoDataToJson(ExploreVideoData data) => json.encode(data.toJson());

class ExploreVideoData {
  String? cursor;
  Extra? extra;
  bool? hasMore;
  List<ItemList>? itemList;
  LogPb? logPb;
  int? statusCode;
  int? exploreVideoDataStatusCode;
  String? statusMsg;

  ExploreVideoData({
    this.cursor,
    this.extra,
    this.hasMore,
    this.itemList,
    this.logPb,
    this.statusCode,
    this.exploreVideoDataStatusCode,
    this.statusMsg,
  });

  factory ExploreVideoData.fromJson(Map<String, dynamic> json) => ExploreVideoData(
    cursor: json["cursor"],
    extra: json["extra"] == null ? null : Extra.fromJson(json["extra"]),
    hasMore: json["hasMore"],
    itemList: json["itemList"] == null ? [] : List<ItemList>.from(json["itemList"]!.map((x) => ItemList.fromJson(x))),
    logPb: json["log_pb"] == null ? null : LogPb.fromJson(json["log_pb"]),
    statusCode: json["statusCode"],
    exploreVideoDataStatusCode: json["status_code"],
    statusMsg: json["status_msg"],
  );

  Map<String, dynamic> toJson() => {
    "cursor": cursor,
    "extra": extra?.toJson(),
    "hasMore": hasMore,
    "itemList": itemList == null ? [] : List<dynamic>.from(itemList!.map((x) => x.toJson())),
    "log_pb": logPb?.toJson(),
    "statusCode": statusCode,
    "status_code": exploreVideoDataStatusCode,
    "status_msg": statusMsg,
  };
}

class Extra {
  List<dynamic>? fatalItemIds;
  String? logid;
  int? now;

  Extra({
    this.fatalItemIds,
    this.logid,
    this.now,
  });

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
    fatalItemIds: json["fatal_item_ids"] == null ? [] : List<dynamic>.from(json["fatal_item_ids"]!.map((x) => x)),
    logid: json["logid"],
    now: json["now"],
  );

  Map<String, dynamic> toJson() => {
    "fatal_item_ids": fatalItemIds == null ? [] : List<dynamic>.from(fatalItemIds!.map((x) => x)),
    "logid": logid,
    "now": now,
  };
}

class ItemList {
  String? aigcDescription;
  int? categoryType;
  Author? author;
  AuthorStats? authorStats;
  String? backendSourceEventTracking;
  bool? collected;
  List<Content>? contents;
  int? createTime;
  String? desc;
  bool? digged;
  int? diversificationId;
  int? duetDisplay;
  bool? duetEnabled;
  bool? forFriend;
  String? id;
  bool? isAd;
  int? itemCommentStatus;
  ItemControl? itemControl;
  Music? music;
  bool? officalItem;
  bool? originalItem;
  bool? privateItem;
  bool? secret;
  bool? shareEnabled;
  Stats? stats;
  StatsV2? statsV2;
  int? stitchDisplay;
  bool? stitchEnabled;
  List<TextExtra>? textExtra;
  TextLanguage? textLanguage;
  bool? textTranslatable;
  Video? video;
  List<Challenge>? challenges;
  List<StickersOnItem>? stickersOnItem;
  List<Anchor>? anchors;
  Poi? poi;
  String? playlistId;
  VideoSuggestWordsList? videoSuggestWordsList;

  ItemList({
    this.aigcDescription,
    this.categoryType,
    this.author,
    this.authorStats,
    this.backendSourceEventTracking,
    this.collected,
    this.contents,
    this.createTime,
    this.desc,
    this.digged,
    this.diversificationId,
    this.duetDisplay,
    this.duetEnabled,
    this.forFriend,
    this.id,
    this.isAd,
    this.itemCommentStatus,
    this.itemControl,
    this.music,
    this.officalItem,
    this.originalItem,
    this.privateItem,
    this.secret,
    this.shareEnabled,
    this.stats,
    this.statsV2,
    this.stitchDisplay,
    this.stitchEnabled,
    this.textExtra,
    this.textLanguage,
    this.textTranslatable,
    this.video,
    this.challenges,
    this.stickersOnItem,
    this.anchors,
    this.poi,
    this.playlistId,
    this.videoSuggestWordsList,
  });

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
    aigcDescription: json["AIGCDescription"],
    categoryType: json["CategoryType"],
    author: json["author"] == null ? null : Author.fromJson(json["author"]),
    authorStats: json["authorStats"] == null ? null : AuthorStats.fromJson(json["authorStats"]),
    backendSourceEventTracking: json["backendSourceEventTracking"],
    collected: json["collected"],
    contents: json["contents"] == null ? [] : List<Content>.from(json["contents"]!.map((x) => Content.fromJson(x))),
    createTime: json["createTime"],
    desc: json["desc"],
    digged: json["digged"],
    diversificationId: json["diversificationId"],
    duetDisplay: json["duetDisplay"],
    duetEnabled: json["duetEnabled"],
    forFriend: json["forFriend"],
    id: json["id"],
    isAd: json["isAd"],
    itemCommentStatus: json["itemCommentStatus"],
    itemControl: json["item_control"] == null ? null : ItemControl.fromJson(json["item_control"]),
    music: json["music"] == null ? null : Music.fromJson(json["music"]),
    officalItem: json["officalItem"],
    originalItem: json["originalItem"],
    privateItem: json["privateItem"],
    secret: json["secret"],
    shareEnabled: json["shareEnabled"],
    stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
    statsV2: json["statsV2"] == null ? null : StatsV2.fromJson(json["statsV2"]),
    stitchDisplay: json["stitchDisplay"],
    stitchEnabled: json["stitchEnabled"],
    textExtra: json["textExtra"] == null ? [] : List<TextExtra>.from(json["textExtra"]!.map((x) => TextExtra.fromJson(x))),
    textTranslatable: json["textTranslatable"],
    video: json["video"] == null ? null : Video.fromJson(json["video"]),
    challenges: json["challenges"] == null ? [] : List<Challenge>.from(json["challenges"]!.map((x) => Challenge.fromJson(x))),
    stickersOnItem: json["stickersOnItem"] == null ? [] : List<StickersOnItem>.from(json["stickersOnItem"]!.map((x) => StickersOnItem.fromJson(x))),
    anchors: json["anchors"] == null ? [] : List<Anchor>.from(json["anchors"]!.map((x) => Anchor.fromJson(x))),
    poi: json["poi"] == null ? null : Poi.fromJson(json["poi"]),
    playlistId: json["playlistId"],
    videoSuggestWordsList: json["videoSuggestWordsList"] == null ? null : VideoSuggestWordsList.fromJson(json["videoSuggestWordsList"]),
  );

  Map<String, dynamic> toJson() => {
    "AIGCDescription": aigcDescription,
    "CategoryType": categoryType,
    "author": author?.toJson(),
    "authorStats": authorStats?.toJson(),
    "backendSourceEventTracking": backendSourceEventTracking,
    "collected": collected,
    "contents": contents == null ? [] : List<dynamic>.from(contents!.map((x) => x.toJson())),
    "createTime": createTime,
    "desc": desc,
    "digged": digged,
    "diversificationId": diversificationId,
    "duetDisplay": duetDisplay,
    "duetEnabled": duetEnabled,
    "forFriend": forFriend,
    "id": id,
    "isAd": isAd,
    "itemCommentStatus": itemCommentStatus,
    "item_control": itemControl?.toJson(),
    "music": music?.toJson(),
    "officalItem": officalItem,
    "originalItem": originalItem,
    "privateItem": privateItem,
    "secret": secret,
    "shareEnabled": shareEnabled,
    "stats": stats?.toJson(),
    "statsV2": statsV2?.toJson(),
    "stitchDisplay": stitchDisplay,
    "stitchEnabled": stitchEnabled,
    "textExtra": textExtra == null ? [] : List<dynamic>.from(textExtra!.map((x) => x.toJson())),
    "textLanguage": textLanguageValues.reverse[textLanguage],
    "textTranslatable": textTranslatable,
    "video": video?.toJson(),
    "challenges": challenges == null ? [] : List<dynamic>.from(challenges!.map((x) => x.toJson())),
    "stickersOnItem": stickersOnItem == null ? [] : List<dynamic>.from(stickersOnItem!.map((x) => x.toJson())),
    "anchors": anchors == null ? [] : List<dynamic>.from(anchors!.map((x) => x.toJson())),
    "poi": poi?.toJson(),
    "playlistId": playlistId,
    "videoSuggestWordsList": videoSuggestWordsList?.toJson(),
  };
}

class Anchor {
  String? description;
  ExtraInfo? extraInfo;
  Icon? icon;
  String? id;
  String? keyword;
  Thumbnail? thumbnail;
  int? type;

  Anchor({
    this.description,
    this.extraInfo,
    this.icon,
    this.id,
    this.keyword,
    this.thumbnail,
    this.type,
  });

  factory Anchor.fromJson(Map<String, dynamic> json) => Anchor(
    description: json["description"],
    extraInfo: json["extraInfo"] == null ? null : ExtraInfo.fromJson(json["extraInfo"]),
    icon: json["icon"] == null ? null : Icon.fromJson(json["icon"]),
    id: json["id"],
    keyword: json["keyword"],
    thumbnail: json["thumbnail"] == null ? null : Thumbnail.fromJson(json["thumbnail"]),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "extraInfo": extraInfo?.toJson(),
    "icon": icon?.toJson(),
    "id": id,
    "keyword": keyword,
    "thumbnail": thumbnail?.toJson(),
    "type": type,
  };
}

class ExtraInfo {
  String? subtype;

  ExtraInfo({
    this.subtype,
  });

  factory ExtraInfo.fromJson(Map<String, dynamic> json) => ExtraInfo(
    subtype: json["subtype"],
  );

  Map<String, dynamic> toJson() => {
    "subtype": subtype,
  };
}

class Icon {
  List<String>? urlList;

  Icon({
    this.urlList,
  });

  factory Icon.fromJson(Map<String, dynamic> json) => Icon(
    urlList: json["urlList"] == null ? [] : List<String>.from(json["urlList"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "urlList": urlList == null ? [] : List<dynamic>.from(urlList!.map((x) => x)),
  };
}

class Thumbnail {
  int? height;
  List<String>? urlList;
  int? width;

  Thumbnail({
    this.height,
    this.urlList,
    this.width,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
    height: json["height"],
    urlList: json["urlList"] == null ? [] : List<String>.from(json["urlList"]!.map((x) => x)),
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "height": height,
    "urlList": urlList == null ? [] : List<dynamic>.from(urlList!.map((x) => x)),
    "width": width,
  };
}

class Author {
  String? avatarLarger;
  String? avatarMedium;
  String? avatarThumb;
  int? commentSetting;
  int? downloadSetting;
  int? duetSetting;
  bool? ftc;
  String? id;
  bool? isAdVirtual;
  bool? isEmbedBanned;
  String? nickname;
  bool? openFavorite;
  bool? privateAccount;
  int? relation;
  String? secUid;
  bool? secret;
  String? signature;
  int? stitchSetting;
  String? uniqueId;
  bool? verified;

  Author({
    this.avatarLarger,
    this.avatarMedium,
    this.avatarThumb,
    this.commentSetting,
    this.downloadSetting,
    this.duetSetting,
    this.ftc,
    this.id,
    this.isAdVirtual,
    this.isEmbedBanned,
    this.nickname,
    this.openFavorite,
    this.privateAccount,
    this.relation,
    this.secUid,
    this.secret,
    this.signature,
    this.stitchSetting,
    this.uniqueId,
    this.verified,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    avatarLarger: json["avatarLarger"],
    avatarMedium: json["avatarMedium"],
    avatarThumb: json["avatarThumb"],
    commentSetting: json["commentSetting"],
    downloadSetting: json["downloadSetting"],
    duetSetting: json["duetSetting"],
    ftc: json["ftc"],
    id: json["id"],
    isAdVirtual: json["isADVirtual"],
    isEmbedBanned: json["isEmbedBanned"],
    nickname: json["nickname"],
    openFavorite: json["openFavorite"],
    privateAccount: json["privateAccount"],
    relation: json["relation"],
    secUid: json["secUid"],
    secret: json["secret"],
    signature: json["signature"],
    stitchSetting: json["stitchSetting"],
    uniqueId: json["uniqueId"],
    verified: json["verified"],
  );

  Map<String, dynamic> toJson() => {
    "avatarLarger": avatarLarger,
    "avatarMedium": avatarMedium,
    "avatarThumb": avatarThumb,
    "commentSetting": commentSetting,
    "downloadSetting": downloadSetting,
    "duetSetting": duetSetting,
    "ftc": ftc,
    "id": id,
    "isADVirtual": isAdVirtual,
    "isEmbedBanned": isEmbedBanned,
    "nickname": nickname,
    "openFavorite": openFavorite,
    "privateAccount": privateAccount,
    "relation": relation,
    "secUid": secUid,
    "secret": secret,
    "signature": signature,
    "stitchSetting": stitchSetting,
    "uniqueId": uniqueId,
    "verified": verified,
  };
}

class AuthorStats {
  int? diggCount;
  int? followerCount;
  int? followingCount;
  int? friendCount;
  int? heart;
  int? heartCount;
  int? videoCount;

  AuthorStats({
    this.diggCount,
    this.followerCount,
    this.followingCount,
    this.friendCount,
    this.heart,
    this.heartCount,
    this.videoCount,
  });

  factory AuthorStats.fromJson(Map<String, dynamic> json) => AuthorStats(
    diggCount: json["diggCount"],
    followerCount: json["followerCount"],
    followingCount: json["followingCount"],
    friendCount: json["friendCount"],
    heart: json["heart"],
    heartCount: json["heartCount"],
    videoCount: json["videoCount"],
  );

  Map<String, dynamic> toJson() => {
    "diggCount": diggCount,
    "followerCount": followerCount,
    "followingCount": followingCount,
    "friendCount": friendCount,
    "heart": heart,
    "heartCount": heartCount,
    "videoCount": videoCount,
  };
}

class Challenge {
  String? coverLarger;
  String? coverMedium;
  String? coverThumb;
  String? desc;
  String? id;
  String? profileLarger;
  String? profileMedium;
  String? profileThumb;
  String? title;

  Challenge({
    this.coverLarger,
    this.coverMedium,
    this.coverThumb,
    this.desc,
    this.id,
    this.profileLarger,
    this.profileMedium,
    this.profileThumb,
    this.title,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) => Challenge(
    coverLarger: json["coverLarger"],
    coverMedium: json["coverMedium"],
    coverThumb: json["coverThumb"],
    desc: json["desc"],
    id: json["id"],
    profileLarger: json["profileLarger"],
    profileMedium: json["profileMedium"],
    profileThumb: json["profileThumb"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "coverLarger": coverLarger,
    "coverMedium": coverMedium,
    "coverThumb": coverThumb,
    "desc": desc,
    "id": id,
    "profileLarger": profileLarger,
    "profileMedium": profileMedium,
    "profileThumb": profileThumb,
    "title": title,
  };
}

class Content {
  String? desc;
  List<TextExtra>? textExtra;

  Content({
    this.desc,
    this.textExtra,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    desc: json["desc"],
    textExtra: json["textExtra"] == null ? [] : List<TextExtra>.from(json["textExtra"]!.map((x) => TextExtra.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "desc": desc,
    "textExtra": textExtra == null ? [] : List<dynamic>.from(textExtra!.map((x) => x.toJson())),
  };
}

class TextExtra {
  String? awemeId;
  int? end;
  String? hashtagName;
  bool? isCommerce;
  String? secUid;
  int? start;
  int? subType;
  int? type;
  String? userId;
  String? userUniqueId;

  TextExtra({
    this.awemeId,
    this.end,
    this.hashtagName,
    this.isCommerce,
    this.secUid,
    this.start,
    this.subType,
    this.type,
    this.userId,
    this.userUniqueId,
  });

  factory TextExtra.fromJson(Map<String, dynamic> json) => TextExtra(
    awemeId: json["awemeId"],
    end: json["end"],
    hashtagName: json["hashtagName"],
    isCommerce: json["isCommerce"],
    secUid: json["secUid"],
    start: json["start"],
    subType: json["subType"],
    type: json["type"],
    userId: json["userId"],
    userUniqueId: json["userUniqueId"],
  );

  Map<String, dynamic> toJson() => {
    "awemeId": awemeId,
    "end": end,
    "hashtagName": hashtagName,
    "isCommerce": isCommerce,
    "secUid": secUid,
    "start": start,
    "subType": subType,
    "type": type,
    "userId": userId,
    "userUniqueId": userUniqueId,
  };
}

class ItemControl {
  bool? canRepost;

  ItemControl({
    this.canRepost,
  });

  factory ItemControl.fromJson(Map<String, dynamic> json) => ItemControl(
    canRepost: json["can_repost"],
  );

  Map<String, dynamic> toJson() => {
    "can_repost": canRepost,
  };
}

class Music {
  String? authorName;
  String? coverLarge;
  String? coverMedium;
  String? coverThumb;
  int? duration;
  String? id;
  bool? isCopyrighted;
  bool? original;
  String? playUrl;
  String? title;
  String? album;

  Music({
    this.authorName,
    this.coverLarge,
    this.coverMedium,
    this.coverThumb,
    this.duration,
    this.id,
    this.isCopyrighted,
    this.original,
    this.playUrl,
    this.title,
    this.album,
  });

  factory Music.fromJson(Map<String, dynamic> json) => Music(
    authorName: json["authorName"],
    coverLarge: json["coverLarge"],
    coverMedium: json["coverMedium"],
    coverThumb: json["coverThumb"],
    duration: json["duration"],
    id: json["id"],
    isCopyrighted: json["isCopyrighted"],
    original: json["original"],
    playUrl: json["playUrl"],
    title: json["title"],
    album: json["album"],
  );

  Map<String, dynamic> toJson() => {
    "authorName": authorName,
    "coverLarge": coverLarge,
    "coverMedium": coverMedium,
    "coverThumb": coverThumb,
    "duration": duration,
    "id": id,
    "isCopyrighted": isCopyrighted,
    "original": original,
    "playUrl": playUrl,
    "title": title,
    "album": album,
  };
}

class Poi {
  String? address;
  String? category;
  String? city;
  String? cityCode;
  String? country;
  String? countryCode;
  String? fatherPoiId;
  String? fatherPoiName;
  String? id;
  String? name;
  String? province;
  String? ttTypeCode;
  String? ttTypeNameMedium;
  String? ttTypeNameSuper;
  String? ttTypeNameTiny;
  int? type;
  String? typeCode;

  Poi({
    this.address,
    this.category,
    this.city,
    this.cityCode,
    this.country,
    this.countryCode,
    this.fatherPoiId,
    this.fatherPoiName,
    this.id,
    this.name,
    this.province,
    this.ttTypeCode,
    this.ttTypeNameMedium,
    this.ttTypeNameSuper,
    this.ttTypeNameTiny,
    this.type,
    this.typeCode,
  });

  factory Poi.fromJson(Map<String, dynamic> json) => Poi(
    address: json["address"],
    category: json["category"],
    city: json["city"],
    cityCode: json["cityCode"],
    country: json["country"],
    countryCode: json["countryCode"],
    fatherPoiId: json["fatherPoiId"],
    fatherPoiName: json["fatherPoiName"],
    id: json["id"],
    name: json["name"],
    province: json["province"],
    ttTypeCode: json["ttTypeCode"],
    ttTypeNameMedium: json["ttTypeNameMedium"],
    ttTypeNameSuper: json["ttTypeNameSuper"],
    ttTypeNameTiny: json["ttTypeNameTiny"],
    type: json["type"],
    typeCode: json["typeCode"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "category": category,
    "city": city,
    "cityCode": cityCode,
    "country": country,
    "countryCode": countryCode,
    "fatherPoiId": fatherPoiId,
    "fatherPoiName": fatherPoiName,
    "id": id,
    "name": name,
    "province": province,
    "ttTypeCode": ttTypeCode,
    "ttTypeNameMedium": ttTypeNameMedium,
    "ttTypeNameSuper": ttTypeNameSuper,
    "ttTypeNameTiny": ttTypeNameTiny,
    "type": type,
    "typeCode": typeCode,
  };
}

class Stats {
  int? collectCount;
  int? commentCount;
  int? diggCount;
  int? playCount;
  int? shareCount;

  Stats({
    this.collectCount,
    this.commentCount,
    this.diggCount,
    this.playCount,
    this.shareCount,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    collectCount: json["collectCount"],
    commentCount: json["commentCount"],
    diggCount: json["diggCount"],
    playCount: json["playCount"],
    shareCount: json["shareCount"],
  );

  Map<String, dynamic> toJson() => {
    "collectCount": collectCount,
    "commentCount": commentCount,
    "diggCount": diggCount,
    "playCount": playCount,
    "shareCount": shareCount,
  };
}

class StatsV2 {
  String? collectCount;
  String? commentCount;
  String? diggCount;
  String? playCount;
  String? repostCount;
  String? shareCount;

  StatsV2({
    this.collectCount,
    this.commentCount,
    this.diggCount,
    this.playCount,
    this.repostCount,
    this.shareCount,
  });

  factory StatsV2.fromJson(Map<String, dynamic> json) => StatsV2(
    collectCount: json["collectCount"],
    commentCount: json["commentCount"],
    diggCount: json["diggCount"],
    playCount: json["playCount"],
    repostCount: json["repostCount"],
    shareCount: json["shareCount"],
  );

  Map<String, dynamic> toJson() => {
    "collectCount": collectCount,
    "commentCount": commentCount,
    "diggCount": diggCount,
    "playCount": playCount,
    "repostCount": repostCount,
    "shareCount": shareCount,
  };
}

class StickersOnItem {
  List<String>? stickerText;
  int? stickerType;

  StickersOnItem({
    this.stickerText,
    this.stickerType,
  });

  factory StickersOnItem.fromJson(Map<String, dynamic> json) => StickersOnItem(
    stickerText: json["stickerText"] == null ? [] : List<String>.from(json["stickerText"]!.map((x) => x)),
    stickerType: json["stickerType"],
  );

  Map<String, dynamic> toJson() => {
    "stickerText": stickerText == null ? [] : List<dynamic>.from(stickerText!.map((x) => x)),
    "stickerType": stickerType,
  };
}

enum TextLanguage {
  EN,
  UN
}

final textLanguageValues = EnumValues({
  "en": TextLanguage.EN,
  "un": TextLanguage.UN
});

class Video {
  String? vqScore;
  int? bitrate;
  List<BitrateInfo>? bitrateInfo;
  ClaInfo? claInfo;
  CodecType? codecType;
  String? cover;
  Definition? definition;
  String? downloadAddr;
  int? duration;
  String? dynamicCover;
  String? encodeUserTag;
  EncodedType? encodedType;
  VideoFormat? format;
  int? height;
  String? id;
  String? originCover;
  String? playAddr;
  Definition? ratio;
  EncodedType? videoQuality;
  VolumeInfo? volumeInfo;
  int? width;
  Map<String, String>? zoomCover;
  List<SubtitleInfo>? subtitleInfos;

  Video({
    this.vqScore,
    this.bitrate,
    this.bitrateInfo,
    this.claInfo,
    this.codecType,
    this.cover,
    this.definition,
    this.downloadAddr,
    this.duration,
    this.dynamicCover,
    this.encodeUserTag,
    this.encodedType,
    this.format,
    this.height,
    this.id,
    this.originCover,
    this.playAddr,
    this.ratio,
    this.videoQuality,
    this.volumeInfo,
    this.width,
    this.zoomCover,
    this.subtitleInfos,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    vqScore: json["VQScore"],
    bitrate: json["bitrate"],
    bitrateInfo: json["bitrateInfo"] == null ? [] : List<BitrateInfo>.from(json["bitrateInfo"]!.map((x) => BitrateInfo.fromJson(x))),
    claInfo: json["claInfo"] == null ? null : ClaInfo.fromJson(json["claInfo"]),
    codecType: codecTypeValues.map[json["codecType"]]!,
    cover: json["cover"],
    definition: definitionValues.map[json["definition"]]!,
    downloadAddr: json["downloadAddr"],
    duration: json["duration"],
    dynamicCover: json["dynamicCover"],
    encodeUserTag: json["encodeUserTag"],
    encodedType: encodedTypeValues.map[json["encodedType"]]!,
    format: videoFormatValues.map[json["format"]]!,
    height: json["height"],
    id: json["id"],
    originCover: json["originCover"],
    playAddr: json["playAddr"],
    ratio: definitionValues.map[json["ratio"]]!,
    videoQuality: encodedTypeValues.map[json["videoQuality"]]!,
    volumeInfo: json["volumeInfo"] == null ? null : VolumeInfo.fromJson(json["volumeInfo"]),
    width: json["width"],
    zoomCover: Map.from(json["zoomCover"]!).map((k, v) => MapEntry<String, String>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "VQScore": vqScore,
    "bitrate": bitrate,
    "bitrateInfo": bitrateInfo == null ? [] : List<dynamic>.from(bitrateInfo!.map((x) => x.toJson())),
    "claInfo": claInfo?.toJson(),
    "codecType": codecTypeValues.reverse[codecType],
    "cover": cover,
    "definition": definitionValues.reverse[definition],
    "downloadAddr": downloadAddr,
    "duration": duration,
    "dynamicCover": dynamicCover,
    "encodeUserTag": encodeUserTag,
    "encodedType": encodedTypeValues.reverse[encodedType],
    "format": videoFormatValues.reverse[format],
    "height": height,
    "id": id,
    "originCover": originCover,
    "playAddr": playAddr,
    "ratio": definitionValues.reverse[ratio],
    "videoQuality": encodedTypeValues.reverse[videoQuality],
    "volumeInfo": volumeInfo?.toJson(),
    "width": width,
    "zoomCover": Map.from(zoomCover!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "subtitleInfos": subtitleInfos == null ? [] : List<dynamic>.from(subtitleInfos!.map((x) => x.toJson())),
  };
}

class BitrateInfo {
  int? bitrate;
  CodecType? codecType;
  GearName? gearName;
  String? mvmaf;
  PlayAddr? playAddr;
  int? qualityType;

  BitrateInfo({
    this.bitrate,
    this.codecType,
    this.gearName,
    this.mvmaf,
    this.playAddr,
    this.qualityType,
  });

  factory BitrateInfo.fromJson(Map<String, dynamic> json) => BitrateInfo(
    bitrate: json["Bitrate"],
    codecType: codecTypeValues.map[json["CodecType"]]!,
    gearName: gearNameValues.map[json["GearName"]]!,
    mvmaf: json["MVMAF"],
    playAddr: json["PlayAddr"] == null ? null : PlayAddr.fromJson(json["PlayAddr"]),
    qualityType: json["QualityType"],
  );

  Map<String, dynamic> toJson() => {
    "Bitrate": bitrate,
    "CodecType": codecTypeValues.reverse[codecType],
    "GearName": gearNameValues.reverse[gearName],
    "MVMAF": mvmaf,
    "PlayAddr": playAddr?.toJson(),
    "QualityType": qualityType,
  };
}

enum CodecType {
  H264,
  H265_HVC1
}

final codecTypeValues = EnumValues({
  "h264": CodecType.H264,
  "h265_hvc1": CodecType.H265_HVC1
});

enum GearName {
  ADAPT_5401,
  ADAPT_LOWER_7201,
  ADAPT_LOWEST_10801,
  LOWER_5400,
  LOWEST_5400,
  NORMAL_5400
}

final gearNameValues = EnumValues({
  "adapt_540_1": GearName.ADAPT_5401,
  "adapt_lower_720_1": GearName.ADAPT_LOWER_7201,
  "adapt_lowest_1080_1": GearName.ADAPT_LOWEST_10801,
  "lower_540_0": GearName.LOWER_5400,
  "lowest_540_0": GearName.LOWEST_5400,
  "normal_540_0": GearName.NORMAL_5400
});

class PlayAddr {
  int? dataSize;
  String? fileCs;
  String? fileHash;
  int? height;
  String? uri;
  String? urlKey;
  List<String>? urlList;
  int? width;

  PlayAddr({
    this.dataSize,
    this.fileCs,
    this.fileHash,
    this.height,
    this.uri,
    this.urlKey,
    this.urlList,
    this.width,
  });

  factory PlayAddr.fromJson(Map<String, dynamic> json) => PlayAddr(
    dataSize: json["DataSize"],
    fileCs: json["FileCs"],
    fileHash: json["FileHash"],
    height: json["Height"],
    uri: json["Uri"],
    urlKey: json["UrlKey"],
    urlList: json["UrlList"] == null ? [] : List<String>.from(json["UrlList"]!.map((x) => x)),
    width: json["Width"],
  );

  Map<String, dynamic> toJson() => {
    "DataSize": dataSize,
    "FileCs": fileCs,
    "FileHash": fileHash,
    "Height": height,
    "Uri": uri,
    "UrlKey": urlKey,
    "UrlList": urlList == null ? [] : List<dynamic>.from(urlList!.map((x) => x)),
    "Width": width,
  };
}

class ClaInfo {
  bool? enableAutoCaption;
  bool? hasOriginalAudio;
  int? noCaptionReason;
  List<CaptionInfo>? captionInfos;
  int? captionsType;
  OriginalLanguageInfo? originalLanguageInfo;

  ClaInfo({
    this.enableAutoCaption,
    this.hasOriginalAudio,
    this.noCaptionReason,
    this.captionInfos,
    this.captionsType,
    this.originalLanguageInfo,
  });

  factory ClaInfo.fromJson(Map<String, dynamic> json) => ClaInfo(
    enableAutoCaption: json["enableAutoCaption"],
    hasOriginalAudio: json["hasOriginalAudio"],
    noCaptionReason: json["noCaptionReason"],
    captionInfos: json["captionInfos"] == null ? [] : List<CaptionInfo>.from(json["captionInfos"]!.map((x) => CaptionInfo.fromJson(x))),
    captionsType: json["captionsType"],
  );

  Map<String, dynamic> toJson() => {
    "enableAutoCaption": enableAutoCaption,
    "hasOriginalAudio": hasOriginalAudio,
    "noCaptionReason": noCaptionReason,
    "captionInfos": captionInfos == null ? [] : List<dynamic>.from(captionInfos!.map((x) => x.toJson())),
    "captionsType": captionsType,
    "originalLanguageInfo": originalLanguageInfo?.toJson(),
  };
}

class CaptionInfo {
  FormatEnum? captionFormat;
  String? claSubtitleId;
  String? expire;
  bool? isAutoGen;
  bool? isOriginalCaption;
  String? language;
  TextLanguage? languageCode;
  String? languageId;
  String? subId;
  String? subtitleType;
  String? translationType;
  String? url;
  List<String>? urlList;
  String? variant;

  CaptionInfo({
    this.captionFormat,
    this.claSubtitleId,
    this.expire,
    this.isAutoGen,
    this.isOriginalCaption,
    this.language,
    this.languageCode,
    this.languageId,
    this.subId,
    this.subtitleType,
    this.translationType,
    this.url,
    this.urlList,
    this.variant,
  });

  factory CaptionInfo.fromJson(Map<String, dynamic> json) => CaptionInfo(
    captionFormat: formatEnumValues.map[json["captionFormat"]]!,
    claSubtitleId: json["claSubtitleID"],
    expire: json["expire"],
    isAutoGen: json["isAutoGen"],
    isOriginalCaption: json["isOriginalCaption"],
    language: json["language"],
    languageId: json["languageID"],
    subId: json["subID"],
    subtitleType: json["subtitleType"],
    translationType: json["translationType"],
    url: json["url"],
    urlList: json["urlList"] == null ? [] : List<String>.from(json["urlList"]!.map((x) => x)),
    variant: json["variant"],
  );

  Map<String, dynamic> toJson() => {
    "captionFormat": formatEnumValues.reverse[captionFormat],
    "claSubtitleID": claSubtitleId,
    "expire": expire,
    "isAutoGen": isAutoGen,
    "isOriginalCaption": isOriginalCaption,
    "language": language,
    "languageCode": textLanguageValues.reverse[languageCode],
    "languageID": languageId,
    "subID": subId,
    "subtitleType": subtitleType,
    "translationType": translationType,
    "url": url,
    "urlList": urlList == null ? [] : List<dynamic>.from(urlList!.map((x) => x)),
    "variant": variant,
  };
}

enum FormatEnum {
  WEBVTT
}

final formatEnumValues = EnumValues({
  "webvtt": FormatEnum.WEBVTT
});

class OriginalLanguageInfo {
  bool? canTranslateRealTimeNoCheck;
  String? language;
  TextLanguage? languageCode;
  String? languageId;

  OriginalLanguageInfo({
    this.canTranslateRealTimeNoCheck,
    this.language,
    this.languageCode,
    this.languageId,
  });

  factory OriginalLanguageInfo.fromJson(Map<String, dynamic> json) => OriginalLanguageInfo(
    canTranslateRealTimeNoCheck: json["canTranslateRealTimeNoCheck"],
    language: json["language"],
    languageCode: textLanguageValues.map[json["languageCode"]]!,
    languageId: json["languageID"],
  );

  Map<String, dynamic> toJson() => {
    "canTranslateRealTimeNoCheck": canTranslateRealTimeNoCheck,
    "language": language,
    "languageCode": textLanguageValues.reverse[languageCode],
    "languageID": languageId,
  };
}

enum Definition {
  THE_540_P
}

final definitionValues = EnumValues({
  "540p": Definition.THE_540_P
});

enum EncodedType {
  NORMAL
}

final encodedTypeValues = EnumValues({
  "normal": EncodedType.NORMAL
});

enum VideoFormat {
  MP4
}

final videoFormatValues = EnumValues({
  "mp4": VideoFormat.MP4
});

class SubtitleInfo {
  FormatEnum? format;
  String? languageCodeName;
  String? languageId;
  int? size;
  Source? source;
  String? url;
  int? urlExpire;
  String? version;

  SubtitleInfo({
    this.format,
    this.languageCodeName,
    this.languageId,
    this.size,
    this.source,
    this.url,
    this.urlExpire,
    this.version,
  });

  factory SubtitleInfo.fromJson(Map<String, dynamic> json) => SubtitleInfo(
    languageCodeName: json["LanguageCodeName"],
    languageId: json["LanguageID"],
    size: json["Size"],
    url: json["Url"],
    urlExpire: json["UrlExpire"],
    version: json["Version"],
  );

  Map<String, dynamic> toJson() => {
    "Format": formatEnumValues.reverse[format],
    "LanguageCodeName": languageCodeName,
    "LanguageID": languageId,
    "Size": size,
    "Source": sourceValues.reverse[source],
    "Url": url,
    "UrlExpire": urlExpire,
    "Version": version,
  };
}

enum Source {
  ASR,
  MT
}

final sourceValues = EnumValues({
  "ASR": Source.ASR,
  "MT": Source.MT
});

class VolumeInfo {
  double? loudness;
  double? peak;

  VolumeInfo({
    this.loudness,
    this.peak,
  });

  factory VolumeInfo.fromJson(Map<String, dynamic> json) => VolumeInfo(
    loudness: json["Loudness"]?.toDouble(),
    peak: json["Peak"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "Loudness": loudness,
    "Peak": peak,
  };
}

class VideoSuggestWordsList {
  List<VideoSuggestWordsStruct>? videoSuggestWordsStruct;

  VideoSuggestWordsList({
    this.videoSuggestWordsStruct,
  });

  factory VideoSuggestWordsList.fromJson(Map<String, dynamic> json) => VideoSuggestWordsList(
    videoSuggestWordsStruct: json["video_suggest_words_struct"] == null ? [] : List<VideoSuggestWordsStruct>.from(json["video_suggest_words_struct"]!.map((x) => VideoSuggestWordsStruct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "video_suggest_words_struct": videoSuggestWordsStruct == null ? [] : List<dynamic>.from(videoSuggestWordsStruct!.map((x) => x.toJson())),
  };
}

class VideoSuggestWordsStruct {
  String? hintText;
  String? scene;
  List<Word>? words;

  VideoSuggestWordsStruct({
    this.hintText,
    this.scene,
    this.words,
  });

  factory VideoSuggestWordsStruct.fromJson(Map<String, dynamic> json) => VideoSuggestWordsStruct(
    hintText: json["hint_text"],
    scene: json["scene"],
    words: json["words"] == null ? [] : List<Word>.from(json["words"]!.map((x) => Word.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "hint_text": hintText,
    "scene": scene,
    "words": words == null ? [] : List<dynamic>.from(words!.map((x) => x.toJson())),
  };
}

class Word {
  String? word;
  String? wordId;

  Word({
    this.word,
    this.wordId,
  });

  factory Word.fromJson(Map<String, dynamic> json) => Word(
    word: json["word"],
    wordId: json["word_id"],
  );

  Map<String, dynamic> toJson() => {
    "word": word,
    "word_id": wordId,
  };
}

class LogPb {
  String? imprId;

  LogPb({
    this.imprId,
  });

  factory LogPb.fromJson(Map<String, dynamic> json) => LogPb(
    imprId: json["impr_id"],
  );

  Map<String, dynamic> toJson() => {
    "impr_id": imprId,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
