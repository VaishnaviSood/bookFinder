import 'package:book_finder/home_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Add Book'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: deviceSize.height,
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: deviceSize.height * 0.2),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter name of the book";
                        }
                      },
                      controller: _nameController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(color: Colors.white24)),
                          labelText: 'Title of the Book',
                          labelStyle: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the author's name";
                        }
                      },
                      controller: _authorController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(color: Colors.white24)),
                          labelText: 'Author of the Book',
                          labelStyle: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please pick a date';
                          }
                        },
                        controller: _dateController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(color: Colors.white24)),
                          labelText: 'Pick the publishing date',
                          labelStyle: TextStyle(fontWeight: FontWeight.w500),
                          // hintText: 'Pick Your Date',
                          // hintStyle: TextStyle(fontSize: 17),
                        ),
                        onTap: () async {
                          var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Colors
                                          .deepPurple, // header background color
                                      onPrimary:
                                          Colors.white, // header text color
                                      onSurface:
                                          Colors.black, // body text color
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary: Colors
                                            .deepPurple, // button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              });

                          _dateController.text =
                              date.toString().substring(0, 10);
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    width: deviceSize.width * 0.3,
                    decoration: BoxDecoration(
                        color: flag ? Colors.deepPurple : Colors.grey[400],
                        borderRadius: BorderRadius.circular(15)),
                    child: MaterialButton(
                      child: Text(flag ? 'Add Book' : 'Book Added',
                          style: TextStyle(color: Colors.white)),
                      onPressed: flag
                          ? () {
                              _formKey.currentState!.save();
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              FirebaseFirestore.instance
                                  .collection('books')
                                  .add({
                                'author': _authorController.text,
                                'name': _nameController.text,
                                'date': _dateController.text,
                              }).then((value) {
                                setState(() {
                                  flag = false;
                                });
                              });
                            }
                          : () {},
                    ),
                  ),
                  flag == false
                      ? TextButton(
                          onPressed: () {
                            setState(() {
                              _authorController.clear();
                              _nameController.clear();
                              _dateController.clear();
                              flag = true;
                            });
                          },
                          child: Text('Add another Book'))
                      : Padding(padding: EdgeInsets.all(0)),
                  Container(
                    margin: EdgeInsets.all(8),
                    width: deviceSize.width * 0.3,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(15)),
                    child: MaterialButton(
                        child: Text('Go to home',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                        }),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
