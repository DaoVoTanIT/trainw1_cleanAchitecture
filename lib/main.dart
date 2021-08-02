
import 'package:clean_achitecture/features/sigin_signup/presentation/screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        // home: ChangeNotifierProvider(
        //   create: (context) => AuthService(),
        //   child: StreamBuilder(
        //     stream: FirebaseAuth.instance.authStateChanges(),
        //     builder: (context, snapshot) {
        //       final provider = Provider.of<AuthService>(context);
        //       if (provider.isSigningIn) {
        //         return buildLoading();
        //       } else if (snapshot.hasData) {
        //         return HomeScreen();
        //       } else {
        //         //return SigninOrSignupScreen();
        //         return SignIn();
        //       }
        //     },
        //   ),
        // ),
        home: SignIn(),
      );
  Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          Center(child: CircularProgressIndicator()),
        ],
      );
}

// class MyApp extends StatelessWidget {
//   final _init = Firebase.initializeApp();
//   @override
//   Widget build(BuildContext context) {
//     // return FutureBuilder(
//     //     future: _init,
//     //     builder: (BuildContext context, snapshot) {

//     //       final provider = Provider.of<AuthService>(context);
//     //       if (provider.isSigningIn) {
//     //         return buildLoading();
//     //       } else if (snapshot.hasData) {
//     //         return HomeScreen();
//     //       } else {
//     //         return Authenticate();
//     //       }
//     //     });
//     return Scaffold(body: SignIn());
//   }

//   Widget buildLoading() => Stack(
//         fit: StackFit.expand,
//         children: [
//           Center(child: CircularProgressIndicator()),
//         ],
//       );
// }
