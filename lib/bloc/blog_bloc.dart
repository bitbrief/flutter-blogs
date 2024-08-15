import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:subspace/data/repository/blog_repository.dart';
import 'package:subspace/model/blog_model.dart';
part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogRepository blogRepository;
  BlogBloc(this.blogRepository) : super(BlogInitial()) {
    on<BlogFetched>(_fetchBlogs);
    on<ToggleFavorite>(_toggleFavorite);
  }

  void _fetchBlogs(BlogFetched event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    try {
      final blog = await blogRepository.getBlogs();
      emit(BlogSuccess(blogModel: blog));
    } catch (e) {
      if(e.toString().contains("No internet connection and no local data available")) {
        emit(BlogOffline());
      } else {
        emit(BlogFailure(e.toString()));
      }
    }
  }

  void _toggleFavorite(ToggleFavorite event, Emitter<BlogState> emit) async {
    if (state is BlogSuccess) {
      final blogModel = (state as BlogSuccess).blogModel;
      final updatedBlogs = blogModel.blogs.map((blog) {
        if (blog.id == event.blogId) {
          return blog.copyWith(isFavorite: !blog.isFavorite);
        }
        return blog;
      }).toList();

      emit(BlogSuccess(blogModel: BlogModel(blogs: updatedBlogs)));
    }
  }
}
