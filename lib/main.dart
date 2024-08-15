import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:subspace/bloc/blog_bloc.dart';
import 'package:subspace/data/data_provider/blog_data_provider.dart';
import 'package:subspace/data/repository/blog_repository.dart';
import 'package:subspace/model/blog_model.dart';
import 'package:subspace/presentation/screen/home_screen.dart';
import 'package:subspace/services/hive_services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BlogAdapter());
  Hive.registerAdapter(BlogModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => BlogRepository(BlogDataProvider()),
      child: BlocProvider(
        create: (context) => BlogBloc(context.read<BlogRepository>()),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
