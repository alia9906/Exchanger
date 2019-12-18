import 'package:exchanger2/constants/routes.dart';
import 'package:exchanger2/providers/chat.dart';
import 'package:exchanger2/scaffscreens/buy_screen.dart';
import 'package:exchanger2/scaffscreens/chat_screen.dart';
import 'package:exchanger2/scaffscreens/messages.dart';
import 'package:exchanger2/scaffscreens/order_screen.dart';
import 'package:exchanger2/scaffscreens/user_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:exchanger2/providers/user.dart';
import 'package:exchanger2/helperwidgets/main.dart';
import 'package:exchanger2/values/themes.dart';
import 'package:provider/provider.dart';
import 'package:exchanger2/scaffscreens/SELL_SCREEN.DART';

void main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: User(),
        ),
        ChangeNotifierProxyProvider<User, Chat>(
          create: (ctx) => Chat(null),
          update: (ctx, user, prev) => Chat(user.token),
        ),
      ],
      child: MaterialApp(
        theme: Themes.MAIN_THEME,
        routes: {
          USER_VERIFY_PAGE: (ctx) => UserVerificationScreen(),
          USER_MODIRIAT_MESSAGES: (ctx) => UserMessages(),
          USER_CHAT_WITH_ADMIN : (ctx) => ChatScreen(),
          BUY_SCREEN : (ctx) => BuyScreen(),
          SELL_SCREEN : (ctx) => SellScreen(),
          ORDERS_SCREEN : (ctx) => OrderScreen(),
          '/': (ctx) => Main()
        },
        initialRoute: '/',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
        ],
        locale: Locale("fa", "IR"),
      ),
    );
  }
}
