import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wake/app/app.bottomsheets.dart';
import 'package:wake/app/app.dialogs.dart';
import 'package:wake/app/app.locator.dart';
import 'package:wake/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(374, 844),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.startupView,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorKey: StackedService.navigatorKey,
        navigatorObservers: [
          StackedService.routeObserver,
        ],
        // shantellSans
        theme: ThemeData(
          textTheme: GoogleFonts.mynerveTextTheme(
            Theme.of(context).textTheme,
          ),
          useMaterial3: false,
        ),
        darkTheme: ThemeData.dark(),
      ),
    );
  }
}
