import 'package:stampee_personal/component/stamp_book.dart';

class Reward {
  String _title = '';

  String getTitle({int? maxLength}) {
    if (maxLength == null || maxLength <= _title.length) {
      return _title;
    } else if (maxLength <= 0) {
      throw ArgumentError("getTitle maxLength cannot be shorter than 1");
    } else {
      return _title.substring(0, maxLength - 1);
    }
  }

  void setTitle(String title) {
    if (title.length > 30) {
      throw ArgumentError("Reward Title length exceeds its limit (30 letters)");
    } else {
      this._title = title;
    }
  }

  String _comment = '';

  String getComment({int? maxLength}) {
    if (maxLength == null || maxLength <= _comment.length) {
      return _comment;
    } else if (maxLength <= 0) {
      throw ArgumentError("getComment maxLength cannot be shorter than 1");
    } else {
      return _comment.substring(0, maxLength - 1);
    }
  }

  void setComment(String comment) {
    if (comment.length > 200) {
      throw ArgumentError("Reward Comment length exceeds its limit (200 letters)");
    } else {
      this._comment = comment;
    }
  }

  int _neededStamps = 1;

  int get getNeededStamps => _neededStamps;

  void setNeededStamps(int stamps) {
    if (stamps < 1) {
      throw ArgumentError('Needed Stamps count for Reward must be at least 1');
    } else {
      _neededStamps = stamps;
    }
  }

  int _rewardCount = 0;
  int get getRewardCount => _rewardCount;
  void _setRewardCount(int count) {
    this._rewardCount = count;
  }

  void setRewardCount(int increment) {
    this._rewardCount += increment;
  }

  void getReward({required StampBook bookData, int count = 1}) {
    if (count > 0) {
      int needed = getNeededStamps * count;
      if (bookData.countActiveStamps() >= needed) {
        for (int i = 0; i < bookData.getStamps.length; i++) {
          if (bookData.getStamps[i].getArchive == false) {
            bookData.getStamps[i].setArchive(archive: true);
            needed--;
            if (needed == 0) {
              setRewardCount(count);
              break;
            }
          }
        }
      }
    } else if (count < 0) {
      if (getRewardCount >= count) {
        int needed = getNeededStamps * count;
        for (int i = bookData.getStamps.length - 1; i >= 0; i--) {
          if (bookData.getStamps[i].getArchive == true) {
            bookData.getStamps[i].setArchive(archive: false);
            needed++;
            if (needed == 0) {
              setRewardCount(count);
              break;
            }
          }
        }
      }
    }
  }

  static Reward newReward({required String title, String comment = '', int stamps = 1}) {
    Reward reward = Reward();
    reward.setTitle(title);
    reward.setComment(comment);
    reward.setNeededStamps(stamps);
    return reward;
  }

  static Reward initializeReward(
      {required String title, String comment = '', required int stamps, required int rewardCount}) {
    Reward reward = Reward();
    reward.setTitle(title);
    reward.setComment(comment);
    reward._setRewardCount(rewardCount);
    return reward;
  }
}
