import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'addPage.dart';
import 'task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedNewTypeColorNameProvider = StateProvider.autoDispose((ref) {
  return "073 Love Kiss";
});

final newTaskNameProvider = StateProvider<String>((ref) {
  return "";
});

final addTaskNameProvider = StateProvider<String>((ref) {
  return "勉強";
});

final addTaskMemoProvider = StateProvider.autoDispose((ref) {
  return '';
});

final taskStartYearProvider = StateProvider<String>((ref) {
  return '${DateTime.now().year}';
});

final taskStartDateProvider = StateProvider<String>((ref) {
  return '${DateTime.now().month}/${DateTime.now().day}';
});

final taskStartTimeHourProvider = StateProvider<String>((ref) {
  return '${DateTime.now().hour}';
});

final taskStartTimeMinuteProvider = StateProvider<String>((ref) {
  return '00';
});

final taskEndYearProvider = StateProvider<String>((ref) {
  return '${DateTime.now().year}';
});

final taskEndDateProvider = StateProvider<String>((ref) {
  return '${DateTime.now().month}/${DateTime.now().day}';
});

final taskEndTimeHourProvider = StateProvider<String>((ref) {
  return '${DateTime.now().hour}';
});

final taskEndTimeMinuteProvider = StateProvider<String>((ref) {
  return '00';
});

final userSheduleProvider = StateProvider<List>((ref) => [
      Task('睡眠', '', '23:00', '06:00', '4/23', '4/24'),
      Task('ゆったり', 'コーヒーのむ', '06:00', '07:00', '4/24', '4/24'),
      Task('移動', '袖ヶ浦 → 筑波🚃', '07:00', '10:00', '4/24', '4/24'),
      Task('勉強', '高橋先生 訪問', '11:00', '12:30', '4/24', '4/24'),
      Task('ゆったり', '昼食🍔', '12:30', '13:30', '4/24', '4/24'),
      Task('勉強', '志築先生 訪問', '13:30', '15:00', '4/24', '4/24'),
      Task('移動', '筑波 → 袖ヶ浦🚃', '16:00', '19:00', '4/24', '4/24'),
    ]);

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
          // IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.edit,
          //       size: 28,
          //       color: Colors.black,
          //     )),
          IconButton(
              onPressed: () async {
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
  String youbi = '';

  switch (weekDay) {
    case 1:
      youbi = '月';
      break;
    case 2:
      youbi = '火';
      break;
    case 3:
      youbi = '水';
      break;
    case 4:
      youbi = '木';
      break;
    case 5:
      youbi = '金';
      break;
    case 6:
      youbi = '土';
      break;
    case 7:
      youbi = '日';
      break;
  }

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
    var userSchedule = ref.watch(userSheduleProvider);

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
                    child: ShowCard(
                      title: userSchedule[index].typeName,
                      memo: userSchedule[index].memo,
                      startTimeStr: userSchedule[index].startTimeStr,
                      endTimeStr: userSchedule[index].endTimeStr,
                      startDateStr: userSchedule[index].startDateStr,
                      endDateStr: userSchedule[index].endDateStr,
                    )));
          }));
    }
  }
}
