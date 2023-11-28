import 'package:emart/consts/consts.dart';
import 'package:emart/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: appname,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.transparent,
            appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            fontFamily: regular,
            useMaterial3: true,
            iconTheme: const IconThemeData(color: darkFontGrey)),
        home: const SplashScreen(),
      ),
    );
  }
}
