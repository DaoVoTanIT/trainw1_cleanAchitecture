import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/features/sigin_signup/presentation/screen/login.dart';
import 'package:clean_achitecture/routes/route_name.dart';
import 'package:clean_achitecture/routes/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Theme/theme.dart';
import 'features/Map/data/geolocator_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final locatorSerVice = GeolocatorService();

  @override
  Widget build(BuildContext context) {
    return
        // MultiProvider(
        // providers: [
        //   FutureProvider(
        //     create: (context) => locatorSerVice.getLocation(),
        //     initialData: null,
        //   ),
        // ],
        // child:
        MaterialApp(
      debugShowCheckedModeBanner: false,
      //  color: CupertinoColors.systemGroupedBackground,
      localizationsDelegates: [],
      //set up router
      initialRoute: RouteName.splashPage,
      onGenerateRoute: Routers.generateRoute,
    );
    //  );
  }
}
