// To parse this JSON data, do
//
//     final playlist = playlistFromMap(jsonString);

import 'dart:convert';

PlaylistModel playlistFromMap(String str) =>
    PlaylistModel.fromMap(json.decode(str));

String playlistToMap(PlaylistModel data) => json.encode(data.toMap());

class PlaylistModel {
  PlaylistModel({
    this.kind,
    this.etag,
    this.pageInfo,
    this.items,
  });

  final String? kind;
  final String? etag;
  final PageInfoPlaylist? pageInfo;
  final List<ItemPlaylist>? items;

  PlaylistModel copyWith({
    String? kind,
    String? etag,
    PageInfoPlaylist? pageInfo,
    List<ItemPlaylist>? items,
  }) =>
      PlaylistModel(
        kind: kind ?? this.kind,
        etag: etag ?? this.etag,
        pageInfo: pageInfo ?? this.pageInfo,
        items: items ?? this.items,
      );

  factory PlaylistModel.fromMap(Map<String, dynamic> json) => PlaylistModel(
        kind: json["kind"],
        etag: json["etag"],
        pageInfo: json["pageInfo"] == null
            ? null
            : PageInfoPlaylist.fromMap(json["pageInfo"]),
        items: json["items"] == null
            ? []
            : List<ItemPlaylist>.from(
                json["items"]!.map((x) => ItemPlaylist.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "kind": kind,
        "etag": etag,
        "pageInfo": pageInfo?.toMap(),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toMap())),
      };
}

class ItemPlaylist {
  ItemPlaylist({
    this.etag,
    this.id,
    this.snippet,
    this.contentDetails,
  });

  final String? etag;
  final String? id;
  final Snippet? snippet;
  final ContentDetails? contentDetails;

  ItemPlaylist copyWith({
    String? etag,
    String? id,
    Snippet? snippet,
    ContentDetails? contentDetails,
  }) =>
      ItemPlaylist(
        etag: etag ?? this.etag,
        id: id ?? this.id,
        snippet: snippet ?? this.snippet,
        contentDetails: contentDetails ?? this.contentDetails,
      );

  factory ItemPlaylist.fromMap(Map<String, dynamic> json) => ItemPlaylist(
        etag: json["etag"],
        id: json["id"],
        snippet:
            json["snippet"] == null ? null : Snippet.fromMap(json["snippet"]),
        contentDetails: json["contentDetails"] == null
            ? null
            : ContentDetails.fromMap(json["contentDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "etag": etag,
        "id": id,
        "snippet": snippet?.toMap(),
        "contentDetails": contentDetails?.toMap(),
      };
}

class ContentDetails {
  ContentDetails({
    this.itemCount,
  });

  final int? itemCount;

  ContentDetails copyWith({
    int? itemCount,
  }) =>
      ContentDetails(
        itemCount: itemCount ?? this.itemCount,
      );

  factory ContentDetails.fromMap(Map<String, dynamic> json) => ContentDetails(
        itemCount: json["itemCount"],
      );

  Map<String, dynamic> toMap() => {
        "itemCount": itemCount,
      };
}

class Snippet {
  Snippet({
    this.publishedAt,
    this.title,
    this.description,
    this.thumbnails,
    this.localized,
  });

  final DateTime? publishedAt;

  final String? title;
  final String? description;
  final Thumbnails? thumbnails;

  final Localized? localized;

  Snippet copyWith({
    DateTime? publishedAt,
    String? title,
    String? description,
    Thumbnails? thumbnails,
    Localized? localized,
  }) =>
      Snippet(
        publishedAt: publishedAt ?? this.publishedAt,
        title: title ?? this.title,
        description: description ?? this.description,
        thumbnails: thumbnails ?? this.thumbnails,
        localized: localized ?? this.localized,
      );

  factory Snippet.fromMap(Map<String, dynamic> json) => Snippet(
        publishedAt: json["publishedAt"] == null
            ? null
            : DateTime.parse(json["publishedAt"]),
        title: json["title"],
        description: json["description"],
        thumbnails: json["thumbnails"] == null
            ? null
            : Thumbnails.fromMap(json["thumbnails"]),
        localized: json["localized"] == null
            ? null
            : Localized.fromMap(json["localized"]),
      );

  Map<String, dynamic> toMap() => {
        "publishedAt": publishedAt?.toIso8601String(),
        "title": title,
        "description": description,
        "thumbnails": thumbnails?.toMap(),
        "localized": localized?.toMap(),
      };
}

class Localized {
  Localized({
    this.title,
    this.description,
  });

  final String? title;
  final String? description;

  Localized copyWith({
    String? title,
    String? description,
  }) =>
      Localized(
        title: title ?? this.title,
        description: description ?? this.description,
      );

  factory Localized.fromMap(Map<String, dynamic> json) => Localized(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
      };
}

class Thumbnails {
  Thumbnails({
    this.thumbnailsDefault,
    this.medium,
    this.high,
    this.standard,
    this.maxres,
  });

  final Default? thumbnailsDefault;
  final Default? medium;
  final Default? high;
  final Default? standard;
  final Default? maxres;

  Thumbnails copyWith({
    Default? thumbnailsDefault,
    Default? medium,
    Default? high,
    Default? standard,
    Default? maxres,
  }) =>
      Thumbnails(
        thumbnailsDefault: thumbnailsDefault ?? this.thumbnailsDefault,
        medium: medium ?? this.medium,
        high: high ?? this.high,
        standard: standard ?? this.standard,
        maxres: maxres ?? this.maxres,
      );

  factory Thumbnails.fromMap(Map<String, dynamic> json) => Thumbnails(
        thumbnailsDefault:
            json["default"] == null ? null : Default.fromMap(json["default"]),
        medium: json["medium"] == null ? null : Default.fromMap(json["medium"]),
        high: json["high"] == null ? null : Default.fromMap(json["high"]),
        standard:
            json["standard"] == null ? null : Default.fromMap(json["standard"]),
        maxres: json["maxres"] == null ? null : Default.fromMap(json["maxres"]),
      );

  Map<String, dynamic> toMap() => {
        "default": thumbnailsDefault?.toMap(),
        "medium": medium?.toMap(),
        "high": high?.toMap(),
        "standard": standard?.toMap(),
        "maxres": maxres?.toMap(),
      };
}

class Default {
  Default({
    this.url,
    this.width,
    this.height,
  });

  final String? url;
  final int? width;
  final int? height;

  Default copyWith({
    String? url,
    int? width,
    int? height,
  }) =>
      Default(
        url: url ?? this.url,
        width: width ?? this.width,
        height: height ?? this.height,
      );

  factory Default.fromMap(Map<String, dynamic> json) => Default(
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "width": width,
        "height": height,
      };
}

class PageInfoPlaylist {
  PageInfoPlaylist({
    this.totalResults,
    this.resultsPerPage,
  });

  final int? totalResults;
  final int? resultsPerPage;

  PageInfoPlaylist copyWith({
    int? totalResults,
    int? resultsPerPage,
  }) =>
      PageInfoPlaylist(
        totalResults: totalResults ?? this.totalResults,
        resultsPerPage: resultsPerPage ?? this.resultsPerPage,
      );

  factory PageInfoPlaylist.fromMap(Map<String, dynamic> json) =>
      PageInfoPlaylist(
        totalResults: json["totalResults"],
        resultsPerPage: json["resultsPerPage"],
      );

  Map<String, dynamic> toMap() => {
        "totalResults": totalResults,
        "resultsPerPage": resultsPerPage,
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
