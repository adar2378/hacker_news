// To parse this JSON data, do
//
//     final searchResult = searchResultFromJson(jsonString);

import 'dart:convert';

SearchResult searchResultFromJson(String str) => SearchResult.fromJson(json.decode(str));

String searchResultToJson(SearchResult data) => json.encode(data.toJson());

class SearchResult {
  SearchResult({
    this.hits,
    this.nbHits,
    this.page,
    this.nbPages,
    this.hitsPerPage,
    this.exhaustiveNbHits,
    this.params,
    this.processingTimeMs,
  });

  final List<Hit> hits;
  final int nbHits;
  final int page;
  final int nbPages;
  final int hitsPerPage;
  final bool exhaustiveNbHits;

  final String params;
  final int processingTimeMs;

  SearchResult copyWith({
    List<Hit> hits,
    int nbHits,
    int page,
    int nbPages,
    int hitsPerPage,
    bool exhaustiveNbHits,
    String params,
    int processingTimeMs,
  }) =>
      SearchResult(
        hits: hits ?? this.hits,
        nbHits: nbHits ?? this.nbHits,
        page: page ?? this.page,
        nbPages: nbPages ?? this.nbPages,
        hitsPerPage: hitsPerPage ?? this.hitsPerPage,
        exhaustiveNbHits: exhaustiveNbHits ?? this.exhaustiveNbHits,
        params: params ?? this.params,
        processingTimeMs: processingTimeMs ?? this.processingTimeMs,
      );

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        hits: json["hits"] == null ? null : List<Hit>.from(json["hits"].map((x) => Hit.fromJson(x))),
        nbHits: json["nbHits"] == null ? null : json["nbHits"],
        page: json["page"] == null ? null : json["page"],
        nbPages: json["nbPages"] == null ? null : json["nbPages"],
        hitsPerPage: json["hitsPerPage"] == null ? null : json["hitsPerPage"],
        exhaustiveNbHits: json["exhaustiveNbHits"] == null ? null : json["exhaustiveNbHits"],
        params: json["params"] == null ? null : json["params"],
        processingTimeMs: json["processingTimeMS"] == null ? null : json["processingTimeMS"],
      );

  Map<String, dynamic> toJson() => {
        "hits": hits == null ? null : List<dynamic>.from(hits.map((x) => x.toJson())),
        "nbHits": nbHits == null ? null : nbHits,
        "page": page == null ? null : page,
        "nbPages": nbPages == null ? null : nbPages,
        "hitsPerPage": hitsPerPage == null ? null : hitsPerPage,
        "exhaustiveNbHits": exhaustiveNbHits == null ? null : exhaustiveNbHits,
        "params": params == null ? null : params,
        "processingTimeMS": processingTimeMs == null ? null : processingTimeMs,
      };
}

class Hit {
  Hit({
    this.createdAt,
    this.title,
    this.url,
    this.author,
    this.points,
    this.storyText,
    this.commentText,
    this.numComments,
    this.storyId,
    this.storyTitle,
    this.storyUrl,
    this.parentId,
    this.createdAtI,
    this.relevancyScore,
    this.tags,
    this.objectId,
  });

  final DateTime createdAt;
  final String title;
  final String url;
  final String author;
  final int points;
  final String storyText;
  final dynamic commentText;
  final int numComments;
  final dynamic storyId;
  final dynamic storyTitle;
  final dynamic storyUrl;
  final dynamic parentId;
  final int createdAtI;
  final int relevancyScore;
  final List<String> tags;
  final String objectId;

  Hit copyWith({
    DateTime createdAt,
    String title,
    String url,
    String author,
    int points,
    String storyText,
    dynamic commentText,
    int numComments,
    dynamic storyId,
    dynamic storyTitle,
    dynamic storyUrl,
    dynamic parentId,
    int createdAtI,
    int relevancyScore,
    List<String> tags,
    String objectId,
  }) =>
      Hit(
        createdAt: createdAt ?? this.createdAt,
        title: title ?? this.title,
        url: url ?? this.url,
        author: author ?? this.author,
        points: points ?? this.points,
        storyText: storyText ?? this.storyText,
        commentText: commentText ?? this.commentText,
        numComments: numComments ?? this.numComments,
        storyId: storyId ?? this.storyId,
        storyTitle: storyTitle ?? this.storyTitle,
        storyUrl: storyUrl ?? this.storyUrl,
        parentId: parentId ?? this.parentId,
        createdAtI: createdAtI ?? this.createdAtI,
        relevancyScore: relevancyScore ?? this.relevancyScore,
        tags: tags ?? this.tags,
        objectId: objectId ?? this.objectId,
      );

  factory Hit.fromJson(Map<String, dynamic> json) => Hit(
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        title: json["title"] == null ? null : json["title"],
        url: json["url"] == null ? null : json["url"],
        author: json["author"] == null ? null : json["author"],
        points: json["points"] == null ? null : json["points"],
        storyText: json["story_text"] == null ? null : json["story_text"],
        commentText: json["comment_text"],
        numComments: json["num_comments"] == null ? null : json["num_comments"],
        storyId: json["story_id"],
        storyTitle: json["story_title"],
        storyUrl: json["story_url"],
        parentId: json["parent_id"],
        createdAtI: json["created_at_i"] == null ? null : json["created_at_i"],
        relevancyScore: json["relevancy_score"] == null ? null : json["relevancy_score"],
        tags: json["_tags"] == null ? null : List<String>.from(json["_tags"].map((x) => x)),
        objectId: json["objectID"] == null ? null : json["objectID"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "title": title == null ? null : title,
        "url": url == null ? null : url,
        "author": author == null ? null : author,
        "points": points == null ? null : points,
        "story_text": storyText == null ? null : storyText,
        "comment_text": commentText,
        "num_comments": numComments == null ? null : numComments,
        "story_id": storyId,
        "story_title": storyTitle,
        "story_url": storyUrl,
        "parent_id": parentId,
        "created_at_i": createdAtI == null ? null : createdAtI,
        "relevancy_score": relevancyScore == null ? null : relevancyScore,
        "_tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
        "objectID": objectId == null ? null : objectId,
      };
}
