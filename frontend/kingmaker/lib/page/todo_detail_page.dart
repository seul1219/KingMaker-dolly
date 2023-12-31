import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/provider/achievement_provider.dart';
import 'package:kingmaker/provider/calendar_provider.dart';
import 'package:kingmaker/provider/kingdom_provider.dart';
import 'package:kingmaker/provider/member_provider.dart';
import 'package:kingmaker/provider/regist_provider.dart';
import 'package:kingmaker/provider/schedule_provider.dart';
import 'package:kingmaker/widget/common/header.dart';
import 'package:kingmaker/widget/todo/modify_todo.dart';
import 'package:provider/provider.dart';

import '../widget/routine/modify_routine.dart';

class TodoDetailPage extends StatefulWidget {
  const TodoDetailPage({super.key});

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  static const category = ['', '집안일', '일상', '학습', '건강', '업무', '기타'];

  @override
  Widget build(BuildContext context) {
    Map<String, String> data = context.watch<ScheduleProvider>().detail;
    return Scaffold(
        backgroundColor: LIGHTEST_BLUE_COLOR,
        body: SafeArea(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 40,
                        child: IconButton(
                          icon: SvgPicture.asset('assets/icon/ic_left.svg', height: 24,),
                          tooltip: '이 전 페이지',
                          onPressed: () {
                            Navigator.pop(context,);
                          },
                          iconSize: 30,
                        ),
                      ),
                      Header(title: '몬스터 정보'),
                    ],
                  ),
                  Image.asset('assets/character/calendarlist/${int.parse(data['category']!)}.gif',scale: 0.25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: WHITE_COLOR,
                        borderRadius: BorderRadius.circular(8), //모서리를 둥글게
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
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Row(
                                          children: [
                                            bool.parse(data['importantYn']!)?SvgPicture.asset('assets/icon/ic_star.svg') : SizedBox(),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Wrap(
                                                direction: Axis.horizontal,
                                                children: [
                                                  Text(
                                                    data['title']!,
                                                    style: TextStyle(fontSize: 20),
                                                    softWrap: true,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
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
                                                  fontSize: 14)),
                                        )
                                    ),
                                  ],
                                ),
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
                            ),
                            child: Text(data['detail']!, style: TextStyle(fontSize: 14),),
                          ),
                          SizedBox(
                            height: 16,
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
                                          color: DARKER_GREY_COLOR, fontSize: 14),
                                    ),
                                    SizedBox(
                                      width: 28,
                                    ),
                                    Text(
                                      data['startAt']!,
                                      style: TextStyle(
                                          color: BLUE_BLACK_COLOR, fontSize: 14),
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
                                          color: DARKER_GREY_COLOR, fontSize: 14),
                                    ),
                                    SizedBox(
                                      width: 28,
                                    ),
                                    Text(
                                      data['endAt']!,
                                      style: TextStyle(
                                          color: BLUE_BLACK_COLOR, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    margin: EdgeInsetsDirectional.only(top: 10),
                    child: Column(
                      children: [
                        ElevatedButton(
                            onPressed: () {
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
                              int? memberId = Provider.of<MemberProvider>(context, listen: false).member?.memberId;
                              DateTime now = DateTime.now();
                              int year = now.year;
                              int month = now.month;
                              int day = now.day;
                              Provider.of<CalendarProvider>(context, listen: false).getMyCal(memberId!, year, month);
                              Provider.of<CalendarProvider>(context, listen: false).getData(memberId!, year, month);
                              Provider.of<CalendarProvider>(context, listen: false).getList(memberId!, year, month, day);
                              Provider.of<ScheduleProvider>(context, listen: false).getList(memberId!, year, month, day);
                              Provider.of<KingdomProvider>(context, listen: false).getKingdom(memberId!);
                              Provider.of<AchievementProvider>(context, listen: false).getAllData(memberId!);
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
                                  onPressed:(){
                                    Map<String,String> detail=Provider.of<ScheduleProvider>(context, listen: false).detail;
                                    Provider.of<RegistProvider>(context, listen: false).setData(detail);
                                    if (detail['type'] == '2') {
                                      // 여기서 루틴을 수정하는 페이지로 이동
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (
                                              context) => const ModifyRoutine())
                                      );
                                    } else {
                                      // 기존의 할 일(Todo) 수정 로직
                                      Provider.of<RegistProvider>(context, listen: false).setData(detail);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const ModifyTodo())
                                      );
                                    }
                                  },
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
                                  onPressed: () async {
                                    await Provider.of<ScheduleProvider>(context, listen: false).deleteSchedule();
                                    int? memberId = Provider.of<MemberProvider>(context, listen: false).member?.memberId;
                                    DateTime now = DateTime.now();
                                    int year = now.year;
                                    int month = now.month;
                                    int day = now.day;
                                    await Provider.of<CalendarProvider>(context, listen: false).getMyCal(memberId!, year, month);
                                    await Provider.of<CalendarProvider>(context, listen: false).getData(memberId!, year, month);
                                    await Provider.of<CalendarProvider>(context, listen: false).getList(memberId!, year, month, day);
                                    await Provider.of<ScheduleProvider>(context, listen: false).getList(memberId!, year, month, day);
                                    await Provider.of<KingdomProvider>(context, listen: false).getKingdom(memberId!);
                                    await Provider.of<AchievementProvider>(context, listen: false).getAllData(memberId!);
                                    Navigator.pop(context,);
                                  },
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
              )
          ),
        ),
    );
  }
}
