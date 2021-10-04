import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/constants/theme.dart';
import 'package:test1/models/topic.dart';
import 'package:test1/request/request.dart';

import 'components/topic.dart';

class CounterCubit extends Cubit<int> {
  final int init;
  CounterCubit({required this.init}) : super(init);

  void increment() => emit(state + 1);

  void reset() => emit(init);
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TopicModel> topics = [];
  final cubit = CounterCubit(init: 10);

  @override
  void initState() {
    super.initState();
    getTopic().then((value) => setState(() {
          topics = value;
        }));
    cubit.close();  
    print(cubit.isClosed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Goals",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Recent",
                    style: TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    size: 20,
                    color: AppColors.grey,
                  )
                ],
              ),
              Icon(
                Icons.list,
                size: 28,
                color: AppColors.grey,
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: GridView.count(
              primary: false,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: 2,
              children: <Widget>[
                ...topics.map((e) => Topic(id: e.id, name: e.name)).toList(),
                const Topic(
                  id: "0",
                  name: "add",
                  isAdd: true,
                ),
              ],
            ),
          )
        ]),
      )),
    );
  }
}
