import 'stamp_book.dart';

class AppUser {
  // This Class is Intended to used as a singleton class.
  // To get instance from an external class, write the following code:
  //     AppUser.instance
  static AppUser _instance = AppUser();
  static AppUser get instance => _instance;

  // _name field to store user name.
  // This field is not used to identify user, so change of this field does not affect app performance.
  // _name filed max length is limited up to 30 characters.
  // If the setter argument exceeds its limit, FormatException will be thrown.
  String _name = '';
  String get getName => _name;
  set setName(String name) {
    if (name.length > 30) {
      throw ArgumentError("UserName length exceeds its limit (30 letters)");
    } else {
      this._name = name;
    }
  }

  // _bookList field to store StampBook list of user.
  // Setter is private and you cannot set field value directly from external classes.
  // To modify the list, call addBook( ) or removeBook( ) method instead.
  // If you remove a book from the list, book will be permanently deleted. Use this function carefully.
  // You also can use archive( ) function for each StampBook instead. This method will deactivate the book,
  // while the book will remain stored on the database.
  List<StampBook> _books = [];
  List<StampBook> get getBooks => _books;
  set _setBooks(List<StampBook> books) {
    this._books = books;
  }

  void addBook(StampBook newBook) {
    _books.add(newBook);
  }
}
