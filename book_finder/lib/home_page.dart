import 'package:book_finder/add_book.dart';
import 'package:book_finder/book_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    print('im here');
    fetchData();
    // books = [
    //   Book(
    //       author: 'Vaishnavi Sood',
    //       name: 'Vaishnavi Sood',
    //       date: '26 July, 2021'),
    // ];
  }

  void fetchData() async {
    print('inside fetch data');

    await firestore.collection('books').get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          books.add(Book(
              author: element['author'],
              name: element['name'],
              date: element['date']));
        });
      });
    });
  }

  String bookname = '';
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Finder"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              onChanged: (val) {
                setState(() {
                  bookname = val.toLowerCase();
                  print(bookname);
                });
              },
              showCursor: true,
              //cursorColor: Color(0xFFFF722843),
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: 17,
                  ),
                  contentPadding: EdgeInsets.only(top: 8),
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)))),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(15)),
              child: MaterialButton(
                  child:
                      Text('Add Book', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddBook()));
                  }),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  String searchname = books[index].name;
                  String searchauthor = books[index].author;
                  return bookname.isEmpty
                      ? Rows(books: books, index: index)
                      : searchname.toLowerCase().startsWith(bookname) ||
                              searchauthor.toLowerCase().startsWith(bookname)
                          ? Rows(books: books, index: index)
                          : Padding(padding: EdgeInsets.all(0));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Rows extends StatelessWidget {
  Rows({required this.books, required this.index});
  final List<Book> books;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(books[index].name),
      subtitle: Column(
        children: [
          Text(books[index].author),
          Text(books[index].date),
        ],
      ),
      isThreeLine: true,
    );
  }
}
