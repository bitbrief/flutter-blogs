import 'dart:convert';

import 'package:subspace/data/data_provider/blog_data_provider.dart';
import 'package:subspace/model/blog_model.dart';

class BlogRepository {
  final BlogDataProvider blogDataProvider;

  BlogRepository(this.blogDataProvider);

  Future<BlogModel> getBlogs() async {
    try {
      final blogData = await blogDataProvider.fetchBlogs();
      if(blogData.isEmpty) throw "Something went wrong";
      final data = jsonDecode(blogData);
      return BlogModel.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }
}
