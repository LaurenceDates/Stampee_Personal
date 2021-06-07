import 'package:flutter/cupertino.dart';
import 'package:stampee_personal/component/reward.dart';
import 'package:stampee_personal/component/stamp_book.dart';
import 'package:stampee_personal/component/user.dart';
import 'package:stampee_personal/component/stamp_template.dart';
import 'package:stampee_personal/component/stamp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StartUpFunction {
  static Future<bool> onSplash(String userID) async {
    DocumentReference firestoreDataReference = FirebaseFirestore.instance.collection('stampbook').doc(userID);
    print(firestoreDataReference.toString());
    DocumentSnapshot documentSnapshot = await firestoreDataReference.get();

    if (documentSnapshot.data() == null) {
      return true;
    }

    List<dynamic> bookList = documentSnapshot.get('stampbooks');

    for (int i = 0; i < bookList.length; i++) {
      String bookTitle = bookList[i]['title'];
      String bookComment = bookList[i]['comment'] ?? '';

      String templateType = bookList[i]['template']['type'];
      String? iconName = bookList[i]['template']['icon'];
      String? templateText = bookList[i]['template']['text'];
      String frame = bookList[i]['template']['frame'];
      IconData? icon;
      if (iconName != null) {
        icon = StampTemplate.iconDataFromString(iconName);
      }
      StampTemplate template = StampTemplate.initializeTemplate(
          type: templateType, frame: StampTemplate.frameFromString(frame), icon: icon, text: templateText);

      String? rewardTitle = bookList[i]['reward']['title'];
      String? rewardComment = bookList[i]['reward']['comment'];
      int? stamps = bookList[i]['reward']['stamps'];
      int? count = bookList[i]['reward']['count'];
      Reward? reward;
      if (rewardTitle != null) {
        reward = Reward.initializeReward(
            title: rewardTitle, comment: rewardComment ?? '', stamps: stamps ?? 1, rewardCount: count ?? 0);
      }

      List<Stamp> stampList = [];
      for (int j = 0; j < bookList[i]['stamps'].length; j++) {
        DateTime date = Stamp.stampDateFromInt(bookList[i]['stamps'][j]['date']);
        bool isArchive = bookList[i]['stamps'][j]['archive'];
        stampList.add(Stamp.newStamp(date, archive: isArchive));
      }

      StampBook newBook = StampBook.initializeBook(
          title: bookTitle, comment: bookComment, stampTemplate: template, stamps: stampList, reward: reward);

      AppUser.instance.addBook(newBook);
    }
    print('initialized');
    return true;
  }
}
