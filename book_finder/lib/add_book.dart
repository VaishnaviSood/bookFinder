import 'package:book_finder/book_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Add Book'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
              child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide(color: Colors.white24)),
                    labelText: 'Title of the Book',
                    labelStyle: TextStyle(fontWeight: FontWeight.w500)),
              ),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide(color: Colors.white24)),
                    labelText: 'Author of the Book',
                    labelStyle: TextStyle(fontWeight: FontWeight.w500)),
              ),
              TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide(color: Colors.white24)),
                    labelText: 'Pick the publishing date',
                    labelStyle: TextStyle(fontWeight: FontWeight.w500),
                    // hintText: 'Pick Your Date',
                    // hintStyle: TextStyle(fontSize: 17),
                  ),
                  onTap: () async {
                    var date = await showDatePicker(
                        // builder: (BuildContext context,
                        //     Widget child) {
                        //   return Theme(
                        //     data: ThemeData.light().copyWith(
                        //       primaryColor: primaryColor,
                        //       accentColor: primaryColor,
                        //       colorScheme: ColorScheme.light(
                        //           primary: primaryColor),
                        //     ),
                        //     child: child,
                        //   );
                        // },

                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));
                    _dateController.text = date.toString().substring(0, 10);
                  }),
              Container(
                decoration: BoxDecoration(
                    color: flag ? Colors.deepPurple : Colors.grey[300],
                    borderRadius: BorderRadius.circular(15)),
                child: MaterialButton(
                  child: Text(flag ? 'Add Book' : 'Book Added',
                      style: TextStyle(color: Colors.white)),
                  onPressed: flag
                      ? () {
                          FirebaseFirestore.instance.collection('books').add({
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
            ],
          )),
        ),
      ),
    );
  }
}
