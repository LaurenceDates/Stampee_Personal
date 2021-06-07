import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stampee_personal/component/stamp_book.dart';
import 'package:stampee_personal/component/reward.dart';
import 'package:stampee_personal/component/stamp_template.dart';
import 'package:stampee_personal/component/stamp.dart';
import 'package:stampee_personal/component/wrapper.dart';
import 'package:stampee_personal/screen/appbar.dart';
import 'package:stampee_personal/screen/widget/input_widgets.dart';

class BookConfigScreen extends StatefulWidget {
  const BookConfigScreen({Key? key, required this.bookData}) : super(key: key);
  final StampBook bookData;

  @override
  _BookConfigScreenState createState() => _BookConfigScreenState(bookData);
}

class _BookConfigScreenState extends State<BookConfigScreen> {
  _BookConfigScreenState(this.bookData);

  final StampBook bookData;

  Wrapper<String> bookTitle = Wrapper<String>('');
  Wrapper<String> bookComment = Wrapper<String>('');
  Wrapper<String> rewardTitle = Wrapper<String>('');
  Wrapper<int> stampCount = Wrapper<int>(1);
  Wrapper<String> rewardComment = Wrapper<String>('');
  Wrapper<StampType> stampType = Wrapper<StampType>(StampType.icon);
  Wrapper<IconData> icon = Wrapper<IconData>(StampTemplate.defaultTemplate.getIcon!);
  Wrapper<String> text = Wrapper<String>('');
  Wrapper<StampFrame> frame = Wrapper<StampFrame>(StampFrame.none);

  @override
  Widget build(BuildContext context) {
    bookTitle.value = bookData.getTitle();
    bookComment.value = bookData.getComment();
    if (bookData.getReward != null) {
      rewardTitle.value = bookData.getReward!.getTitle();
      rewardComment.value = bookData.getReward!.getTitle();
    }
    stampType.value = bookData.getStampTemplate.getStampType;
    if (bookData.getStampTemplate.getIcon != null) {
      icon.value = bookData.getStampTemplate.getIcon!;
    }
    if (bookData.getStampTemplate.getText != null) {
      text.value = bookData.getStampTemplate.getText!;
    }
    frame.value = bookData.getStampTemplate.getStampFrame;

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Text('Stamp Book Config', textScaleFactor: 1.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text('Original Title:'),
                SizedBox(width: 10),
                Container(
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Theme.of(context).dividerTheme.color!, width: 2.5))),
                    child: Text(bookData.getTitle(), textScaleFactor: 1.8)),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                controller: ScrollController(),
                children: [
                  StampBookConfigCard(title: bookTitle, comment: bookComment),
                  RewardConfigCard(title: rewardTitle, stampCount: stampCount, comment: rewardComment),
                  StampTemplateConfigCard(stampType: stampType, icon: icon, text: text, frame: frame),
                  configBookCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget configBookCard() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: OutlinedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Config This Stamp Book!', textScaleFactor: 1.5),
            SizedBox(width: 10),
            Icon(Icons.build, size: 30),
          ],
        ),
        onPressed: configBookFunction,
      ),
    );
  }

  void configBookFunction() {
    if (bookTitle.value.length > 0) {
      Reward? reward;
      if (this.rewardTitle.value.length > 0) {
        reward = Reward.newReward(
            title: this.rewardTitle.value, comment: this.rewardComment.value, stamps: this.stampCount.value);
      }
      bool result = bookData.modify(
          title: bookTitle.value,
          comment: bookComment.value,
          stampTemplate:
              StampTemplate.newTemplate(type: stampType.value, icon: icon.value, text: text.value, frame: frame.value),
          reward: reward);
      switch (result) {
        case true:
          showDialog(
            context: context,
            builder: (context) {
              StampTemplate newTemplate = StampTemplate.newTemplate(
                  type: stampType.value, icon: icon.value, text: text.value, frame: frame.value);
              Stamp sampleStamp = Stamp.newStamp(DateTime.now());
              return AlertDialog(
                title: Text('Successful'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Text('Your Book is Successfully Modified!')),
                    SizedBox(height: 20),
                    Text('Book Title: '),
                    Center(child: Text(bookTitle.value)),
                    Divider(),
                    Text('Book Comment: '),
                    Text(bookComment.value),
                    Divider(),
                    Text('Reward: '),
                    showRewardSetting(),
                    Divider(),
                    Text('Stamp Template: '),
                    Center(child: sampleStamp.show(template: newTemplate)),
                    SizedBox(height: 20),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/StampBookScreen', (route) => false);
                      },
                      child: Text('Done')),
                ],
              );
            },
          );
          break;
        case false:
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Nothing Changed'),
                  content:
                      Text('Your input data seems to be as exactly same as the former data. So, no data is changed.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Go Back')),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context, '/StampBookScreen', (route) => false);
                        },
                        child: Text('Done')),
                  ],
                );
              });
          break;
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Caution!'),
              content: Text('You cannot delete the Book Title.'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Go Back'))
              ],
            );
          });
    }
  }

  Widget showRewardSetting() {
    if (rewardTitle.value.length == 0) {
      return Center(child: Text('No reward is set'));
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Title: '),
          Center(child: Text(rewardTitle.value)),
          SizedBox(height: 10),
          Text('Comment'),
          Text(rewardComment.value),
          SizedBox(height: 10),
          Text('Needed stamps: '),
          Text(stampCount.value.toString()),
        ],
      );
    }
  }
}
