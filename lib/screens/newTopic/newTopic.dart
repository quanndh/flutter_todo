// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:test1/constants/ennviroment.dart';
import 'package:test1/constants/theme.dart';
import 'package:test1/data/dtos/topics/create_topic_dto.dart';
import 'package:test1/data/models/topic.dart';
import 'package:test1/data/services/networking/api_provider.dart';
import 'package:test1/data/services/networking/topic_service.dart';

class NewTopic extends StatefulWidget {
  final Function(TopicModel) addNewTopic;
  const NewTopic({Key? key, required this.addNewTopic}) : super(key: key);

  @override
  State<NewTopic> createState() => _NewTopicState();
}

class _NewTopicState extends State<NewTopic> {
  String _chosenColor = AppColors.colorToChose[0];
  String _err = "";
  final _nameCtl = TextEditingController();

  final topicService = TopicService(
      apiProvider:
          ApiProvider(appEnv: AppEnv(baseUrl: "http://localhost:3000")));

  @override
  void dispose() {
    _nameCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: isKeyboard ? 150 : 300,
                padding: const EdgeInsets.all(20),
                decoration:
                    BoxDecoration(color: Color(int.parse(_chosenColor))),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                        autofocus: false,
                        controller: _nameCtl,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        maxLength: 20,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            errorText: _err.isNotEmpty ? _err : null,
                            errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: _err.isNotEmpty
                                        ? Colors.red
                                        : Colors.white,
                                    width: 2)),
                            hintText: "Your goal",
                            counter: const SizedBox.shrink(),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2))),
                        style: const TextStyle(
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
                    icon:
                        const Icon(Icons.close, size: 28, color: Colors.white),
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
            if(!isKeyboard) const SizedBox(
              height: 24,
            ),
            Flexible(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ElevatedButton(
                  child: const Text("Create new goal"),
                  onPressed: () {
                    _handleCreateTopic(context);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color(int.parse(_chosenColor))),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 60))),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
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

  void onChoseColor(String color) {
    setState(() {
      _chosenColor = color;
    });
  }

  void _handleCreateTopic(BuildContext context) async {
    var name = _nameCtl.text;
    if (name.isEmpty == true) {
      setState(() {
        _err = "Your goal is empty";
      });
      return;
    }

    setState(() {
      _err = "";
    });

    final res = await topicService
        .createTopic(CreateTopicDto(name: name, color: _chosenColor));
    widget.addNewTopic(res!);
    Navigator.pop(context);
  }
}
