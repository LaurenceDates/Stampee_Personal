import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:stampee_personal/component/stamp_book.dart';
import 'package:stampee_personal/component/stamp.dart';
import 'package:stampee_personal/screen/widget/output_widgets.dart';

class BookPage extends StatefulWidget {
  BookPage({Key? key, required this.bookData}) : super(key: key);
  final StampBook bookData;

  @override
  BookPageState createState() => BookPageState(bookData);
}

class BookPageState extends State<BookPage> {
  StampBook bookData;

  BookPageState(this.bookData);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Stack(children: [
            Center(child: Text(bookData.getTitle(), textScaleFactor: 1.8)),
            Align(
              alignment: Alignment.topRight,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/BookConfigScreen', arguments: bookData);
                },
                icon: Icon(Icons.settings),
                label: Text('Config'),
              ),
            ),
          ]),
          SizedBox(height: 10),
          addStampButtons(),
          Divider(),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              controller: ScrollController(),
              children: [
                StampBookCard(bookData: bookData),
                RewardCard(bookData: bookData),
                StampCard(bookData: bookData),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget addStampButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      ElevatedButton(
          onPressed: () {
            setState(() {
              bookData.addStamp(Stamp.newStamp(DateTime.now()));
            });
          },
          child: Row(children: [Icon(Icons.science), Text('Quick Stamp!')])),
      SizedBox(width: 10),
      ElevatedButton(
          onPressed: () {
            DatePicker.showDatePicker(context,
                minTime: DateTime(DateTime.now().year - 2, 1, 1),
                maxTime: DateTime(DateTime.now().year + 1, 12, 31), onConfirm: (DateTime date) {
              setState(() {
                bookData.addStamp(Stamp.newStamp(date));
              });
            });
          },
          child: Row(
            children: [Icon(Icons.science_outlined), Text('Custom Stamp')],
          ))
    ]);
  }
}
