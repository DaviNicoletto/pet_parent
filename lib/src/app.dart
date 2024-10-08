import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pet_parent/src/constants/app_constants.dart';
import 'package:pet_parent/src/user_provider.dart';
import 'package:pet_parent/src/views/onboarding_view.dart';
import 'package:pet_parent/src/views/home_view.dart';
import 'package:pet_parent/src/views/login_view.dart';
import 'package:pet_parent/src/views/register_account_view.dart';
import 'package:pet_parent/src/widgets/auth/auth_check.dart';
import 'package:pet_parent/src/widgets/pets_page/add_pet_modal_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppConstants appConstants = AppConstants();
    AppColors colors = AppColors();

    return UserProvider(
      child: MaterialApp(
        title: appConstants.appTitle,
        theme: ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xFF2CBBC3),
            onPrimary: Color(0xFFE1F1F2),
            secondary: Color(0xFFE1F1F2),
            onSecondary: Color(0xFF2CBBC3),
            tertiary: Color(0xFFFF9934),
            onTertiary: Color(0xFFF9F9F9),
            error: Color.fromARGB(255, 211, 22, 22),
            onError: Color(0xFFF9F9F9),
            surface: Color(0xFFF9F9F9),
            onSurface: Color(0xFF101010),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colors.colorHighlight),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            floatingLabelStyle: TextStyle(
              color: colors.colorTextDark,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          dialogTheme: const DialogTheme(surfaceTintColor: Colors.white),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: colors.colorHighlight,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: colors.colorPrimary,
            iconTheme: IconThemeData(
              color: colors.colorSecondary,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: colors.colorHighlight,
          ),
          datePickerTheme: const DatePickerThemeData(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            headerBackgroundColor: Colors.white,
            dividerColor: Colors.transparent,
          ),
          timePickerTheme: TimePickerThemeData(
            dialBackgroundColor: colors.colorSecondary,
            dialTextStyle: TextStyle(fontSize: constans.textFontSize),
          ),
        ),
        initialRoute: '/authCheck',
        routes: {
          '/': (context) => const FirstAcessPage(),
          '/register': (context) => const RegisterUserPage(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
          '/authCheck': (context) => const AuthCheck(),
        },
        supportedLocales: const [
          Locale('en', ''),
          Locale('pt', 'BR'), // English, no country code
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
