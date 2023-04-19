import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'addPage.dart';
import 'task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedNewTypeColorNameProvider = StateProvider.autoDispose((ref) {
  return "073 Love Kiss"; //タスクタイプ追加時の選択中の色
});

final newTaskNameProvider = StateProvider<String>((ref) {
  return ""; //タスクタイプ追加時の新しいタスクの名前
});

final addTaskNameProvider = StateProvider<String>((ref) {
  return "勉強"; //addPageで追加しようとしているタスクの名前
});

final addTaskMemoProvider = StateProvider<String>((ref) {
  return ''; //addPageで追加しようとしているタスクのメモ
});

final addTaskStartYearProvider = StateProvider<String>((ref) {
  return '${DateTime.now().year}'; //addPageで追加しようとしているタスクの年
});

final addTaskStartDateProvider = StateProvider<String>((ref) {
  return '${DateTime.now().month}/${DateTime.now().day}';
});

final addTaskStartTimeHourProvider = StateProvider<String>((ref) {
  return '${DateTime.now().hour}';
});

final addTaskStartTimeMinuteProvider = StateProvider<String>((ref) {
  return '00';
});

final addTaskEndYearProvider = StateProvider<String>((ref) {
  return '${DateTime.now().year}';
});

final addTaskEndDateProvider = StateProvider<String>((ref) {
  return '${DateTime.now().month}/${DateTime.now().day}';
});

final addTaskEndTimeHourProvider = StateProvider<String>((ref) {
  return '${DateTime.now().hour}';
});

final addTaskEndTimeMinuteProvider = StateProvider<String>((ref) {
  return '00';
});

final changeTaskIdProvider = StateProvider<int?>((ref) => null);

final addTaskIdProvider = StateProvider((ref) => 8); //本来はスケジュールがゼロから始まるから0にする

class UserScheduleNotifier extends StateNotifier<List<Task>> {
  UserScheduleNotifier()
      : super([
          Task('睡眠', '', '23:00', '05:00', '4/23', '4/24', 0),
          Task('ゆったり', 'コーヒーのむ', '06:00', '07:00', '4/24', '4/24', 1),
          Task('移動', '袖ヶ浦 → 筑波🚃', '07:00', '10:00', '4/24', '4/24', 2),
          Task('勉強', '高橋先生 訪問', '11:00', '12:30', '4/24', '4/24', 3),
          Task('ゆったり', '昼食🍔', '12:30', '13:30', '4/24', '4/24', 4),
          Task('勉強', '志築先生 訪問', '13:30', '15:00', '4/24', '4/24', 5),
          Task('移動', '筑波 → 袖ヶ浦🚃', '16:00', '19:00', '4/24', '4/24', 6),
          Task('ゆったり', '本読む', '05:00', '06:00', '4/24', '4/24', 7),
        ]); //スタートタイムとエンドタイムをDateTime型で表したい

  void sortSchedule() {
    //時系列でソートする
  }

  void removeSchedule(int? id) {
    //変更の時(changeTaskIndexがnullじゃないときはタスクを削除する)
    state = [
      for (final task in state)
        if (task.id != id) task,
    ];
  }
}

final userSheduleProvider =
    StateNotifierProvider<UserScheduleNotifier, List<Task>>((ref) {
  return UserScheduleNotifier();
});

final taskTypeMapProvider = StateProvider<Map>((ref) {
  return {
    //デフォルトのタイプをここで定義する
    "勉強": const [
      Color.fromRGBO(79, 172, 254, 1),
      Color.fromRGBO(0, 242, 254, 1),
    ],
    "仕事": const [
      Color.fromRGBO(255, 8, 68, 1),
      Color.fromRGBO(255, 177, 153, 1),
    ],
    "運動": const [
      Color.fromRGBO(102, 126, 234, 1),
      Color.fromRGBO(118, 75, 162, 1),
    ],
    "移動": const [
      Color.fromRGBO(250, 112, 154, 1),
      Color.fromRGBO(254, 225, 64, 1),
    ],
    "ゆったり": const [
      Color.fromRGBO(155, 225, 93, 1),
      Color.fromRGBO(0, 227, 174, 1),
    ],
    "睡眠": const [
      Color.fromRGBO(30, 60, 114, 1),
      Color.fromRGBO(42, 82, 152, 1),
    ],
  };
});

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'jasuna',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SchedulePage(),
    );
  }
}

class SchedulePage extends ConsumerWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.white.withOpacity(0.5),
        title: createDateTitle(),
        centerTitle: false,
        actions: [
          /* IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                size: 28,
                color: Colors.black,
              )),*/
          IconButton(
              onPressed: () async {
                //初期化する
                ref.read(addTaskNameProvider.notifier).update((state) => "勉強");
                ref.read(addTaskMemoProvider.notifier).update((state) => "");
                ref.read(addTaskStartDateProvider.notifier).update(
                    (state) => '${DateTime.now().month}/${DateTime.now().day}');
                ref.read(addTaskEndDateProvider.notifier).update(
                    (state) => '${DateTime.now().month}/${DateTime.now().day}');
                ref
                    .read(addTaskStartTimeHourProvider.notifier)
                    .update((state) => '${DateTime.now().hour}');
                ref
                    .read(addTaskStartTimeMinuteProvider.notifier)
                    .update((state) => "00");
                ref
                    .read(addTaskEndTimeHourProvider.notifier)
                    .update((state) => '${DateTime.now().hour}');
                ref
                    .read(addTaskEndTimeMinuteProvider.notifier)
                    .update((state) => "00");
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddPage()),
                );
              },
              icon: const Icon(
                Icons.add,
                size: 28,
                color: Colors.black,
              ))
        ],
        elevation: 0,
        toolbarHeight: 40,
        systemOverlayStyle:
            SystemUiOverlayStyle.dark, //時間とかバッテリーとか（ステータスバー）の表示が黒くなる
      ),
      body: const SchedulePageBody(),
    );
  }
}

Row createDateTitle() {
  var now = DateTime.now();
  var weekDay = now.weekday;
  String youbi = '日月火水木金土日';
  youbi = youbi[weekDay];
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.baseline,
    textBaseline: TextBaseline.alphabetic,
    children: [
      Text(
        '${now.year}',
        style: const TextStyle(fontSize: 22, color: Colors.black),
      ),
      const Text(
        '年',
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      Text(
        '${now.month}',
        style: const TextStyle(fontSize: 22, color: Colors.black),
      ),
      const Text(
        '月',
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      Text(
        '${now.day}',
        style: const TextStyle(fontSize: 22, color: Colors.black),
      ),
      const Text(
        '日  ',
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      Text(
        '$youbi曜日',
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    ],
  );
}

class SchedulePageBody extends ConsumerWidget {
  const SchedulePageBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> userSchedule = ref.watch(userSheduleProvider);

    if (userSchedule.isEmpty) {
      return const Center(
        child: Text(
          '予定がありません🤔\n右上の➕からあなたの計画を追加しましょう💪',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: userSchedule.length,
          itemBuilder: ((context, index) {
            return Padding(
                padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                child: Dismissible(
                    key: Key(userSchedule[index].typeName),
                    onDismissed: (DismissDirection direction) {
                      userSchedule.removeAt(index);
                      ref.read(userSheduleProvider.notifier).state = [
                        ...userSchedule
                      ];
                    },
                    background: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.red,
                      ),
                      alignment: Alignment.centerRight,
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          Icons.delete,
                          size: 30,
                        ),
                      ),
                    ),
                    //cardの外側の余白
                    child: InkWell(
                      onTap: () async {
                        //タスクをタップで変更
                        //現在の情報を持ってaddpageに遷移しているだけ
                        //変更された時は変更後のタスクを削除する必要がある
                        ref
                            .read(addTaskNameProvider.notifier)
                            .update((state) => userSchedule[index].typeName);
                        ref
                            .read(addTaskMemoProvider.notifier)
                            .update((state) => userSchedule[index].memo);
                        ref.read(addTaskStartDateProvider.notifier).update(
                            (state) => userSchedule[index].startDateStr);
                        ref
                            .read(addTaskEndDateProvider.notifier)
                            .update((state) => userSchedule[index].endDateStr);
                        ref.read(addTaskStartTimeHourProvider.notifier).update(
                            (state) =>
                                userSchedule[index].startTimeStr.split(':')[0]);
                        ref
                            .read(addTaskStartTimeMinuteProvider.notifier)
                            .update((state) =>
                                userSchedule[index].startTimeStr.split(':')[1]);
                        ref.read(addTaskEndTimeHourProvider.notifier).update(
                            (state) =>
                                userSchedule[index].endTimeStr.split(':')[0]);
                        ref.read(addTaskEndTimeMinuteProvider.notifier).update(
                            (state) =>
                                userSchedule[index].endTimeStr.split(':')[1]);
                        ref
                            .read(changeTaskIdProvider.notifier)
                            .update((state) => index);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddPage()),
                        );
                      },
                      child: ShowCard(
                        title: userSchedule[index].typeName,
                        memo: userSchedule[index].memo,
                        startTimeStr: userSchedule[index].startTimeStr,
                        endTimeStr: userSchedule[index].endTimeStr,
                        startDateStr: userSchedule[index].startDateStr,
                        endDateStr: userSchedule[index].endDateStr,
                      ),
                    )));
          }));
    }
  }
}
