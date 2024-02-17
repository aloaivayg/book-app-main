import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class Book with ChangeNotifier {
  int id;
  String? imgUrl;
  String? name;
  String? author;
  num? score;
  num? review;
  num? view;
  int? price;
  List<String>? type;
  String? desc;
  Book(
    this.id,
    this.imgUrl,
    this.name,
    this.author,
    this.score,
    this.review,
    this.view,
    this.price,
    this.type,
    this.desc,
  );
  int? get _id => id;
  String? get _imgUrl => imgUrl;
  String? get _name => name;
  String? get _author => author;
  num? get _score => score;
  num? get _review => review;
  num? get _view => view;
  int? get _price => price;

  static List<Book> generateRecommendedBook() {
    return [
      Book(
          1,
          'assets/images/book1.jpg',
          'Harry Potter and the Deathly Hallows',
          'J.K. Rowling',
          4.9,
          107.3,
          2.8,
          10,
          ['Action', 'Fantasy', 'Supernatural'],
          'Harry Potter and the Deathly Hallows is the seventh and final book in the Harry Potter series by J. K. Rowling. Go read it'),
      Book(
          2,
          'assets/images/book2.jpg',
          'Harry Potter and the Order of the Phoenix',
          'J.K. Rowling',
          5,
          108.3,
          2.7,
          30,
          ['Action', 'Fantasy', 'Supernatural'],
          'Harry Potter and the Deathly Hallows is the seventh and final book in the Harry Potter series by J. K. Rowling.'),
      Book(
          3,
          'assets/images/book3.jpg',
          'Harry Potter and the Prisoner of Azkaban',
          'J.K. Rowling',
          5.1,
          109.3,
          2.7,
          20,
          ['Action', 'Fantasy', 'Supernatural'],
          'Harry Potter and the Prisoner of Azkaban is the seventh and final book in the Harry Potter series by J. K. Rowling. It was released on 21 July, 2007 at 00:01 am local time in English-speaking countries.'),
      Book(
          4,
          'assets/images/book4.jpg',
          'Harry Potter Sihirli Yaratıklar',
          'J.K. Rowling',
          5.3,
          110.3,
          2.9,
          40,
          ['Action', 'Fantasy', 'Supernatural'],
          'Harry Potter and the Deathly Hallows is the seventh and final book in the Harry Potter series by J. K. Rowling. It was released on 21 July, 2007 at 00:01 am local time in English-speaking countries.'),
      Book(
          5,
          'assets/images/book5.jpg',
          'Harry Potter ve Felsefe Taşı',
          'J.K. Rowling',
          7,
          200.3,
          3,
          50,
          ['Action', 'Fantasy', 'Supernatural'],
          'Harry Potter and the Deathly Hallows is the seventh and final book in the Harry Potter series by J. K. Rowling. It was released on 21 July, 2007 at 00:01 am local time in English-speaking countries.'),
    ];
  }

  static List<Book> generateTrendingBook() {
    return [
      Book(
          1,
          'assets/images/book6.jpg',
          'Harry Potter ve Ateş Kadehi',
          'J.K. Rowling',
          4.8,
          106,
          3.1,
          50,
          ['Action', 'Fantasy', 'Supernatural'],
          'Harry Potter and the Deathly Hallows is the seventh and final book in the Harry Potter series by J. K. Rowling. It was released on 21 July, 2007 at 00:01 am local time in English-speaking countries.'),
      Book(
          2,
          'assets/images/book7.jpg',
          'Harry Potter ve Azkaban Tutsağı',
          'J.K. Rowling',
          6,
          108.4,
          3.2,
          55,
          ['Action', 'Fantasy', 'Supernatural'],
          'Harry Potter and the Deathly Hallows is the seventh and final book in the Harry Potter series by J. K. Rowling. It was released on 21 July, 2007 at 00:01 am local time in English-speaking countries.'),
      Book(
          3,
          'assets/images/book8.jpg',
          'Harry Potter ve Melez Prens',
          'J.K. Rowling',
          10,
          120,
          2.5,
          60,
          ['Action', 'Fantasy', 'Supernatural'],
          'Harry Potter and the Deathly Hallows is the seventh and final book in the Harry Potter series by J. K. Rowling. It was released on 21 July, 2007 at 00:01 am local time in English-speaking countries.'),
      Book(
          4,
          'assets/images/book9.jpg',
          'Harry Potter ve Sırlar Odası',
          'J.K. Rowling',
          4.9,
          107.3,
          2.6,
          65,
          ['Action', 'Fantasy', 'Supernatural'],
          'Harry Potter and the Deathly Hallows is the seventh and final book in the Harry Potter series by J. K. Rowling. It was released on 21 July, 2007 at 00:01 am local time in English-speaking countries.'),
      Book(
          5,
          'assets/images/book10.jpg',
          'Harry Potter ve Zümrüdü Anka Yoldaşlığı',
          'J.K. Rowling',
          5,
          300.3,
          4,
          70,
          ['Action', 'Fantasy', 'Supernatural'],
          'Harry Potter and the Deathly Hallows is the seventh and final book in the Harry Potter series by J. K. Rowling. It was released on 21 July, 2007 at 00:01 am local time in English-speaking countries.'),
    ];
  }

  void onSearchBook(String keyword) {}
}
