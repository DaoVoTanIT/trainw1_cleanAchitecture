import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/features/sigin_signup/presentation/screen/login.dart';
import 'package:clean_achitecture/routes/route_name.dart';
import 'package:clean_achitecture/routes/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Theme/theme.dart';
import 'injection_container.dart' as di;

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
