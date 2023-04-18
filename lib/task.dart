import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'main.dart';

class Task {
  late String typeName; //例：勉強など
  late String? memo; //例：英単語
  late String startTimeStr;
  late String endTimeStr;
  late String startDateStr;
  late String endDateStr;
  late bool isPreview;

  Task(this.typeName, this.memo, this.startTimeStr, this.endTimeStr,
      this.startDateStr, this.endDateStr);

  static double _makeDuration({
    required String startTimeStr,
    required String endTimeStr,
    required String startDateStr,
    required String endDateStr,
  }) {
    //showCard内でContainerの高さを決めるのに使う
    var startHour = double.parse(startTimeStr.split(':')[0]);
    var startMinute = double.parse(startTimeStr.split(':')[1]);
    var endHour = double.parse(endTimeStr.split(':')[0]);
    var endMinute = double.parse(endTimeStr.split(':')[1]);
    var startMonth = double.parse(startDateStr.split('/')[0]);
    var startDay = double.parse(startDateStr.split('/')[1]);
    var endMonth = double.parse(endDateStr.split('/')[0]);
    var endDay = double.parse(endDateStr.split('/')[1]);
    double duration = 54; //最小の高さ

    if (startDateStr == endDateStr) {
      duration = (endHour * 60 + endMinute) - (startHour * 60 + startMinute);
    } else if (startMonth == endMonth && startDay != endDay) {
      //タスクが日を跨いでる時
      duration =
          ((endHour + 24) * 60 + endMinute) - (startHour * 60 + startMinute);
    }
    if (duration < 54) {
      duration = 54;
    }
    return duration;
  }
}

class ShowCard extends ConsumerWidget {
  ShowCard({
    super.key,
    required this.title,
    required this.memo,
    required this.startTimeStr,
    required this.endTimeStr,
    required this.startDateStr,
    required this.endDateStr,
    this.isImmutableHeight = false,
  });

  String title;
  String memo;
  String startTimeStr;
  String endTimeStr;
  String startDateStr;
  String endDateStr;
  bool isImmutableHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double duration = Task._makeDuration(
        startTimeStr: startTimeStr,
        endTimeStr: endTimeStr,
        startDateStr: startDateStr,
        endDateStr: endDateStr);
    if (isImmutableHeight == true) {
      duration = 80;
    }
    var taskTypeMap = ref.watch(taskTypeMapProvider);
    return Container(
        padding: const EdgeInsets.fromLTRB(14, 6, 14, 6), //cardの内側の余白
        height: duration,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0.1,
                  blurRadius: 12,
                  offset: Offset(2, 5))
            ],
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
                colors: taskTypeMap[title],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                memo,
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('$startDateStr $startTimeStr',
                    style: const TextStyle(fontSize: 14, color: Colors.white)),
                Text('$endDateStr $endTimeStr',
                    style: const TextStyle(fontSize: 14, color: Colors.white)),
              ],
            ),
          ],
        ));
  }
}
