import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

<<<<<<< HEAD
import 'navbar.dart';

final Uri _url = Uri.parse('https://celestial-biscuit.vercel.app/About');

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

=======
>>>>>>> 04f727bb6c1ce50ac5a5744c0e30f042db305453
class viewprofile extends StatefulWidget {
  const viewprofile({Key? key}) : super(key: key);

  @override
  State<viewprofile> createState() => _viewprofileState();
}

class _viewprofileState extends State<viewprofile> {
  Future<DocumentSnapshot> getDocument() async {
    var user = await FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance.collection("users").doc(user?.uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: FutureBuilder(
          future: getDocument(),
          builder: (context, snapshot) {
            final data;
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                print("000000000000000000000000000${snapshot.data}");
                data = snapshot.data;
                print("11111111111111111111111${data["email"]}");

                return ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1.0),
                      //   child: Container(
                      height: 200,
                      color: Colors.black,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
<<<<<<< HEAD
                            padding: const EdgeInsets.fromLTRB(0,15,0,0),
                            child: CircleAvatar(
                              radius: 65,
=======
                            padding: const EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              radius: 85,
>>>>>>> 04f727bb6c1ce50ac5a5744c0e30f042db305453
                              child: ClipOval(
                                // child: Image.asset(
                                //   "assets/pfp.jpeg",
                                //   fit: BoxFit.cover,
                                //   width: 200,
                                //   height: 200,
                                // ),
<<<<<<< HEAD
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(data['image_url']),
                                  radius: 62,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 35,),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data['firstName'],
                                  style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Arial',
                                    color: Colors.white,
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(1.0),
                      //   child: Container(
                      height: 100,
                      color: Colors.grey[900],
                      child: const Center(
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Spartan',
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),

                    // Container(
                    //   padding: const EdgeInsets.all(1.0),
                    //   //   child: Container(
                    //   height: 100,
                    //   color: Colors.grey[900],
                    //   child: Center(
                    //     child: Text(
                    //       "Visit our Website",
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.w900,
                    //         fontFamily: 'Spartan',
                    //         fontSize: 20,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Divider(
                      color: Colors.orange.shade900,
                      indent: 80,
                      endIndent: 80,
                    ),
                    Container(
                      padding: const EdgeInsets.all(1.0),
                      //   child: Container(
                      height: 100,
                      color: Colors.grey[900],
                      child: const Center(
                        child: TextButton(
                          onPressed: _launchUrl,
                          child: Text(
                            "Celestial Biscuit IGDTUW",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Spartan',
                              fontSize: 20,
=======
                                child: CircleAvatar(),
                              ),
>>>>>>> 04f727bb6c1ce50ac5a5744c0e30f042db305453
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data['firstName'],
                                  style: TextStyle(
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Arial',
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  //padding: EdgeInsets.all(10.0),
                                  height: 80,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.orange.shade900
                                        .withOpacity(0.20),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '78',
                                        style: TextStyle(
                                          fontSize: 45,
                                          color: Colors.orange.shade900,
                                          fontFamily: 'Arial',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Container(
                                        child: Image.asset('assets/fire.png',
                                            height: 40, width: 40),
                                      ),
                                      Text(
                                        ' GoodWill\n  Score',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                          fontFamily: 'Spartan',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(1.0),
                      //   child: Container(
                      height: 100,
                      color: Colors.grey[900],
                      child: const Center(
                        child: Text(
                          "Edit Settings",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Spartan',
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.orange.shade900,
                      indent: 80,
                      endIndent: 80,
                    ),
                    Container(
                      padding: const EdgeInsets.all(1.0),
                      //   child: Container(
                      height: 100,
                      color: Colors.grey[900],
<<<<<<< HEAD
                      child: const Center(
                        child: Text(
                          "About Us",
=======
                      child: Center(
                        child: Text(
                          "Visit our Website",
>>>>>>> 04f727bb6c1ce50ac5a5744c0e30f042db305453
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Spartan',
<<<<<<< HEAD
                            fontSize: 20,
=======
                            fontSize: 25,
>>>>>>> 04f727bb6c1ce50ac5a5744c0e30f042db305453
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.orange.shade900,
                      indent: 80,
                      endIndent: 80,
                    ),
                    Container(
                      padding: const EdgeInsets.all(1.0),
                      //   child: Container(
                      height: 100,
                      color: Colors.grey[900],
                      child: const Center(
                        child: Text(
<<<<<<< HEAD
                          "Log out",
=======
                          "Celestial Biscuit IGDTUW",
>>>>>>> 04f727bb6c1ce50ac5a5744c0e30f042db305453
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Spartan',
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
<<<<<<< HEAD
                    Container(
                      padding: const EdgeInsets.all(1.0),
                      //   child: Container(
                      height: 80,
                      color: Colors.grey[900],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(15.0),
                            child: Image.asset('assets/linkedin.png' ,
                                height: 40, width: 40),
                          ),
                          Container(
                            padding: EdgeInsets.all(15.0),
                            child: Image.asset('assets/instagram.png',
                                height: 40, width: 40),
                          ),
                          Container(
                            padding: EdgeInsets.all(15.0),

                            child: Image.asset('assets/twitter.png',
                                height: 40, width: 40),

                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

=======
                    Divider(
                      color: Colors.orange.shade900,
                      indent: 80,
                      endIndent: 80,
                    ),
                    Container(
                      padding: const EdgeInsets.all(1.0),
                      //   child: Container(
                      height: 100,
                      color: Colors.grey[900],
                      child: const Center(
                        child: Text(
                          "Change Password",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Spartan',
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.orange.shade900,
                      indent: 80,
                      endIndent: 80,
                    ),
                    Container(
                      padding: const EdgeInsets.all(1.0),
                      //   child: Container(
                      height: 100,
                      color: Colors.grey[900],
                      child: const Center(
                        child: Text(
                          "Notification Settings",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Spartan',
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(1.0),
                      //   child: Container(
                      height: 80,
                      color: Colors.grey[900],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(15.0),
                            child: Image.asset('assets/linkedin.png',
                                height: 40, width: 40),
                          ),
                          Container(
                            padding: EdgeInsets.all(15.0),
                            child: Image.asset('assets/instagram.png',
                                height: 40, width: 40),
                          ),
                          Container(
                            padding: EdgeInsets.all(15.0),
                            child: Image.asset('assets/twitter.png',
                                height: 40, width: 40),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
>>>>>>> 04f727bb6c1ce50ac5a5744c0e30f042db305453
            } else if (snapshot.connectionState == ConnectionState.none) {
              return const Text("No data");
            }
            return const Center(child: CircularProgressIndicator());
          },
<<<<<<< HEAD
        )
        // bottomNavigationBar: navPage(),
    );
  }

}
=======
        ));
  }
}
>>>>>>> 04f727bb6c1ce50ac5a5744c0e30f042db305453
