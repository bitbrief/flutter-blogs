import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subspace/bloc/blog_bloc.dart';
import 'package:subspace/presentation/screen/blog_page.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<BlogBloc>().add(BlogFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: BlocBuilder<BlogBloc, BlogState>(builder: (context, state) {
        if (state is BlogFailure) {
          return Center(
            child: Text(state.error, style: const TextStyle(color: Colors.white),),
          );
        }

        if (state is! BlogSuccess) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        final data = state.blogModel.blogs;

        return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final blog = data[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlogPage(blog: blog),
                    ),
                  );
                },
                child: Container(
                  padding:const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.white))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              blog.title,
                              maxLines: 2,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                context.read<BlogBloc>().add(ToggleFavorite(blogId: blog.id));
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
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Stack(clipBehavior: Clip.none, children: [
                            Container(
                              height: 190,
                              width: 290,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 1, color: Colors.grey.shade600)),
                            ),
                            Positioned(
                              top: -20,
                              left: -20,
                              child: Hero(
                                tag: blog.id,
                                child: Image.network(
                                  blog.imageUrl,
                                  height: 200,
                                  width: 300,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ]),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              );
            });
      })),
    );
  }
  
}
