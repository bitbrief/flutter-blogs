import 'dart:convert';

import 'package:hive/hive.dart';

part 'blog_model.g.dart'; // Generated part file

@HiveType(typeId: 0)
class BlogModel extends HiveObject {
  @HiveField(0)
  final List<Blog> blogs;

  BlogModel({required this.blogs});

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      blogs: List<Blog>.from(map['blogs'].map((blog) => Blog.fromMap(blog))),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'blogs': blogs.map((blog) => blog.toMap()).toList(),
    };
  }

  @override
  String toString() => 'BlogModel(blogs: $blogs)';
}

@HiveType(typeId: 1)
class Blog extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String imageUrl;

  @HiveField(2)
  final String title;

  @HiveField(3)
  bool isFavorite;

  Blog({
    required this.id,
    required this.imageUrl,
    required this.title,
    this.isFavorite = false,
  });

  Blog copyWith({
    String? id,
    String? imageUrl,
    String? title,
    bool? isFavorite,
  }) {
    return Blog(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'isFavorite': isFavorite,
    };
  }

  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(
      id: map['id'],
      imageUrl: map['image_url'],
      title: map['title'],
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Blog.fromJson(String source) =>
      Blog.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Blog(id: $id, imageUrl: $imageUrl, title: $title, isFavorite: $isFavorite)';

  @override
  bool operator ==(covariant Blog other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.imageUrl == imageUrl &&
        other.title == title &&
        other.isFavorite == isFavorite;
  }

  @override
  int get hashCode =>
      id.hashCode ^ imageUrl.hashCode ^ title.hashCode ^ isFavorite.hashCode;
}
