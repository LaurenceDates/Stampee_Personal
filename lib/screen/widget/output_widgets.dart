import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:stampee_personal/screen/stamp_book/page/book_page.dart';
import 'package:stampee_personal/component/stamp.dart';
import 'package:stampee_personal/component/stamp_book.dart';

class StampBookCard extends StatelessWidget {
  const StampBookCard({Key? key, required this.bookData}) : super(key: key);
  final StampBook bookData;

  @override
  Widget build(BuildContext context) {
    if (bookData.getComment().length > 0) {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(bookData.getComment()),
        ),
      );
    }
    return Container();
  }
}

class RewardCard extends StatelessWidget {
  const RewardCard({Key? key, required this.bookData}) : super(key: key);
  final StampBook bookData;

  @override
  Widget build(BuildContext context) {
    if (bookData.getReward != null) {
      return Container();
    } else {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(bookData.getReward!.getNeededStamps.toString(), textScaleFactor: 1.5),
                    Text("Stamps", textAlign: TextAlign.end),
                  ]),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          bookData.getReward!.getTitle(),
                          textScaleFactor: 1.3,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
                        ),
                        Text(bookData.getReward!.getComment()),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (dialogContext) => SimpleDialog(
                                title: Text('Edit Reward'),
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      print(context.findAncestorStateOfType<BookPageState>());
                                      context.findAncestorStateOfType<BookPageState>()!.setState(() {
                                        bookData.getReward!.getReward(bookData: bookData);
                                      });
                                      Navigator.pop(dialogContext);
                                    },
                                    child: Text('GetReward'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.findAncestorStateOfType<BookPageState>()!.setState(() {
                                        bookData.getReward!.getReward(count: -1, bookData: bookData);
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text('CancelReward'),
                                  ),
                                ],
                              ));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Rewarded', textAlign: TextAlign.start),
                        Text(bookData.getReward!.getRewardCount.toString(),
                            textScaleFactor: 1.3, textAlign: TextAlign.center),
                        Text('time(s)', textAlign: TextAlign.end),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                      onPressed: () {
                        context.findAncestorStateOfType<BookPageState>()!.setState(() {
                          bookData.getReward!.getReward(bookData: bookData);
                        });
                      },
                      child: Column(
                        children: [
                          Text('Get \n Reward!', textAlign: TextAlign.center),
                          Icon(Icons.thumb_up),
                        ],
                      ))
                ],
              )
            ],
          ),
        ),
      );
    }
  }
}

class StampCard extends StatefulWidget {
  const StampCard({Key? key, required this.bookData}) : super(key: key);
  final StampBook bookData;

  @override
  _StampCardState createState() => _StampCardState(bookData);
}

class _StampCardState extends State<StampCard> {
  _StampCardState(this.bookData);
  final StampBook bookData;
  StampDisplayMode mode = StampDisplayMode.active;

  @override
  Widget build(BuildContext context) {
    Widget? content;
    if (bookData.countAllStamps() == 0) {
      content = Text('No Stamp');
    } else {
      switch (mode) {
        case StampDisplayMode.active:
          if (bookData.countActiveStamps() == 0) {
            content = Text('No Active Stamp');
          } else {
            List<Widget> stampList = [];
            for (int i = 0; i < bookData.getStamps.length; i++) {
              if (bookData.getStamps[i].getArchive != true) {
                stampList.add(stampListItem(i));
              }
            }
            content = GridView.extent(maxCrossAxisExtent: 65, shrinkWrap: true, children: stampList);
          }
          break;
        case StampDisplayMode.all:
          List<Widget> stampList = [];
          for (int i = 0; i < bookData.getStamps.length; i++) {
            stampList.add(stampListItem(i));
          }
          content = GridView.extent(maxCrossAxisExtent: 65, shrinkWrap: true, children: stampList);
          break;
      }
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text('Stamps', textScaleFactor: 1.3),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      mode = StampDisplayMode.active;
                    });
                  },
                  child: Row(
                    children: [
                      Text('Active Stamps: '),
                      Text(bookData.countActiveStamps().toString()),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      mode = StampDisplayMode.all;
                    });
                  },
                  child: Row(
                    children: [
                      Text('All Stamps: '),
                      Text(bookData.countAllStamps().toString()),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            content,
          ],
        ),
      ),
    );
  }

  Widget stampListItem(int index) {
    return GestureDetector(
      child: bookData.getStamps[index].show(template: bookData.getStampTemplate),
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) => SimpleDialog(
                  title: Text('Edit Stamp'),
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          bookData.getStamps[index].setArchive();
                        });
                        Navigator.pop(context);
                      },
                      child: Text('Archive/Unarchive this stamp'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          bookData.getStamps.removeAt(index);
                        });
                        Navigator.pop(context);
                      },
                      child: Text('Delete this stamp'),
                    ),
                    TextButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              minTime: DateTime(bookData.getStamps[index].getDate().year - 2, 1, 1),
                              maxTime: DateTime(bookData.getStamps[index].getDate().year, 12, 31),
                              onConfirm: (DateTime date) {
                            setState(() {
                              bool archive = bookData.getStamps[index].getArchive;
                              bookData.getStamps.removeAt(index);
                              bookData.addStamp(Stamp.newStamp(date, archive: archive));
                            });
                            Navigator.pop(context);
                          });
                        },
                        child: Text('Change date of this stamp'))
                  ],
                ));
      },
    );
  }
}

enum StampDisplayMode {
  all,
  active,
}
