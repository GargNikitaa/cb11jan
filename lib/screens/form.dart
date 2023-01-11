import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/models/user_model.dart';


class FormScreen extends StatefulWidget {
  final String? name;
  final String? date;

  const FormScreen({Key? key, this.name, this.date}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _auth = FirebaseAuth.instance;
  bool isChecked = false;
  var ph = "";
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.orangeAccent;
    }
    return Colors.redAccent;
  }
  @override
  Widget build(BuildContext context) {

    var phoneNumberField = Padding(
        padding: EdgeInsets.fromLTRB(15.0,0,15.0,0),
        child: TextFormField(
        autofocus: false,
        keyboardType: TextInputType.number,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Phone Number cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid number");
          }
          return null;
        },
        onChanged: (value) {
          ph = value;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          prefixIcon: Icon(Icons.account_circle, color: Colors.white60,),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone Number",
          hintStyle: TextStyle(fontSize: 20.0, color: Colors.white70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )));
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/bg4.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          // Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/loginbg.jpg'),fit: BoxFit.cover)),),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //hello
                const Text(
                  'Donation Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                const Text(
                  'and create an impact',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height:60,),

                // Text(
                //   widget.name,
                //   style: TextStyle(
                //     fontSize: 25.0,
                //     fontFamily: "lato",
                //     color: Colors.white,
                //   ),
                // ),

                // const SizedBox(height:100,),
                phoneNumberField,

                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,0,8,0),
                  child: Row(
                    children: [
                      Checkbox(value: isChecked,
                        checkColor:Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        onChanged: (bool? newValue) {
                          setState(() {
                            isChecked = newValue!;
                          });
                        },
                      ),
                      Text('I am willing to donate and create an impact',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 42.0),
                  child: Container(
                    padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Colors.orangeAccent,
                            Colors.redAccent,
                          ],
                        ),
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: MaterialButton(
                        onPressed: isChecked ? postDetailsToFirestore() : null,
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  postDetailsToFirestore() async {

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.uid = user?.uid;
    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .update({'phoneNumber': ph});

    CollectionReference ref =
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('pdrives');

    var data ={
      'pname': widget.name,
      'date': widget.date,
    };

    ref.add(data);
    Fluttertoast.showToast(msg: "Submitted successfully :) ");
    Navigator.pop(context);
  }
}