import 'dart:convert';

class ArticleAdapter {
  final String id;
  final DateTime time;
  final String point;
  final String commentCount;
  final String title;
  final String sourceUrl;
  final String author;
  ArticleAdapter({
    this.id,
    this.time,
    this.point,
    this.commentCount,
    this.title,
    this.sourceUrl,
    this.author,
  });

  ArticleAdapter copyWith({
    String id,
    DateTime time,
    String point,
    String commentCount,
    String title,
    String sourceUrl,
    String author,
  }) {
    return ArticleAdapter(
      id: id ?? this.id,
      time: time ?? this.time,
      point: point ?? this.point,
      commentCount: commentCount ?? this.commentCount,
      title: title ?? this.title,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      author: author ?? this.author,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': time?.millisecondsSinceEpoch,
      'point': point,
      'commentCount': commentCount,
      'title': title,
      'sourceUrl': sourceUrl,
      'author': author,
    };
  }

  factory ArticleAdapter.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ArticleAdapter(
      id: map['id'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      point: map['point'],
      commentCount: map['commentCount'],
      title: map['title'],
      sourceUrl: map['sourceUrl'],
      author: map['author'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ArticleAdapter.fromJson(String source) => ArticleAdapter.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ArticleAdapter(id: $id, time: $time, point: $point, commentCount: $commentCount, title: $title, sourceUrl: $sourceUrl, author: $author)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ArticleAdapter &&
        o.id == id &&
        o.time == time &&
        o.point == point &&
        o.commentCount == commentCount &&
        o.title == title &&
        o.sourceUrl == sourceUrl &&
        o.author == author;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        time.hashCode ^
        point.hashCode ^
        commentCount.hashCode ^
        title.hashCode ^
        sourceUrl.hashCode ^
        author.hashCode;
  }
}
