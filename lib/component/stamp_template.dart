import 'package:flutter/material.dart';

class StampTemplate {
  static StampTemplate _defaultTemplate = newTemplate(
    type: StampType.icon,
    icon: Icons.sentiment_satisfied_alt,
    text: '',
    frame: StampFrame.none,
  );
  static StampTemplate get defaultTemplate => _defaultTemplate;

  // This field defines stamp type of the stamp.
  StampType _stampType = StampType.icon;
  StampType get getStampType => _stampType;
  void _setStampType(StampType type) {
    this._stampType = type;
  }

  IconData? _icon;
  IconData? get getIcon => this._icon;
  void _setIcon(IconData icon) {
    if (iconList.containsValue(icon)) {
      this._icon = icon;
    } else {
      throw ArgumentError('Specified Stamp Icon is not found');
    }
  }

  String? _text;
  String? get getText => this._text;
  void _setText(String text) {
    if (text.length > 10) {
      throw ArgumentError("Stamp Text length exceeds its limit (10 letters)");
    } else {
      this._text = text;
    }
  }

  StampFrame _stampFrame = StampFrame.none;
  StampFrame get getStampFrame => this._stampFrame;
  void _setStampFrame(StampFrame frame) {
    this._stampFrame = frame;
  }

  void modify({StampType? stampType, IconData? icon, String? text, StampFrame? stampFrame}) {
    if (stampType != null && stampType != this.getStampType) {
      this._setStampType(stampType);
      if (stampType == StampType.icon && this.getIcon == null) {
        this._setIcon(Icons.sentiment_satisfied_alt);
      }
      if (stampType == StampType.text && this.getText == null) {
        this._setText('');
      }
    }
    if (icon != null && icon != this.getIcon) {
      this._setIcon(icon);
    }
    if (text != null && text.length != 0 && text != this.getText) {
      this._setText(text);
    }
    if (stampFrame != null && stampFrame != this.getStampFrame) {
      this._setStampFrame(stampFrame);
    }
  }

  static StampTemplate _iconStampTemplate({IconData? icon, StampFrame? frame}) {
    StampTemplate newTemplate;
    if (icon == null) {
      throw ArgumentError('StampType is Icon, but icon is not set');
    } else {
      newTemplate = StampTemplate();
      newTemplate._setStampType(StampType.icon);
      newTemplate._setIcon(icon);
      if (frame != null) {
        newTemplate._setStampFrame(frame);
      }
      return newTemplate;
    }
  }

  static StampTemplate _textStampTemplate({String? text, StampFrame? frame}) {
    StampTemplate newTemplate;
    if (text == null) {
      throw ArgumentError('StampType is Text, but icon is not set');
    } else {
      newTemplate = StampTemplate();
      newTemplate._setStampType(StampType.text);
      newTemplate._setText(text);
      if (frame == null) {
        newTemplate._setStampFrame(frame!);
      }
      return newTemplate;
    }
  }

  static StampTemplate newTemplate({required StampType type, IconData? icon, String? text, StampFrame? frame}) {
    StampTemplate newTemplate;
    switch (type) {
      case StampType.icon:
        newTemplate = _iconStampTemplate(icon: icon, frame: frame);
        break;
      case StampType.text:
        newTemplate = _textStampTemplate(text: text, frame: frame);
        break;
    }
    return newTemplate;
  }

  static StampTemplate initializeTemplate(
      {required String type, IconData? icon, String? text, required StampFrame frame}) {
    StampTemplate initializedTemplate;
    switch (type) {
      case "icon":
        initializedTemplate = _iconStampTemplate(icon: icon, frame: frame);
        break;
      case 'text':
        initializedTemplate = _textStampTemplate(text: text, frame: frame);
        break;
      default:
        throw ArgumentError('StampType value is illegal');
    }
    return initializedTemplate;
  }

  static StampType typeFromString(String type) {
    switch (type) {
      case 'icon':
        return StampType.icon;
      case 'text':
        return StampType.text;
      default:
        throw ArgumentError('StampType value is illegal');
    }
  }

  static String typeToString(StampType type) {
    switch (type) {
      case StampType.icon:
        return 'icon';
      case StampType.text:
        return 'text';
    }
  }

  static StampFrame frameFromString(String frame) {
    switch (frame) {
      case 'none':
        return StampFrame.none;
      case 'circle':
        return StampFrame.circle;
      case 'square':
        return StampFrame.square;
      default:
        throw ArgumentError('StampFrame value is illegal');
    }
  }

  static String frameToString(StampFrame frame) {
    switch (frame) {
      case StampFrame.none:
        return 'none';
      case StampFrame.circle:
        return 'circle';
      case StampFrame.square:
        return 'square';
    }
  }

  static iconDataFromString(String icon) {
    if (iconList.containsKey(icon)) {
      return iconList[icon];
    } else {
      throw ArgumentError('Icon value is illegal');
    }
  }

  static String iconDataToString(IconData data) {
    return iconList.keys
        .firstWhere((key) => iconList[key] == data, orElse: throw ArgumentError('Icon value is illegal'));
  }

  static Map<String, IconData> iconList = {
    'sentiment_satisfied': Icons.sentiment_satisfied_alt,
    'sentiment_very_satisfied': Icons.sentiment_very_satisfied,
    'face': Icons.face,
    'edit': Icons.edit,
    'translate': Icons.translate,
    'description': Icons.description,
    'article': Icons.article,
    'assignment': Icons.assignment,
    'menu_book': Icons.menu_book,
    'analytics': Icons.analytics,
    'question_answer': Icons.question_answer,
    'search': Icons.search,
    'language': Icons.language,
    'home': Icons.home,
    'balance': Icons.account_balance,
    'tour': Icons.tour,
    'person': Icons.accessibility,
    'perm_identity': Icons.perm_identity,
    'alarm': Icons.access_alarm,
    'schedule': Icons.schedule,
    'history': Icons.history,
    'event': Icons.event,
    'shopping_bag': Icons.shopping_bag,
    'shopping_cart': Icons.shopping_cart,
    'receipt': Icons.receipt,
    'store': Icons.store,
    'cleaning_services': Icons.cleaning_services,
    'wash': Icons.wash,
    'explore': Icons.explore,
    'bookmark': Icons.bookmark,
    'pets': Icons.pets,
    'code': Icons.code,
    'work': Icons.work,
    'mail': Icons.mail,
    'commute': Icons.commute,
    'train': Icons.train,
    'drive_eta': Icons.drive_eta,
    'flight': Icons.flight,
    'dashboard': Icons.dashboard,
    'settings': Icons.settings,
    'build': Icons.build,
    'power': Icons.power,
    'power_setting_new': Icons.power_settings_new,
    'extension': Icons.extension,
    'done': Icons.done,
    'done_all': Icons.done_all,
    'verified': Icons.verified,
    'thumb_up': Icons.thumb_up,
    'lightbulb': Icons.lightbulb,
    'star': Icons.star,
    'support': Icons.support,
    'add': Icons.add,
    'favorite': Icons.favorite,
    'visibility': Icons.visibility,
    'android': Icons.android,
    'android_outlined': Icons.android_outlined,
  };

  static String stampTypeToString(StampType type){
    switch (type){
      case StampType.icon: return 'icon';
      case StampType.text: return 'text';
    }
  }

  static StampType stampTypeFromString(String type){
    switch(type){
      case 'icon': return StampType.icon;
      case 'text': return StampType.text;
      default: throw ArgumentError('StampType name is illegal!');
    }
  }

  static String stampFrameToString(StampFrame frame){
    switch (frame){
      case StampFrame.none: return 'none';
      case StampFrame.circle: return 'circle';
      case StampFrame.square: return 'square';
    }
  }

  static StampFrame stampFrameFromString(String frame){
    switch(frame){
      case 'none': return StampFrame.none;
      case 'circle': return StampFrame.circle;
      case 'square': return StampFrame.square;
      default: throw ArgumentError('StampFrame name is illegal');
    }
  }

}

enum StampType { icon, text }

enum StampFrame { none, circle, square }
