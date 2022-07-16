import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/generalwidget/rounded_hotspot_widget.dart';
import 'provider/keyboard_provider.dart';
import 'widgets/keyboard_item.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<KeyboardProvider>(
      builder: (BuildContext context, value, Widget child) =>
          (!value.keyboardState)
              ? SizedBox()
              : RoundedHotSpotWidget(
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KeyboardItem(
                              text: "1",
                            ),
                            KeyboardItem(
                              text: "2",
                            ),
                            KeyboardItem(
                              text: "3",
                            ),
                            KeyboardItem(
                              text: "4",
                            ),
                            KeyboardItem(
                              text: "5",
                            ),
                            KeyboardItem(
                              text: "6",
                            ),
                            KeyboardItem(
                              text: "7",
                            ),
                            KeyboardItem(
                              text: "8",
                            ),
                            KeyboardItem(
                              text: "9",
                            ),
                            KeyboardItem(
                              text: "0",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KeyboardItem(
                              text: "Q",
                            ),
                            KeyboardItem(
                              text: "W",
                            ),
                            KeyboardItem(
                              text: "E",
                            ),
                            KeyboardItem(
                              text: "R",
                            ),
                            KeyboardItem(
                              text: "T",
                            ),
                            KeyboardItem(
                              text: "Y",
                            ),
                            KeyboardItem(
                              text: "U",
                            ),
                            KeyboardItem(
                              text: "I",
                            ),
                            KeyboardItem(
                              text: "O",
                            ),
                            KeyboardItem(
                              text: "P",
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KeyboardItem(
                              text: "A",
                            ),
                            KeyboardItem(
                              text: "S",
                            ),
                            KeyboardItem(
                              text: "D",
                            ),
                            KeyboardItem(
                              text: "F",
                            ),
                            KeyboardItem(
                              text: "G",
                            ),
                            KeyboardItem(
                              text: "H",
                            ),
                            KeyboardItem(
                              text: "J",
                            ),
                            KeyboardItem(
                              text: "K",
                            ),
                            KeyboardItem(
                              text: "L",
                            ),
                            KeyboardItem(
                              text: "back",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KeyboardItem(
                              text: "clear",
                            ),
                            KeyboardItem(
                              text: "Z",
                            ),
                            KeyboardItem(
                              text: "X",
                            ),
                            KeyboardItem(
                              text: "C",
                            ),
                            KeyboardItem(
                              text: "V",
                            ),
                            KeyboardItem(
                              text: "B",
                            ),
                            KeyboardItem(
                              text: "N",
                            ),
                            KeyboardItem(
                              text: "M",
                            ),
                            KeyboardItem(
                              text: "enter",
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
    );
  }
}
