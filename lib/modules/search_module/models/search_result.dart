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
    this.objectId,
  });

  final String objectId;

  Hit copyWith({
    String objectId,
  }) =>
      Hit(
        objectId: objectId ?? this.objectId,
      );

  factory Hit.fromJson(Map<String, dynamic> json) => Hit(
        objectId: json["objectID"] == null ? null : json["objectID"],
      );

  Map<String, dynamic> toJson() => {
        "objectID": objectId == null ? null : objectId,
      };
}
