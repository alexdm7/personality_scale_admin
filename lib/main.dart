
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:personality_scale_admin/screens/SurveyResults.dart';
import 'package:personality_scale_admin/screens/splash.dart';
import 'package:personality_scale_admin/screens/start.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData().copyWith(

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 13, 71, 107)),
      ),
      home:  StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx,snapchat){
            if(snapchat.connectionState==ConnectionState.waiting){
              return const SplashScreen();
            }
            if(snapchat.hasData){
              return   SurveyResultsScreen();
            }
            return   StartPage();
          }
      ),
    );
  }
}

