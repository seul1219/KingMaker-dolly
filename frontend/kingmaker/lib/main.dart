import 'package:flutter/material.dart';
import 'package:kingmaker/page/login_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kingmaker/provider/kingdom_provider.dart';
import 'package:kingmaker/provider/regist_provider.dart';
import 'package:kingmaker/provider/schedule_provider.dart';
import 'package:kingmaker/provider/test_provider.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:kingmaker/widget/common/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<RegistProvider>(
          create: (context) => RegistProvider(),
        ),
        ChangeNotifierProvider<ScheduleProvider>(
          create: (context) => ScheduleProvider(),
        ),
        ChangeNotifierProvider<MemberProvider>(
          create: (context) => MemberProvider(),
        ),
        ChangeNotifierProvider<KingdomProvider>(
          create: (context) => KingdomProvider(),
        ),
        ChangeNotifierProvider<TestProvider>(
          create: (context) => TestProvider(),
        )
      ],
      child: const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'kingMaker',
      theme: ThemeData(
        fontFamily: 'PretendardBold',
        useMaterial3: true,
      ),
      home: Consumer<MemberProvider>(
            builder: (context, provider, child) {
            var isLoggedIn = provider.isLoggedIn;
              return Container(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: isLoggedIn? const BottomNavBar() : const LoginPage(),
                // child: TestPage(),
              );
            },
          ),
    );
  }
}