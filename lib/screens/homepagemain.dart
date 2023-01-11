import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// void main() => runApp(MaterialApp(
//   debugShowCheckedModeBanner: false,
//   home: Home(),
// ));
class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState()=> _HomeState();
}

class _HomeState extends State<Home> {
  // Home({Key? key}) : super(key: key);
  int activeIndex = 0;
  final urlImages = [
    'assets/mars.png',
    'assets/mars.png',
    'assets/mars.png',
  ];
  final _firestoreInstance = FirebaseFirestore.instance;
  final List<String> _carouselImages = [];
  var _dotPosition = 0;
  final List _names = [];
  // List<T> map<T>(List list, Function handler) {
  //   List<T> result = [];
  //   for (var i = 0; i < list.length; i++) {
  //     result.add(handler(i, list[i]));
  //   }
  //   return result;
  // }
  fetchCarousel() async {
    QuerySnapshot qn =
    await _firestoreInstance.collection("drives").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["image_url"],
        );
      }
      for (int i = 0; i < qn.docs.length; i++) {
        _names.add(
          qn.docs[i]["name"],
        );
      }
    });

    return qn.docs;
  }

  //final _controller = PageController();
  @override
  void initState() {
    fetchCarousel();
    super.initState();
  }
  Widget buildImage(String urlImages, int index) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    color: Colors.grey,
    child: Image.network(
      urlImages,
      fit: BoxFit.cover,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0x8AFFFFFF),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Search for drives near you",
                suffixIcon: const Icon(Icons.search),
                suffixIconColor: const Color(0xFFE64A19),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFFE64A19),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            // Container(
            //   child: Center(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         CarouselSlider.builder(
            //           options: CarouselOptions(
            //             height: 180,
            //             autoPlay: true,
            //             //enlargeCenterPage: true,
            //           ),
            //           itemCount: urlImages.length,
            //           itemBuilder: (context, index, realIndex) {
            //             final urlImage = urlImages[index];
            //
            //             return buildImage(urlImage, index);
            //           },
            //         ),
            //         SizedBox(
            //           height: 7,
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: map<Widget>(urlImages, (index, url) {
            //             return Container(
            //               width: 10.0,
            //               height: 10.0,
            //               margin: EdgeInsets.symmetric(
            //                   vertical: 10.0, horizontal: 2.0),
            //               decoration: BoxDecoration(
            //                 shape: BoxShape.circle,
            //                 color: _current == index
            //                     ? Colors.deepOrange[700]
            //                     : Colors.white,
            //               ),
            //             );
            //           }),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            AspectRatio(
              aspectRatio: 3.5,
              child: CarouselSlider(
                  items: _carouselImages
                      .map((item) => Padding(
                    padding: const EdgeInsets.only(left: 3, right: 3),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(item),
                              fit: BoxFit.fitWidth)),
                    ),
                  ))
                      .toList(),
                  options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChangedReason) {
                        setState(() {
                          _dotPosition = val;
                        });
                      })),
            ),
            const SizedBox(
              height: 7.0,
            ),
            DotsIndicator(
              dotsCount:
              _carouselImages.isEmpty ? 1 : _carouselImages.length,
              position: _dotPosition.toDouble(),
              decorator: DotsDecorator(
                activeColor: Colors.orange,
                color: Colors.orange.withOpacity(0.5),
                spacing: const EdgeInsets.all(2),
                activeSize: const Size(8, 8),
                size: const Size(6, 6),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Categories',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Flexible(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    margin: const EdgeInsets.all(40),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child:
                      Image.asset("assets/heart.jpg", fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    margin: const EdgeInsets.all(40),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Image.asset("assets/heart.jpg",
                          fit: BoxFit.cover),
                    ),
                  ),
                  ConstrainedBox(
                    constraints:
                    const BoxConstraints.tightFor(height: 500, width: 1000),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        textStyle: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      child: const Text(
                        'See All Categories',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const GNav(
        backgroundColor: Colors.white,
        gap: 8,
        activeColor: Color(0xFFE64A19),
        padding: EdgeInsets.all(16),
        tabs: [
          GButton(icon: Icons.home, text: 'Home'),
          GButton(icon: Icons.bookmark, text: 'Bookmarks'),
          GButton(icon: Icons.note, text: 'Drives'),
          GButton(icon: Icons.account_circle, text: 'Profile'),
        ],
      ),
    );
  }
}