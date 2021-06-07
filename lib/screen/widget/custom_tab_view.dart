import 'package:flutter/material.dart';

class CustomTabView extends StatefulWidget {
  const CustomTabView(
      {Key? key,
      this.initialIndex = 0,
      required this.tabs,
      required this.contents,
      required this.activeTabColor,
      required this.onActiveTab,
      required this.inactiveTabColor,
      required this.onInactiveTab,
      required this.contentBackgroundColor})
      : super(key: key);
  final initialIndex;
  final List<CustomTabItem> tabs;
  final List<Widget> contents;
  final Color activeTabColor;
  final Color onActiveTab;
  final Color inactiveTabColor;
  final Color onInactiveTab;
  final Color contentBackgroundColor;

  @override
  _CustomTabViewState createState() => _CustomTabViewState(
      index: initialIndex,
      tabs: tabs,
      contents: contents,
      activeTabColor: activeTabColor,
      onActiveTab: onActiveTab,
      inactiveTabColor: inactiveTabColor,
      onInactiveTab: onInactiveTab,
      contentBackgroundColor: contentBackgroundColor);
}

class _CustomTabViewState extends State<CustomTabView> {
  _CustomTabViewState(
      {required this.index,
      required this.tabs,
      required this.contents,
      required this.activeTabColor,
      required this.onActiveTab,
      required this.inactiveTabColor,
      required this.onInactiveTab,
      required this.contentBackgroundColor});

  int index;
  final List<CustomTabItem> tabs;
  final List<Widget> contents;
  final Color activeTabColor;
  final Color onActiveTab;
  final Color inactiveTabColor;
  final Color onInactiveTab;
  final Color contentBackgroundColor;
  static const double borderRadius = 5;
  static const double borderWidth = 3;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabRowChildren = [];
    for (int i = 0; i < tabs.length; i++) {
      switch (i == index) {
        case true:
          tabRowChildren.add(
            Container(
              decoration: BoxDecoration(
                  color: activeTabColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius), topRight: Radius.circular(borderRadius))),
              child: Text(tabs[i].text, style: TextStyle(color: onActiveTab)),
            ),
          );
          break;
        case false:
          tabRowChildren.add(
            GestureDetector(
              onTap: () {
                setState(() {
                  index = i;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: inactiveTabColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(borderRadius), topRight: Radius.circular(borderRadius))),
                child: Text(tabs[i].text, style: TextStyle(color: onInactiveTab)),
              ),
            ),
          );
          break;
      }
    }
    return Column(
      children: [
        Row(children: tabRowChildren),
        Container(
          child: contents[index],
          decoration: BoxDecoration(
              color: contentBackgroundColor,
              border: Border.all(color: activeTabColor, width: borderWidth),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(borderRadius), bottomRight: Radius.circular(borderRadius))),
        ),
      ],
    );
  }
}

class CustomTabItem {
  CustomTabItem({required this.text});
  final String text;
}
