import 'package:flutter/material.dart';
import 'package:kingmaker/page/story_page.dart';
import 'package:kingmaker/provider/kingdom_provider.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:kingmaker/widget/common/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import '../../api/fcm_api.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MemberProvider>(context);
    final providerKing = Provider.of<KingdomProvider>(context);
    final FcmApi fcmApi=FcmApi();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 60),
              const Image(image: AssetImage('assets/login/title2.png'), height: 330),
              const SizedBox(height: 100),
              GestureDetector(
                onTap: () async{
                  int flag = await provider.GoogleLogin();
                  if(flag != 0){
                     Provider.of<KingdomProvider>(context, listen: false).getKingdom(flag);
                  }
                  movPage(flag, context, providerKing);
                },
                child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: const Image(image: AssetImage('assets/login/googleLogin.png'))
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async{
                  int flag = await provider.KakaoLogin();
                  movPage(flag, context, providerKing);
                },
                child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: const Image(
                        image: AssetImage('assets/login/kakaoLogin.png')),
                ),
              ),
            ],
        ),
      ),
    );
  }

  void movPage(int flag, BuildContext context, KingdomProvider providerKing) async {
    if (flag == -1)
      return;
    else {
      Provider.of<KingdomProvider>(context, listen: false).getKingdom(flag);
    }


    if(flag == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StoryPage()),
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => BottomNavBar()),
            (route) => false,
      );
    }

  }
}
