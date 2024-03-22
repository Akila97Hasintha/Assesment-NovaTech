import 'package:assesment/login/login.dart';
import 'package:assesment/provider/entry_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseOptions firebaseOptions = const FirebaseOptions(
          apiKey: 'AIzaSyBvsUkfFm21YHhlx42wKV1fIhqFSMuD7gc',
          
          projectId: 'ssignment-29f33',
          
          messagingSenderId: '404333117063',
          appId: '1:404333117063:android:25b98f10f846d2c4008222',
        );
            
        await Firebase.initializeApp(options:firebaseOptions);
       
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EntryProvider()),
        
      ],
      child: MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    print("Screen Width: ${screenSize.width}, Height: ${screenSize.height}");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       builder: (context, child) => ResponsiveBreakpoints.builder(
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
        child: child!,
      ),
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}

