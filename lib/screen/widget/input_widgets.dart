import 'package:flutter/material.dart';
import 'package:stampee_personal/component/stamp_template.dart';
import 'package:stampee_personal/component/stamp.dart';
import 'package:stampee_personal/component/wrapper.dart';

class StampBookConfigCard extends StatefulWidget {
  const StampBookConfigCard({Key? key, required this.title, required this.comment}) : super(key: key);
  final Wrapper<String> title;
  final Wrapper<String> comment;

  @override
  _StampBookConfigCardState createState() => _StampBookConfigCardState(title, comment);
}

class _StampBookConfigCardState extends State<StampBookConfigCard> {
  _StampBookConfigCardState(this.title, this.comment);
  final Wrapper<String> title;
  final Wrapper<String> comment;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text('Stamp Book Settings', textScaleFactor: 1.5)),
            Divider(),
            Text('Title', textScaleFactor: 1.3),
            CustomTextField(text: this.title, hintText: 'required'),
            Divider(),
            Text('Comment', textScaleFactor: 1.3),
            Text('Comment on this book: Stamping rule etc. (This field is optional)'),
            CustomTextField(text: comment, maxLength: 200, lines: 6)
          ],
        ),
      ),
    );
  }
}

class RewardConfigCard extends StatefulWidget {
  const RewardConfigCard({Key? key, required this.title, required this.stampCount, required this.comment})
      : super(key: key);
  final Wrapper<String> title;
  final Wrapper<int> stampCount;
  final Wrapper<String> comment;
  @override
  _RewardConfigCardState createState() => _RewardConfigCardState(this.title, this.stampCount, this.comment);
}

class _RewardConfigCardState extends State<RewardConfigCard> {
  _RewardConfigCardState(this.title, this.stampCount, this.comment);
  Wrapper<String> title;
  Wrapper<int> stampCount;
  Wrapper<String> comment;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text('Reward', textScaleFactor: 1.5)),
            Text('Reward of this Stamp Book (Fields below are optional)'),
            Divider(),
            Text('Title', textScaleFactor: 1.3),
            CustomTextField(text: title),
            Divider(),
            Text('Stamp Count', textScaleFactor: 1.3),
            ButtonCounter(value: stampCount, min: 1),
            Divider(),
            Text('Comment', textScaleFactor: 1.3),
            CustomTextField(text: comment, maxLength: 200, lines: 6)
          ],
        ),
      ),
    );
  }
}

class StampTemplateConfigCard extends StatefulWidget {
  const StampTemplateConfigCard(
      {Key? key, required this.stampType, required this.icon, required this.text, required this.frame})
      : super(key: key);
  final Wrapper<StampType> stampType;
  final Wrapper<IconData> icon;
  final Wrapper<String> text;
  final Wrapper<StampFrame> frame;
  @override
  _StampTemplateConfigCardState createState() =>
      _StampTemplateConfigCardState(this.stampType, this.icon, this.text, this.frame);
}

class _StampTemplateConfigCardState extends State<StampTemplateConfigCard> {
  _StampTemplateConfigCardState(this.stampType, this.icon, this.text, this.frame);
  Wrapper<StampType> stampType = Wrapper<StampType>(StampType.icon);
  Wrapper<IconData> icon;
  Wrapper<String> text;
  Wrapper<StampFrame> frame;
  Stamp preview = Stamp.newStamp(DateTime.now());
  StampTemplate previewTemplate = StampTemplate.defaultTemplate;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text('StampTemplate', textScaleFactor: 1.5)),
            Divider(),
            Text('Icon Type', textScaleFactor: 1.3),
            Row(
              children: [
                Radio(
                    value: StampType.icon,
                    groupValue: this.stampType.value,
                    onChanged: (StampType? type) {
                      if (type != null) {
                        setState(() {
                          this.stampType.value = type;
                          this.previewTemplate.modify(stampType: this.stampType.value);
                        });
                      }
                    }),
                Text('Icon'),
                SizedBox(width: 20),
                Radio(
                    value: StampType.text,
                    groupValue: stampType.value,
                    onChanged: (StampType? type) {
                      if (type != null) {
                        setState(() {
                          this.stampType.value = type;
                          this.previewTemplate.modify(stampType: this.stampType.value);
                        });
                      }
                    }),
                Text('Text'),
              ],
            ),
            Divider(),
            iconArea(),
            Divider(),
            Text('Frame', textScaleFactor: 1.3),
            Row(
              children: [
                Radio(
                    value: StampFrame.none,
                    groupValue: this.frame.value,
                    onChanged: (StampFrame? frame) {
                      if (frame != null) {
                        setState(() {
                          this.frame.value = frame;
                          this.previewTemplate.modify(stampFrame: this.frame.value);
                        });
                      }
                    }),
                Text('None'),
                SizedBox(width: 20),
                Radio(
                    value: StampFrame.circle,
                    groupValue: this.frame.value,
                    onChanged: (StampFrame? frame) {
                      if (frame != null) {
                        setState(() {
                          this.frame.value = frame;
                          this.previewTemplate.modify(stampFrame: this.frame.value);
                        });
                      }
                    }),
                Text('Circle'),
                SizedBox(width: 20),
                Radio(
                    value: StampFrame.square,
                    groupValue: this.frame.value,
                    onChanged: (StampFrame? frame) {
                      if (frame != null) {
                        setState(() {
                          this.frame.value = frame;
                          this.previewTemplate.modify(stampFrame: this.frame.value);
                        });
                      }
                    }),
                Text('Square'),
              ],
            ),
            Divider(),
            Text('Preview', textScaleFactor: 1.3),
            preview.show(template: previewTemplate),
          ],
        ),
      ),
    );
  }

  Widget iconArea() {
    switch (this.stampType.value) {
      case StampType.icon:
        List<Widget> icons = [];
        Map<String, IconData> rawData = StampTemplate.iconList;
        rawData.forEach((key, value) {
          icons.add(IconButton(
              icon: Icon(value, size: 20),
              onPressed: () {
                setState(() {
                  this.icon.value = value;
                  this.previewTemplate.modify(icon: this.icon.value);
                });
              }));
        });
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Icon', textScaleFactor: 1.3),
            GridView.extent(
              maxCrossAxisExtent: 60,
              children: icons,
              shrinkWrap: true,
            ),
          ],
        );
      case StampType.text:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Icon Text', textScaleFactor: 1.3),
            CustomTextField(
              text: this.text,
              maxLength: 10,
              onPressed: (String value) {
                this.text.value = value;
                setState(() {
                  this.previewTemplate.modify(text: this.text.value);
                });
              },
            ),
          ],
        );
    }
  }
}

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key, required this.text, this.maxLength = 20, this.lines = 1, this.onPressed, this.hintText = 'optional'})
      : super(key: key);
  final Wrapper<String> text;
  final int maxLength;
  final int lines;
  final Function(String value)? onPressed;
  final String hintText;

  @override
  _CustomTextFieldState createState() =>
      _CustomTextFieldState(text: text, maxLength: maxLength, lines: lines, onPressed: onPressed, hintText: hintText);
}

class _CustomTextFieldState extends State<CustomTextField> {
  _CustomTextFieldState(
      {required this.text, required this.maxLength, required this.lines, this.onPressed, required this.hintText});
  Wrapper<String> text;
  final int maxLength;
  final int lines;
  Function(String value)? onPressed;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    if (onPressed == null) {
      onPressed = (String value) {
        text.value = value;
      };
    }
    return TextField(
      controller: TextEditingController.fromValue(
          TextEditingValue(text: text.value, selection: TextSelection.collapsed(offset: text.value.length))),
      maxLength: maxLength,
      minLines: lines,
      maxLines: lines,
      onChanged: onPressed,
      decoration: InputDecoration(hintText: hintText),
    );
  }
}

class ButtonCounter extends StatefulWidget {
  const ButtonCounter({Key? key, required this.value, this.min = 0, this.max = 1000}) : super(key: key);
  final Wrapper<int> value;
  final int min;
  final int max;

  @override
  _ButtonCounterState createState() => _ButtonCounterState(this.value, this.min, this.max);
}

class _ButtonCounterState extends State<ButtonCounter> {
  _ButtonCounterState(this.value, this.min, this.max);
  Wrapper<int> value;
  int min;
  int max;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      children: [
        RoundButton(
            onPressed: () {
              setState(() {
                if (value.value > min) {
                  value.value--;
                }
              });
            },
            child: Center(
              child: Text(
                '-',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Colors.white),
              ),
            )),
        Text(value.toString().padLeft(2, '0'), textScaleFactor: 1.5),
        RoundButton(
            onPressed: () {
              setState(() {
                if (value.value < max) {
                  setState(() {
                    value.value++;
                  });
                }
              });
            },
            child: Center(
              child: Text(
                '+',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Colors.white),
              ),
            ))
      ],
    );
  }
}

class RoundButton extends StatelessWidget {
  const RoundButton({Key? key, required this.onPressed, required this.child, this.size = 20}) : super(key: key);
  final Function() onPressed;
  final Widget child;
  final double size;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: this.onPressed,
        child: Container(
          height: this.size,
          width: this.size,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(size / 2),
          ),
          child: child,
        ));
  }
}
