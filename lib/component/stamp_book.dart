import 'package:flutter/material.dart';
import 'package:stampee_personal/component/reward.dart';
import 'package:stampee_personal/component/stamp.dart';
import 'package:stampee_personal/component/stamp_template.dart';

class StampBook {
  // Name of the StampBook.
  // Name is shown in the app fo user to recognize each book.
  // _title filed max length is limited up to 30 characters.
  // Setter is private. To set this field from external class, use modify( ) function instead.
  String _title = '';

  String getTitle({int? maxLength}) {
    if (maxLength == null || maxLength >= _title.length) {
      return _title;
    } else if (maxLength <= 0) {
      throw ArgumentError("getTitle maxLength cannot be shorter than 1");
    } else {
      return _title.substring(0, maxLength);
    }
  }

  _setTitle(String title) {
    if (title.length > 30) {
      throw ArgumentError("StampBook Title length exceeds its limit (30 letters)");
    } else {
      this._title = title;
    }
  }

  // _comment field is to store comment (Stamping rule or other comments) on the StampBook.
  // Comment is displayed on each StampBook's book page.
  // _comment filed max length is limited up to 200 characters.
  // Setter is private. To set this field from external class, use modify( ) function instead.
  String _comment = '';
  String getComment({int? maxLength}) {
    if (maxLength == null || maxLength >= _comment.length) {
      return _comment;
    } else if (maxLength <= 0) {
      throw ArgumentError("getComment maxLength cannot be shorter than 1");
    } else {
      return _comment.substring(0, maxLength - 1);
    }
  }

  _setComment(String comment) {
    if (comment.length > 200) {
      throw ArgumentError("StampBook Comment length exceeds its limit (200 letters)");
    } else {
      this._comment = comment;
    }
  }

  // _stampTemplate field defines StampTemplate of Stamps on this book.
  StampTemplate _stampTemplate = StampTemplate.defaultTemplate;
  StampTemplate get getStampTemplate => _stampTemplate;
  _setStampTemplate(StampTemplate stampTemplate) {
    this._stampTemplate = stampTemplate;
  }

  Reward? _reward;
  Reward? get getReward => _reward;
  _setReward(Reward? reward) {
    this._reward = reward;
  }

  List<Stamp> _stamps = [];
  List<Stamp> get getStamps => _stamps;
  _setStamps(List<Stamp> stamps) {
    this._stamps = stamps;
  }

  void addStamp(Stamp stamp) {
    if (getStamps.length == 0) {
      _stamps.add(stamp);
    } else if (stamp.getDate().millisecondsSinceEpoch >=
        getStamps[getStamps.length - 1].getDate().millisecondsSinceEpoch) {
      _stamps.add(stamp);
    } else {
      for (int i = getStamps.length - 1; i >= 0; i--) {
        if (stamp.getDate().millisecondsSinceEpoch >= getStamps[i].getDate().millisecondsSinceEpoch) {
          _stamps.insert(i, stamp);
          return;
        }
      }
      _stamps.insert(0, stamp);
    }
  }

  static StampBook newBook(
      {required String title, required String comment, StampTemplate? stampTemplate, Reward? reward}) {
    StampBook newBook = StampBook();
    newBook._setTitle(title);
    newBook._setComment(comment);
    if (stampTemplate != null) {
      newBook._setStampTemplate(stampTemplate);
    }
    if (reward != null) {
      newBook._setReward(reward);
    }
    return newBook;
  }

  static StampBook initializeBook(
      {required String title,
      required String? comment,
      required StampTemplate stampTemplate,
      required List<Stamp> stamps,
      required Reward? reward}) {
    StampBook initializedBook = StampBook();
    initializedBook._setTitle(title);
    if (comment != null) {
      initializedBook._setComment(comment);
    }

    initializedBook._setStampTemplate(stampTemplate);
    initializedBook._setStamps(stamps);
    if (reward != null) {
      initializedBook._setReward(reward);
    }
    return initializedBook;
  }

  bool modify({String? title, String? comment, StampTemplate? stampTemplate, Reward? reward}) {
    bool modified = false;
    if (title != null && title != '' && title != getTitle()) {
      _setTitle(title);
      modified = true;
    }
    if (comment != null && comment != getComment()) {
      _setComment(comment);
      modified = true;
    }
    if (stampTemplate != null && stampTemplate != getStampTemplate) {
      _setStampTemplate(stampTemplate);
      modified = true;
    }
    if (reward != null && reward != getReward) {
      _setReward(reward);
      modified = true;
    }
    return modified;
  }

  int countAllStamps() => this.getStamps.length;
  int countActiveStamps() {
    int count = 0;
    for (int i = 0; i < this.getStamps.length; i++) {
      if (this.getStamps[i].getArchive == false) {
        count++;
      }
    }
    return count;
  }

  List<Widget> showAllStamps() {
    List<Widget> list = [];
    for (int i = 0; i < this.getStamps.length; i++) {
      list.add(this.getStamps[i].show(template: this.getStampTemplate));
    }
    return list;
  }

  List<Widget> showActiveStamps() {
    List<Widget> list = [];
    for (int i = 0; i < this.getStamps.length; i++) {
      if (this.getStamps[i].getArchive == false) {
        list.add(this.getStamps[i].show(template: this.getStampTemplate));
      }
    }
    return list;
  }

  List<Widget> showArchiveStamps() {
    List<Widget> list = [];
    for (int i = 0; i < this.getStamps.length; i++) {
      if (this.getStamps[i].getArchive == true) {
        list.add(this.getStamps[i].show(template: this.getStampTemplate));
      }
    }
    return list;
  }

  Widget showFirstStampOfDate(DateTime date) {
    for (int i = 0; i < this.getStamps.length; i++) {
      DateTime stampDate = this.getStamps[i].getDate();
      if (stampDate.year == date.year && stampDate.month == date.month && stampDate.day == date.day) {
        return this.getStamps[i].show(template: this.getStampTemplate);
      }
    }
    return Container();
  }

  List<Widget> showStampsOfDate(DateTime date) {
    List<Widget> list = [];
    for (int i = 0; i < this.getStamps.length; i++) {
      DateTime stampDate = this.getStamps[i].getDate();
      if (stampDate.year == date.year && stampDate.month == date.month && stampDate.day == date.day) {
        list.add(this.getStamps[i].show(template: this.getStampTemplate));
      }
    }
    return list;
  }
}
