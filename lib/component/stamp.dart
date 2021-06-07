import 'package:flutter/material.dart';
import 'package:stampee_personal/component/stamp_template.dart';

class Stamp {
  DateTime? _date;
  DateTime getDate() {
    if (_date == null) {
      throw NullThrownError();
    } else {
      return _date!;
    }
  }

  void _setDate(DateTime? date) {
    if (date == null) {
      DateTime now = DateTime.now();
      this._date = DateTime(now.year, now.month, now.day);
    } else {
      this._date = DateTime(date.year, date.month, date.day);
    }
  }

  bool _archive = false;
  bool get getArchive => _archive;
  void setArchive({bool? archive}) {
    if (archive == null) {
      this._archive = !this._archive;
    } else {
      this._archive = archive;
    }
  }

  static Stamp newStamp(DateTime date, {bool archive = false}) {
    Stamp newStamp = Stamp();
    newStamp._setDate(date);
    if (archive == true) {
      newStamp.setArchive(archive: true);
    }
    return newStamp;
  }

  static Stamp initializeStamp({required DateTime date, required bool archive}) {
    Stamp initializedStamp = Stamp();
    initializedStamp._setDate(date);
    initializedStamp.setArchive(archive: archive);
    return initializedStamp;
  }

  Widget show({required StampTemplate template, double size = 60}) {
    Color? iconColor;
    Color? labelColor;
    Widget? icon;
    Text? label;
    BoxDecoration decoration;
    switch (this.getArchive) {
      case false:
        iconColor = Colors.redAccent;
        labelColor = Colors.black;
        break;
      case true:
        iconColor = Colors.redAccent.shade100;
        labelColor = Colors.black26;
    }
    switch (template.getStampFrame) {
      case StampFrame.none:
        decoration = BoxDecoration();
        break;
      case StampFrame.circle:
        decoration = BoxDecoration(
            border: Border.all(color: iconColor!, width: size / 20), borderRadius: BorderRadius.circular(size / 2));
        break;
      case StampFrame.square:
        decoration = BoxDecoration(
            border: Border.all(color: iconColor!, width: size / 20), borderRadius: BorderRadius.circular(size / 12));
    }
    switch (template.getStampType) {
      case StampType.icon:
        icon = Icon(template.getIcon, color: iconColor, size: (size - 6) * 0.8);
        break;
      case StampType.text:
        String text = '';
        if (template.getText != null && template.getText!.length != 0) {
          text = template.getText!;
        }
        double iconFontSize = (size - 6) / (text.length);
        icon = Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: iconColor, fontSize: iconFontSize),
        );
        break;
    }
    double labelFontSize = size / 4;
    label = Text(
      this.getDate().month.toString().padLeft(2, '0') + '.' + this.getDate().day.toString().padLeft(2, '0'),
      textAlign: TextAlign.center,
      style: TextStyle(color: labelColor, fontSize: labelFontSize),
    );
    return Stack(alignment: Alignment.bottomCenter, children: [
      Container(
        margin: EdgeInsets.all(3),
        width: size - 6,
        height: size - 6,
        alignment: Alignment.center,
        decoration: decoration,
        child: icon,
      ),
      label,
    ]);
  }

  static int stampDateToInt(DateTime date) {
    int value = 0;
    value += date.year * 10000;
    value += date.month * 100;
    value += date.day;
    return value;
  }

  static DateTime stampDateFromInt(int dateInt) {
    int year = (dateInt / 10000).floor();
    int month = ((dateInt - year * 10000) / 100).floor();
    int day = dateInt - year * 10000 - month * 100;
    DateTime date = DateTime(year, month, day);
    return date;
  }
}
