import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'form.dart';

class ViewNote extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  ViewNote(this.data, this.time, this.ref);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  late String title;
  late String des;
  late String url;
  var size,height,width;
  // late String loc;

  bool edit = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery
        .of(context)
        .size;
    height = size.height;
    width = size.width;

    title = widget.data['name'];
    des = widget.data['desc'];
    url = widget.data['image_url'];
    // loc = widget.data['location'];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        //
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                height: height, //half of the height size
                width: width,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                // padding: EdgeInsets.all(
                //   12.0,
                // ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  height: height / 2, //half of the height size
                  width: width,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.all(Radius.circular(30)),
                    image: DecorationImage(
                      image: NetworkImage(widget.data['image_url']),
                      fit: BoxFit.cover,
                    ),
                  ),
                  padding: EdgeInsets.all(
                    12.0,
                  ),
                ),
              ),

              // //temp
              Positioned(
                top: 300,
                // left: 20,
                child: Container(
                  height: height / 2, //half of the height size
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.0),
                      topRight: Radius.circular(35.0),
                    ),
                  ),
                  padding: EdgeInsets.all(
                    12.0,
                  ),
                ),
              ),


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 24.0,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.transparent,
                          ),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(
                              horizontal: 25.0,
                              vertical: 8.0,
                            ),
                          ),
                        ),
                      ),
                      //
                    ],
                  ),
                  //
                  SizedBox(
                    height: 15.0,
                  ),
                  //
                  Form(
                    key: key,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration.collapsed(
                            hintText: "name",
                          ),
                          style: TextStyle(
                            fontSize: 39.0,
                            fontFamily: "lato",
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          initialValue: widget.data['name'],
                          enabled: edit,
                          onChanged: (_val) {
                            title = _val;
                          },
                          validator: (_val) {
                            if (_val!.isEmpty) {
                              return "Can't be empty !";
                            } else {
                              return null;
                            }
                          },
                        ),
                        //
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 12.0,
                            bottom: 12.0,
                          ),
                          child: Text(
                            widget.time,
                            style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: "lato",
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 190,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(59, 0, 0, 0),
                          child: TextFormField(
                            decoration: InputDecoration.collapsed(
                              hintText: "location",
                            ),
                            style: TextStyle(
                              fontSize: 29.0,
                              fontFamily: "lato",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            initialValue: widget.data['location'],
                            enabled: edit,
                            onChanged: (_val) {
                              des = _val;
                            },
                            maxLines: 1,
                            validator: (_val) {
                              if (_val!.isEmpty) {
                                return "Can't be empty !";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 18,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25.0, 0, 0, 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Description',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "lato",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25.0, 5, 10, 15),
                          child: TextFormField(
                            decoration: InputDecoration.collapsed(
                              hintText: "Note Description",
                            ),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "lato",
                              color: Colors.white70,
                            ),
                            initialValue: widget.data['desc'],
                            enabled: edit,
                            onChanged: (_val) {
                              des = _val;
                            },
                            maxLines: 5,
                            validator: (_val) {
                              if (_val!.isEmpty) {
                                return "Can't be empty !";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 20,),

                        SizedBox(
                          height: 35,
                          width: 170,
                          child: ElevatedButton(
                            child: Row(
                              children: [
                                Image(
                                    height: 25,
                                    image: AssetImage('assets/heart.jpg')),
                                Text(
                                  'Donate Now',
                                  style: TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              pushdetailstoform();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              primary: Colors.white,
                              textStyle:
                              TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
    pushdetailstoform() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormScreen(name: title, date: widget.time)),
    );
  }
}