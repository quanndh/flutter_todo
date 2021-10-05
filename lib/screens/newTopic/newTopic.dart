// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:test1/constants/theme.dart';

class NewTopic extends StatefulWidget {
  const NewTopic({Key? key}) : super(key: key);

  @override
  State<NewTopic> createState() => _NewTopicState();
}

class _NewTopicState extends State<NewTopic> {
  String _chosenColor = AppColors.colorToChose[0];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Stack(children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Color(int.parse(_chosenColor))),
              height: 300,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      maxLength: 20,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: "Your goal",
                        counter: SizedBox.shrink(),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2)),
                      ),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 24))
                ],
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(255, 255, 255, 0.3),
                ),
                child: IconButton(
                  icon: const Icon(Icons.close, size: 28, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ]),
          const SizedBox(
            height: 24,
          ),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: AppColors.colorToChose
                .map((e) => _itemBuilder(e, _chosenColor, onChoseColor))
                .toList(),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ElevatedButton(
                child: const Text("Create new goal"),
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(int.parse(_chosenColor))),
                  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 16, horizontal: 60))
                ),
              ),
            ),
          ),
          const SizedBox(height: 24,)
        ],
      ),
    );
  }

  void onChoseColor(String color) {
    setState(() {
      _chosenColor = color;
    });
  }

  Widget _itemBuilder(
      String color, String chosenColor, void Function(String) onChoseColor) {
    Widget? child;
    if (color == chosenColor) {
      child = const Icon(
        Icons.check,
        size: 24,
        color: Colors.white,
      );
    }

    return GestureDetector(
      onTap: () {
        onChoseColor(color);
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          border: Border.all(
              color: color == chosenColor
                  ? Color(int.parse(color))
                  : Colors.grey[300]!,
              width: 1.5),
        ),
        height: 50,
        width: 50,
        child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Color(int.parse(color)),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
            ),
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
