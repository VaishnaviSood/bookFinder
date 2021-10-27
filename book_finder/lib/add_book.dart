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
                      // focusedBorder: UnderlineInputBorder(
                      //     borderSide: BorderSide(
                      //         color: primaryColor, width: 2)),
                      // enabledBorder: UnderlineInputBorder(
                      //     borderSide: BorderSide(
                      //         color: primaryColor, width: 2)),
                      // hintText: 'Pick Your Date',
                      // hintStyle: TextStyle(
                      //     fontSize: deviceSize.height * 0.02),
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
            ],
          )),
        ),
      ),
    );
  }
}
