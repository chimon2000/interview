import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Book extends Equatable {
  Book({
    String? id,
    required this.author,
    required this.title,
    this.imageUrl,
  }) : this.id = id ?? uuid.v4();

  final String id;
  final String author;
  final String title;
  final String? imageUrl;

  @override
  List<Object?> get props => [
        id,
        author,
        title,
        imageUrl,
      ];

  @override
  bool? get stringify => true;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author,
      'title': title,
      'imageUrl': imageUrl,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] ?? '',
      author: map['author'] ?? '',
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));

  Book copyWith({
    String? id,
    String? author,
    String? title,
    String? imageUrl,
  }) {
    return Book(
      id: id ?? this.id,
      author: author ?? this.author,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

var uuid = Uuid();
