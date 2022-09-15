import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:superstore/Providers/FirebaseProvider.dart';
import 'package:superstore/UI/Screens/splashScreen.dart';

import 'AppRouter.dart';
import 'Providers/DioProvider.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DioProvider>(
          create: (context) {
            return DioProvider();
          },),
        ChangeNotifierProvider<FirebaseProvider>(
          create: (context) {
            return FirebaseProvider();
          },),
      ],
      child: ScreenUtilInit(
          designSize: const Size(410, 890),
          minTextAdapt: true,
          splitScreenMode: true,
        builder: (context,child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: AppRouter.navKey,
            home:  SplashScreen(),
            theme: ThemeData(
              // brightness: Brightness.dark,
              fontFamily: 'fontEn',
            ),

          );
        }
      ),
    );
  }
}
