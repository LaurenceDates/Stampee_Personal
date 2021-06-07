import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stampee_personal/component/stamp_book.dart';
import 'package:stampee_personal/component/stamp.dart';
import 'package:stampee_personal/component/stamp_template.dart';
import 'package:stampee_personal/component/user.dart';

class FirestoreUpdater {
  static CollectionReference firestoreCollectionReference = FirebaseFirestore.instance.collection('stampbook');

  static updateData(AppUser data, User user) {
    DocumentReference documentReference = firestoreCollectionReference.doc(user.uid);
    Map<String, dynamic> appdata = {'stampbooks': []};
    for (int i = 0; i < data.getBooks.length; i++) {
      appdata['stampbooks'][i].add({'title': data.getBooks[i].getTitle()});
      appdata['stampbooks'][i].add({'comment': data.getBooks[i].getComment()});

      Map<String, dynamic> templateData;
      switch (data.getBooks[i].getStampTemplate.getStampType) {
        case StampType.icon:
          templateData = {
            'type': StampTemplate.stampTypeToString(data.getBooks[i].getStampTemplate.getStampType),
            'icon': StampTemplate.iconDataToString(data.getBooks[i].getStampTemplate.getIcon!),
            'frame': StampTemplate.frameToString(data.getBooks[i].getStampTemplate.getStampFrame),
          };
          break;
        case StampType.text:
          templateData = {
            'type': StampTemplate.stampTypeToString(data.getBooks[i].getStampTemplate.getStampType),
            'text': data.getBooks[i].getStampTemplate.getText,
            'frame': StampTemplate.frameToString(data.getBooks[i].getStampTemplate.getStampFrame),
          };
          break;
      }
      appdata['stampbooks'][i].add({'template': templateData});

      if (AppUser.instance.getBooks[i].getReward != null) {
        Map<String, dynamic> reward = {
          'reward': {
            'title': AppUser.instance.getBooks[i].getReward!.getTitle(),
            'comment': AppUser.instance.getBooks[i].getReward!.getComment(),
            'stamps': AppUser.instance.getBooks[i].getReward!.getNeededStamps,
            'count': AppUser.instance.getBooks[i].getReward!.getRewardCount,
          }
        };
        appdata['stampbooks'][i].add(reward);
      }

      List<Map<String, dynamic>> stampList = [];
      for (int j = 0; j < AppUser.instance.getBooks[i].getStamps.length; i++) {
        stampList.add({
          'date': Stamp.stampDateToInt(AppUser.instance.getBooks[i].getStamps[j].getDate()),
          'archive': AppUser.instance.getBooks[i].getStamps[j].getArchive,
        });
      }
      appdata['stampbooks'][i].add({'stamps': stampList});
    }
  }
}
