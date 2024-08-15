import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subspace/bloc/blog_bloc.dart';
import 'package:subspace/model/blog_model.dart';

class BlogPage extends StatefulWidget {
  final Blog blog;
  const BlogPage({
    super.key,
    required this.blog,
  });

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogBloc, BlogState>(
      builder: (context, state) {
        final blog = (state as BlogSuccess).blogModel.blogs.firstWhere((b) => b.id == widget.blog.id);
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Column(
              children: [
                Hero(
                    tag: widget.blog.id,
                    child: Stack(children: [
                      Image.network(
                        blog.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Positioned(
                        left: 12,
                        top: 20,
                        child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff212121),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ))),
                      )
                    ])),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              blog.title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context
                                  .read<BlogBloc>()
                                  .add(ToggleFavorite(blogId: blog.id));
                              setState(() {});
                              ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(blog.isFavorite ?"Removed From Favorite" : "Added to Favorite")));
                            },
                            icon: Icon(
                              blog.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: blog.isFavorite
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
