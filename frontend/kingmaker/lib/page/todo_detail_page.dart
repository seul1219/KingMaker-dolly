import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/provider/schedule_provider.dart';
import 'package:provider/provider.dart';

class TodoDetailPage extends StatefulWidget {
  const TodoDetailPage({super.key});

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  static const category = ['집안일', '일상', '학습', '건강', '업무', '기타'];

  @override
  Widget build(BuildContext context) {
    Map<String, String> data = context.watch<ScheduleProvider>().detail;
    return SafeArea(
      child: Scaffold(
          backgroundColor: LIGHTEST_BLUE_COLOR,
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 40,
                        child: IconButton(
                          icon: const Icon(
                            Icons.navigate_before,
                          ),
                          tooltip: '이 전 페이지',
                          onPressed: () {
                            print("click");
                          },
                          iconSize: 30,
                        ),
                      ),
                      Container(
                        height: 44,
                        child: Center(
                          child: Title(
                            color: Colors.black,
                            child: Text(
                              '몬스터 정보',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Image.asset(
                    'assets/images/Slime.png',
                    height: 150,
                    width: 150,
                  ),
                  // 이미지 경로를 수정하세요.
                  Container(
                    padding: EdgeInsets.all(16),
                    width: 350,
                    // height: 200,
                    decoration: BoxDecoration(
                      color: WHITE_COLOR,
                      borderRadius: BorderRadius.circular(8), //모서리를 둥글게
                      // border: Border.all(color: Colors.black, width: 3), //테두리
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/pixel_star.png',
                                          height: 30,
                                          width: 30,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(data['title']!,
                                            style: TextStyle(
                                              fontSize: 20,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      height: 32,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: BLUE_COLOR,
                                        borderRadius: BorderRadius.circular(
                                            10), //모서리를 둥글게
                                        // border: Border.all(color: Colors.black, width: 3), //테두리
                                      ),
                                      child: Center(
                                        child: Text(
                                            category[
                                                int.parse(data['category']!)],
                                            style: TextStyle(
                                                color: WHITE_COLOR,
                                                fontSize: 16)),
                                      )),
                                ],
                              ),
                              (data['place'] == null) ? SizedBox() : SizedBox(height: 4,),
                              (data['place'] == null)
                                  ? SizedBox()
                                  : Text(data['place']!),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsetsDirectional.only(top: 12),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 24),
                          decoration: BoxDecoration(
                            color: LIGHTEST_GREY_COLOR,
                            borderRadius: BorderRadius.circular(10), //모서리를 둥글게
                            // border: Border.all(color: Colors.black, width: 3), //테두리
                          ),
                          child: Text(data['detail']!),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "시작일자",
                                    style: TextStyle(
                                        color: DARKER_GREY_COLOR, fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 28,
                                  ),
                                  Text(
                                    data['startAt']!,
                                    style: TextStyle(
                                        color: BLUE_BLACK_COLOR, fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "종료일자",
                                    style: TextStyle(
                                        color: DARKER_GREY_COLOR, fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 28,
                                  ),
                                  Text(
                                    data['endAt']!,
                                    style: TextStyle(
                                        color: BLUE_BLACK_COLOR, fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsetsDirectional.only(top: 10),
                    width: 350,
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            print(data);
                            int id = int.parse(data['id']!);
                            if (data['type'] == '2') {
                              Provider.of<ScheduleProvider>(context,
                                      listen: false)
                                  .achieveRoutine(id);
                            } else {
                              Provider.of<ScheduleProvider>(context,
                                      listen: false)
                                  .achieveTodo(id);
                            }
                            Provider.of<ScheduleProvider>(context,
                                    listen: false)
                                .changeAchieve();
                            print("버튼 클릭");
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50), // 여기서 원하는 크기로 조절
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 14.0),
                            backgroundColor: LIGHT_YELLOW_COLOR,
                          ),
                          child: data['achievedYn'] == 'true'
                              ? Text('수행취소', style: TextStyle(color: BLUE_BLACK_COLOR, fontSize: 16),)
                              : Text('수행하기', style: TextStyle(color: BLUE_BLACK_COLOR, fontSize: 16),)
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () => print("버튼 클릭"),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(100, 45),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0.0, vertical: 10.0),
                                    backgroundColor: Color(0xff9FC6D2),
                                  ),
                                  child: Text('수정', style: TextStyle(color: WHITE_COLOR, fontSize: 16),)),
                            ),
                            SizedBox(width: 8,),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () => print("버튼 클릭"),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(100, 45), // 여기서 원하는 크기로 조절
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0.0, vertical: 10.0),
                                    backgroundColor: Color(0xff9FC6D2),
                                  ),
                                  child: Text('삭제', style: TextStyle(color: WHITE_COLOR, fontSize: 16),)),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}