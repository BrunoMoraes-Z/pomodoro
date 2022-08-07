import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_web/shared/constants.dart';

class NumberSelector extends StatefulWidget {
  const NumberSelector({
    Key? key,
    required this.onChange,
    this.defaultTime = 1,
  }) : super(key: key);

  final Function(int) onChange;
  final int defaultTime;

  @override
  State<NumberSelector> createState() => _NumberSelectorState();
}

class _NumberSelectorState extends State<NumberSelector> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    textEditingController.addListener(() {
      widget.onChange(int.parse(textEditingController.value.text.trim()));
    });
    textEditingController.text = '${widget.defaultTime}';
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void _increment() {
    var value = int.tryParse(textEditingController.value.text) ?? 0;
    setState(() {
      value = ++value;
      if (value > 60) value = 60;
      textEditingController.text = '$value';
    });
  }

  void _decrement() {
    var value = int.tryParse(textEditingController.value.text) ?? 0;
    setState(() {
      value = --value;
      if (value < 1) value = 1;
      textEditingController.text = '$value';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: constants.blue1.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          SizedBox(
            height: 48,
            width: 20,
            child: TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
            ),
          ),
          SizedBox(
            height: double.infinity,
            width: 32,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: _increment,
                    child: const Icon(
                      Icons.arrow_drop_up,
                      size: 18,
                    ),
                  ),
                  InkWell(
                    onTap: _decrement,
                    child: const Icon(
                      Icons.arrow_drop_down,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
