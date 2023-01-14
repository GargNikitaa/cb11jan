import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app_igdtuw/models/user_model.dart';

import 'navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: Constants.apiKey,
          appId: Constants.appId,
          messagingSenderId: Constants.messagingSenderId,
          projectId: Constants.projectId,
        ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(Profile());
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UploadingImageToFirebaseStorage(),
    );
  }
}

class UploadingImageToFirebaseStorage extends StatefulWidget {
  @override
  _UploadingImageToFirebaseStorageState createState() =>
      _UploadingImageToFirebaseStorageState();
}

class _UploadingImageToFirebaseStorageState
    extends State<UploadingImageToFirebaseStorage> {
  late io.File imageFile;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print('PrintFile: ${pickedFile.toString()}');
      setState(() {
        imageFile = io.File(pickedFile.path);
      });
    } else {
      print('PickedFile: is null');
    }
    if (imageFile != null) {
      return imageFile;
    }
  }

  Future uploadImageToFirebase(BuildContext context) async {
    late String img_url;
    String fileName = basename(imageFile.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    uploadTask.whenComplete(() async {
      try {
        img_url = await firebaseStorageRef.getDownloadURL();
      } catch (onError) {
        print("Error");
      }
      return img_url;
    });
  }

  final _auth = FirebaseAuth.instance;
  UserModel userModel = UserModel();
  Future<DocumentSnapshot> getDocument() async {
    var user = await FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance.collection("users").doc(user?.uid).get();
  }

  String? fname;
  String? sname;
  String? phone;
  String? email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
            future: getDocument(),
            builder: (context, snapshot) {
              final data;
              if (snapshot.hasData) {
                data = snapshot.data;
                return ListView(
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  navMainPage()),
                        );
                      },
                      child: Icon(
                        Icons.arrow_back_rounded,
                        size: 24.0,
                      ),
                      style: ButtonStyle(
                        alignment: Alignment.topLeft,
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
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CircleAvatar(
                          radius: 85,
                          child: Image.network(data["image_url"])
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          getImage();
                        },
                        child: Text("Change Photo"),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          textStyle:  TextStyle(
                            color: Colors.orange,
                            fontSize: 20,
                            //fontWeight: FontWeight.w900,
                            fontFamily: 'Spartan',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 30.0, 0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "First Name",
                              style: TextStyle(
                                fontFamily: "Spartan",
                                fontSize: 20,
                                color: Colors.deepOrangeAccent,
                                //fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                              autofocus: false,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                fname = value;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.2),
                                contentPadding:
                                EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: data["firstName"],
                                hintStyle: TextStyle(
                                    fontSize: 20.0, color: Colors.white70),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Second Name",
                              style: TextStyle(
                                fontFamily: "Spartan",
                                fontSize: 20,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                              autofocus: false,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                sname = value;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.2),
                                contentPadding:
                                EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: data["secondName"],
                                hintStyle: TextStyle(
                                    fontSize: 20.0, color: Colors.white70),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email",
                              style: TextStyle(
                                fontFamily: "Spartan",
                                fontSize: 20,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                              autofocus: false,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                email = value;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.2),
                                contentPadding:
                                EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: data['email'],
                                hintStyle: TextStyle(
                                    fontSize: 20.0, color: Colors.white70),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Phone Number",
                              style: TextStyle(
                                fontFamily: "Spartan",
                                fontSize: 20,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                              autofocus: false,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                phone = value;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.2),
                                contentPadding:
                                EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: data["phoneNumber"],
                                hintStyle: TextStyle(
                                    fontSize: 20.0, color: Colors.white70),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        height: 50,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Colors.orange.shade700,
                              Colors.orange.shade900
                            ],
                          ),
                        ),
                        child: OutlinedButton(
                          //           borderSide: BorderSide(
                          //               color: Colors.transparent,
                          // ),
                          onPressed: () {
                            postDetailsToFirestore();
                          },
                          child: Text('Save Changes'),
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              //fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontFamily: 'Spartan',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();
    userModel.uid = user?.uid;
    if(phone!=null) {
      await firebaseFirestore
          .collection("users")
          .doc(user?.uid)
          .update({'phoneNumber': phone});
    }
    if(fname!=null) {
      await firebaseFirestore
          .collection("users")
          .doc(user?.uid)
          .update({'firstName': fname});
    }
    if(sname!=null) {
      await firebaseFirestore
          .collection("users")
          .doc(user?.uid)
          .update({'secondName': sname});
    }
    if(email!=null) {
      await firebaseFirestore
          .collection("users")
          .doc(user?.uid)
          .update({'email': email});
    }
    late String img_url;
    String fileName = basename(imageFile.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    uploadTask.whenComplete(() async {
      try {
        img_url = await firebaseStorageRef.getDownloadURL();
      } catch (onError) {
        print("Error");
      }
      return img_url;
    });
    if(img_url!=null) {
      await firebaseFirestore
          .collection("users")
          .doc(user?.uid)
          .update({'image_url': img_url});
    }
  }
}

// Widget Field(String title, String hint){
//   return
// }