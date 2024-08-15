part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogSuccess extends BlogState {
  final BlogModel blogModel;

  BlogSuccess({required this.blogModel});
}

final class BlogFailure extends BlogState {
  final String error;

  BlogFailure(this.error);
}

final class BlogLoading extends BlogState {}

final class BlogOffline extends BlogState {}
