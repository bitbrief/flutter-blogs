part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogFetched extends BlogEvent {}

final class ToggleFavorite extends BlogEvent {
  final String blogId;
  ToggleFavorite({required this.blogId});
}