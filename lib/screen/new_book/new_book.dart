import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stampee_personal/component/user.dart';
import 'package:stampee_personal/component/stamp_book.dart';
import 'package:stampee_personal/component/reward.dart';
import 'package:stampee_personal/component/stamp_template.dart';
import 'package:stampee_personal/component/stamp.dart';
import 'package:stampee_personal/component/wrapper.dart';
import 'package:stampee_personal/screen/appbar.dart';
import 'package:stampee_personal/screen/widget/input_widgets.dart';

class NewBookScreen extends StatefulWidget {
  const NewBookScreen({Key? key}) : super(key: key);

  @override
  _NewBookScreenState createState() => _NewBookScreenState();
}

class _NewBookScreenState extends State<NewBookScreen> {
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
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Text('New Stamp Book', textScaleFactor: 1.8),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                controller: ScrollController(),
                children: [
                  StampBookConfigCard(title: bookTitle, comment: bookComment),
                  RewardConfigCard(title: rewardTitle, stampCount: stampCount, comment: rewardComment),
                  StampTemplateConfigCard(stampType: stampType, icon: icon, text: text, frame: frame),
                  newBookCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget newBookCard() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: OutlinedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Make New Stamp Book!', textScaleFactor: 1.5),
            SizedBox(width: 10),
            Icon(Icons.file_download_done, size: 30),
          ],
        ),
        onPressed: newBookFunction,
      ),
    );
  }

  void newBookFunction() {
    if (bookTitle.value.length > 0) {
      Reward? reward;
      if (this.rewardTitle.value.length > 0) {
        reward = Reward.newReward(
            title: this.rewardTitle.value, comment: this.rewardComment.value, stamps: this.stampCount.value);
      }
      Provider.of<AppUser>(context, listen: false).addBook(StampBook.newBook(
          title: bookTitle.value,
          comment: bookComment.value,
          reward: reward,
          stampTemplate: StampTemplate.newTemplate(
              type: this.stampType.value, icon: this.icon.value, text: this.text.value, frame: this.frame.value)));
      showDialog(
          context: context,
          builder: (context) {
            StampTemplate newTemplate = StampTemplate.newTemplate(
                type: this.stampType.value, icon: this.icon.value, text: this.text.value, frame: this.frame.value);
            Stamp sampleStamp = Stamp.newStamp(DateTime.now());
            return AlertDialog(
              title: Text('Successful'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text('New Stamp Book is Created!')),
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
                  Text(
                    'You can edit your Stamp Book from Stamp Book Page',
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
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
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Failed!'),
              content: Text('You cannot make new book without book title. Please type it and try again.'),
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
