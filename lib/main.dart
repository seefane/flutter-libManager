import 'package:flutter/material.dart';
import 'package:library_manager/screens/homepage.dart';
import 'package:library_manager/screens/login_screen.dart';
import 'package:library_manager/service/auth_provider.dart';
import 'package:library_manager/service/library_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserAuthProvider()),
        ChangeNotifierProvider(
          create: (context) => BookProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<UserAuthProvider>(builder: (context, authProvider, child) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: authProvider.getAuth() ? HomePage() : const LogInScreen());
    });
  }
}
