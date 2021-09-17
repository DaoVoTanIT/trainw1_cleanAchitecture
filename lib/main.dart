import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/features/sigin_signup/presentation/screen/login.dart';
import 'package:clean_achitecture/routes/route_name.dart';
import 'package:clean_achitecture/routes/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Theme/theme.dart';
import 'injection_container.dart' as di;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await di.init();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         // home: ChangeNotifierProvider(
//         //   create: (context) => AuthService(),
//         //   child: StreamBuilder(
//         //     stream: FirebaseAuth.instance.authStateChanges(),
//         //     builder: (context, snapshot) {
//         //       final provider = Provider.of<AuthService>(context);
//         //       if (provider.isSigningIn) {
//         //         return buildLoading();
//         //       } else if (snapshot.hasData) {
//         //         return HomeScreen();
//         //       } else {
//         //         //return SigninOrSignupScreen();
//         //         return SignIn();
//         //       }
//         //     },
//         //   ),
//         // ),
//         home: SignIn(),
//       );
//   Widget buildLoading() => Stack(
//         fit: StackFit.expand,
//         children: [
//           Center(child: CircularProgressIndicator()),
//         ],
//       );
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // appBarTheme: AppBarTheme(
        //     color: kPrimaryColorVariant,
        //     brightness: Brightness.light,
        //     elevation: 0.0,
        //     iconTheme: IconThemeData(color: Colors.black26)),
      ),
      //set up router

      initialRoute: RouteName.splashPage,
      onGenerateRoute: Routers.generateRoute,
    );
  }
}
