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
  }

  void fetchData() async {
    print('inside fetch data');

    await firestore.collection('books').get().then((value) {
      value.docs.forEach((element) {
        books.add(Book(
            author: element['author'],
            name: element['name'],
            date: element['date']));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Finder"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 400,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Devdas'),
                subtitle: Column(
                  children: [
                    Text('By Sharat Chandra ChattoPadhyay'),
                    Text('28 April 1945'),
                  ],
                ),
                isThreeLine: true,
              );
            },
          ),
        ),
      ),
    );
  }
}
