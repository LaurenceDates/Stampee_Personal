import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stampee_personal/component/user.dart';
import 'package:stampee_personal/screen/appbar.dart';
import 'package:stampee_personal/screen/stamp_book/page/no_book_page.dart';
import 'package:stampee_personal/screen/stamp_book/page/book_page.dart';

class StampBookScreen extends StatefulWidget {
  const StampBookScreen({Key? key}) : super(key: key);

  @override
  _StampBookScreenState createState() => _StampBookScreenState();
}

class _StampBookScreenState extends State<StampBookScreen> {
  List<Widget> page = [];
  int pageIndex = 0;
  List<BottomNavigationBarItem> bottomNavigationBarItems = [];

  @override
  Widget build(BuildContext context) {
    AppUser data = Provider.of<AppUser>(context);
    int books = data.getBooks.length;
    switch (books) {
      case 0:
        this.page = [NoBookPage()];
        this.bottomNavigationBarItems = [BottomNavigationBarItem(icon: Text('No Book'), label: '')];
        break;
      default:
        this.page = [];
        this.bottomNavigationBarItems = [];
        for (int i = 0; i < books; i++) {
          this.page.add(BookPage(
                key: Key(i.toString()),
                bookData: data.getBooks[i],
              ));
          this.bottomNavigationBarItems.add(BottomNavigationBarItem(
                icon: Text(data.getBooks[i].getTitle(maxLength: 10)),
                label: '',
              ));
        }
        break;
    }
    return Scaffold(
      appBar: CustomAppBar(),
      body: this.page[this.pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: this.bottomNavigationBarItems,
        currentIndex: this.pageIndex,
        onTap: (int newIndex) {
          setState(() {
            this.pageIndex = newIndex;
          });
        },
      ),
    );
  }
}
