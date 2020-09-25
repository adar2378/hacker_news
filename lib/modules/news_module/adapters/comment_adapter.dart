import 'dart:convert';

import 'package:flutter/foundation.dart';

/// Wrapper around [NewsData] class for comments
class CommentAdapter {
  final String id;
  final String text;
  final String author;
  final List<int> childComments;
  final DateTime time;
  CommentAdapter({
    this.id,
    this.text,
    this.author,
    this.childComments,
    this.time,
  });

  CommentAdapter copyWith({
    String id,
    String text,
    String author,
    List<int> childComments,
    DateTime time,
  }) {
    return CommentAdapter(
      id: id ?? this.id,
      text: text ?? this.text,
      author: author ?? this.author,
      childComments: childComments ?? this.childComments,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'author': author,
      'childComments': childComments,
      'time': time?.millisecondsSinceEpoch,
    };
  }

  factory CommentAdapter.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CommentAdapter(
      id: map['id'],
      text: map['text'],
      author: map['author'],
      childComments: List<int>.from(map['childComments']),
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentAdapter.fromJson(String source) => CommentAdapter.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CommentAdapter(id: $id, text: $text, author: $author, childComments: $childComments, time: $time)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CommentAdapter &&
        o.id == id &&
        o.text == text &&
        o.author == author &&
        listEquals(o.childComments, childComments) &&
        o.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^ text.hashCode ^ author.hashCode ^ childComments.hashCode ^ time.hashCode;
  }
}
