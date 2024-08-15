import 'dart:async';

import 'package:flutter/material.dart';
import 'package:subspace/presentation/screen/blog_screen.dart';
import 'package:subspace/presentation/screen/favorite_page.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool hasConnection = false;
  late StreamSubscription<InternetConnectionStatus> listener;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listener = InternetConnectionChecker().onStatusChange.listen((status) {
      final connected = status == InternetConnectionStatus.connected;
      if (connected != hasConnection) {
        setState(() {
          hasConnection = connected;
        });
      }
    });
    
  }


  Future<void> _checkInternetConnection() async {
    hasConnection = await InternetConnectionChecker().hasConnection;
    // setState(() {}); // Update the state after checking the connection
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text('SubSpace Blogs', style: TextStyle(color: Colors.white),),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: "All",
              ),
              Tab(
                
                text: "Favorites"
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: hasConnection ? const BlogScreen() : const Text("No internet access", style: TextStyle(color: Colors.white),),
            ),
            Center(
              child: hasConnection ? const FavoriteScreen() : const Text("No internet access", style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}