import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'main.dart';
import 'task.dart';
import 'taskManager.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddPage extends ConsumerWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addTaskName = ref.watch(addTaskNameProvider);
    final addTaskMemo = ref.watch(addTaskMemoProvider);
    final taskStartYear = ref.watch(addTaskStartYearProvider);
    final taskStartDate = ref.watch(addTaskStartDateProvider);
    final taskStartTimeHour = ref.watch(addTaskStartTimeHourProvider);
    final taskStartTimeMinute = ref.watch(addTaskStartTimeMinuteProvider);
    final taskEndYear = ref.watch(addTaskEndYearProvider);
    final taskEndDate = ref.watch(addTaskEndDateProvider);
    final taskEndTimeHour = ref.watch(addTaskEndTimeHourProvider);
    final taskEndTimeMinute = ref.watch(addTaskEndTimeMinuteProvider);
    final changeTaskId = ref.watch(changeTaskIdProvider);

    List<Task> userShedule = ref.read(userSheduleProvider);
    final addTaskId = ref.watch(addTaskIdProvider);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 40,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'タスク追加',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            behavior: HitTestBehavior.opaque,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                child: Column(children: [
                  const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Preview',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.left,
                      )),
                  const SizedBox(
                    height: 12,
                  ),
                  ShowCard(
                    //プレビュー部分 選択中のタスクになるように今後状態管理する
                    title: addTaskName,
                    memo: addTaskMemo,
                    startTimeStr: '$taskStartTimeHour:$taskStartTimeMinute',
                    endTimeStr: '$taskEndTimeHour:$taskEndTimeMinute',
                    startDateStr: taskStartDate,
                    endDateStr: taskEndDate,
                    isImmutableHeight: true,
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'TaskType',
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(12))),
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                      child: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    child: const CreateNewTypeWindow(),
                                  ));
                                });
                          },
                          child: const Text('新規タスク作成'))
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: ShowTaskTypeList(),
                  ),
                  TextFormField(
                    //memo
                    initialValue: addTaskMemo,
                    maxLines: 2,
                    decoration: const InputDecoration(
                        labelText: 'Memo',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12)))),
                    onChanged: (value) {
                      ref
                          .read(addTaskMemoProvider.notifier)
                          .update((state) => value);
                    },
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        //startDate
                        onTap: () {
                          DatePicker.showDateTimePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2022, 1, 1),
                              maxTime: DateTime(2030, 12, 31),
                              currentTime: DateTime.now(), onConfirm: (time) {
                            ref
                                .read(addTaskStartDateProvider.notifier)
                                .update((state) => "${time.month}/${time.day}");
                            ref
                                .read(addTaskStartTimeHourProvider.notifier)
                                .update((state) => "${time.hour}");
                            ref
                                .read(addTaskStartTimeMinuteProvider.notifier)
                                .update((state) => "${time.minute}".padLeft(2,
                                    '0')); // fixed from @Sakatuki_jugyou 2023/04/19 (Wed)  [add .padLeft(2, '0')]
                            ref
                                .read(addTaskEndDateProvider.notifier)
                                .update((state) => "${time.month}/${time.day}");
                            ref
                                .read(addTaskEndTimeHourProvider.notifier)
                                .update((state) => "${time.hour}");
                            ref
                                .read(addTaskEndTimeMinuteProvider.notifier)
                                .update((state) => "${time.minute}".padLeft(2,
                                    '0')); // fixed from @Sakatuki_jugyou 2023/04/19 (Wed)  [add .padLeft(2, '0')]
                          }, locale: LocaleType.jp);
                        },
                        child: Column(children: [
                          Text(
                            '$taskStartYear/$taskStartDate',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.blue),
                          ),
                          Text(
                            '$taskStartTimeHour:$taskStartTimeMinute',
                            style: const TextStyle(
                                fontSize: 36, color: Colors.blue),
                          ),
                        ]),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 36,
                      ),
                      InkWell(
                        //endDate
                        onTap: () {
                          DatePicker.showDateTimePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2022, 1, 1),
                              maxTime: DateTime(2030, 12, 31),
                              currentTime: DateTime.now(), onConfirm: (time) {
                            ref
                                .read(addTaskEndDateProvider.notifier)
                                .update((state) => "${time.month}/${time.day}");
                            ref
                                .read(addTaskEndTimeHourProvider.notifier)
                                .update((state) => "${time.hour}");
                            ref
                                .read(addTaskEndTimeMinuteProvider.notifier)
                                .update((state) => "${time.minute}".padLeft(2,
                                    '0')); // fixed from @Sakatuki_jugyou 2023/04/19 (Wed)  [add .padLeft(2, '0')]
                          }, locale: LocaleType.jp);
                        },
                        child: Column(children: [
                          Text(
                            '$taskEndYear/$taskEndDate',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.blue),
                          ),
                          Text(
                            '$taskEndTimeHour:$taskEndTimeMinute',
                            style: const TextStyle(
                                fontSize: 36, color: Colors.blue),
                          ),
                        ]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CreateAddTimeButton(addTime: 5, unit: '分'),
                      CreateAddTimeButton(addTime: 10, unit: '分'),
                      CreateAddTimeButton(addTime: 30, unit: '分'),
                      CreateAddTimeButton(addTime: 1, unit: '時間'),
                    ],
                  ),
                  const SizedBox(
                    height: 46,
                  ),
                  ElevatedButton(
                      //完了ボタン
                      onPressed: () {
                        if (changeTaskId == null) {
                          userShedule.add(Task(
                              addTaskName,
                              addTaskMemo,
                              '$taskStartTimeHour:$taskStartTimeMinute',
                              '$taskEndTimeHour:$taskEndTimeMinute',
                              taskStartDate,
                              taskEndDate,
                              addTaskId));
                          ref.read(userSheduleProvider.notifier).state = [
                            ...userShedule
                          ];
                          ref
                              .read(addTaskIdProvider.notifier)
                              .update((state) => state = addTaskId + 1);
                        } else {
                          userShedule.add(Task(
                              addTaskName,
                              addTaskMemo,
                              '$taskStartTimeHour:$taskStartTimeMinute',
                              '$taskEndTimeHour:$taskEndTimeMinute',
                              taskStartDate,
                              taskEndDate,
                              addTaskId));
                          ref
                              .read(userSheduleProvider.notifier)
                              .removeSchedule(changeTaskId);
                          ref
                              .read(addTaskIdProvider.notifier)
                              .update((state) => state = addTaskId + 1);
                          ref
                              .read(changeTaskIdProvider.notifier)
                              .update((state) => state = null);
                        }
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(60, 60)),
                        shape: MaterialStateProperty.all<CircleBorder>(
                          const CircleBorder(
                            side: BorderSide(
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                        elevation: MaterialStateProperty.all<double>(6.0),
                      ),
                      child: const Icon(Icons.add)),
                ]),
              ),
            )));
  }
}

class CreateAddTimeButton extends ConsumerWidget {
  const CreateAddTimeButton({
    super.key,
    required this.addTime,
    required this.unit,
  });
  final int addTime;
  final String unit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskEndTimeHour = ref.watch(addTaskEndTimeHourProvider);
    final taskEndTimeMinute = ref.watch(addTaskEndTimeMinuteProvider);
    int newEndTimeMinute = int.parse(taskEndTimeMinute);
    int newEndTimeHour = int.parse(taskEndTimeHour);

    return SizedBox(
      height: 60,
      width: 80,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            if (unit == '分') {
              newEndTimeMinute += addTime;
              if (newEndTimeMinute >= 60) {
                //60分を超えたら時間に繰り上げる
                newEndTimeMinute -= 60;
                newEndTimeHour += 1;
                ref.read(addTaskEndTimeMinuteProvider.notifier).update(
                    (state) =>
                        "${newEndTimeMinute}".toString().padLeft(2, '0'));
                ref
                    .read(addTaskEndTimeHourProvider.notifier)
                    .update((state) => state = '$newEndTimeHour');
              } else {
                ref.read(addTaskEndTimeMinuteProvider.notifier).update(
                    (state) =>
                        "${newEndTimeMinute}".toString().padLeft(2, '0'));
              }
            } else {
              //追加する単位が時間の時
              newEndTimeHour += addTime;
              ref
                  .read(addTaskEndTimeHourProvider.notifier)
                  .update((state) => state = '$newEndTimeHour');
            }
          },
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '+$addTime',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  unit,
                  style: const TextStyle(fontSize: 12),
                ),
              ])),
    );
  }
}

class ShowTaskTypeList extends ConsumerWidget {
  const ShowTaskTypeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var taskTypeMap = ref.watch(taskTypeMapProvider);
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: taskTypeMap.length,
        itemBuilder: ((context, index) {
          var key = taskTypeMap.keys.elementAt(index);
          return InkWell(
            onTap: () {
              ref.read(addTaskNameProvider.notifier).update((state) => key);
            },
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                children: [
                  Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: taskTypeMap[key],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight)),
                  ),
                  const SizedBox(height: 4),
                  Text(key)
                ],
              ),
            ),
          );
        }));
  }
}

//シートでしたから表示される部分
class CreateNewTypeWindow extends ConsumerWidget {
  const CreateNewTypeWindow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectColorName = ref.watch(selectedNewTypeColorNameProvider);
    final newTaskName = ref.watch(newTaskNameProvider);
    var colorMapObj = TaskManarger().colorMap;
    var taskTypeMap = ref.read(taskTypeMapProvider);

    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), //textFieldのfocusを外す
        behavior: HitTestBehavior.opaque, //showModalBottomSheetだとこれがいるっぽい
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  '新規タイプ作成',
                  style: TextStyle(fontSize: 22.0),
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: colorMapObj[selectColorName],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      ref
                          .read(newTaskNameProvider.notifier)
                          .update((state) => value);
                    },
                    decoration: const InputDecoration(
                      hintText: 'タスク名',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          //選択されてない時の枠線をなくす
                          borderSide: BorderSide.none),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  itemCount: colorMapObj.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6, // 横1行あたりに表示するWidgetの数
                    crossAxisSpacing: 6, // Widget間のスペース（左右）
                    mainAxisSpacing: 6, // Widget間のスペース（上下）
                  ),
                  padding: const EdgeInsets.all(6), // 全体の余白
                  itemBuilder: (context, index) {
                    var key = colorMapObj.keys.elementAt(index);
                    return InkWell(
                      onTap: () {
                        ref
                            .read(selectedNewTypeColorNameProvider.notifier)
                            .update((state) => key);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors: colorMapObj[key],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight)),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    taskTypeMap[newTaskName] = colorMapObj[selectColorName];
                    ref.read(taskTypeMapProvider.notifier).state = {
                      ...taskTypeMap
                    };
                    ref
                        .read(addTaskNameProvider.notifier)
                        .update((state) => state = newTaskName);
                    Navigator.pop(context);
                  },
                  child: const Text('完了'),
                ),
              ],
            )));
  }
}
