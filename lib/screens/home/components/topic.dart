import 'package:flutter/material.dart';

class Topic extends StatelessWidget {
  const Topic(
      {Key? key, required this.id, required this.name, this.isAdd = false})
      : super(key: key);

  final bool isAdd;
  final String id;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: containerDecoration(isAdd, context),
      padding: const EdgeInsets.all((16)),
      child: buildContent(name, isAdd, context),
    );
  }

  BoxDecoration containerDecoration(bool isAdd, BuildContext context) {
    if (isAdd) {
      return BoxDecoration(
          border: Border.all(width: 1, color: Theme.of(context).primaryColor),
          color: const Color.fromRGBO(19, 114, 240, 0.1),
          borderRadius: const BorderRadius.all(Radius.circular(10)));
    }

    return const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(10)));
  }

  Column buildContent(String name, bool isAdd, BuildContext context) {
    if (isAdd) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.add_alarm,
            size: 40,
            color: Theme.of(context).primaryColor,
          )
        ],
      );
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600)),
              const Text(
                "yesterday",
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "3 of 4",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ]);
  }
}
