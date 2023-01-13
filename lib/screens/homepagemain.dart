import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'navbar.dart';

class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState()=> _HomeState();
}

class _HomeState extends State<Home> {
  // Home({Key? key}) : super(key: key);
  int activeIndex = 0;
  final _firestoreInstance = FirebaseFirestore.instance;
  final List<String> _carouselImages = [];
  var _dotPosition = 0;
  final List _names = [];
  final List<String> images = [
    'https://sadsindia.org/wp-content/uploads/2020/05/maxvision-sws-450x450.jpg',
    'https://www.beingvolunteer.org/resources/BeingVolunteer/Campaigns/old%20news%20paper/Old%20newspaper%20collection.jpg',
    'https://www.beingvolunteer.org/resources/BeingVolunteer/Campaigns/old%20news%20paper/Old%20newspaper%20collection.jpg',
    'https://www.beingvolunteer.org/resources/BeingVolunteer/Campaigns/old%20news%20paper/Old%20newspaper%20collection.jpg',
    'https://www.beingvolunteer.org/resources/BeingVolunteer/Campaigns/old%20news%20paper/Old%20newspaper%20collection.jpg',
    'https://www.beingvolunteer.org/resources/BeingVolunteer/Campaigns/old%20news%20paper/Old%20newspaper%20collection.jpg',
    'https://www.beingvolunteer.org/resources/BeingVolunteer/Campaigns/old%20news%20paper/Old%20newspaper%20collection.jpg',
    'https://www.beingvolunteer.org/resources/BeingVolunteer/Campaigns/old%20news%20paper/Old%20newspaper%20collection.jpg',
  ];
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
    return Container(

    );
    //   Scaffold(
    //   backgroundColor: const Color(0xFF000000),
    //   body: Padding(
    //     padding: const EdgeInsets.all(16),
    //     child: Column(
    //       children: [
    //         Container(
    //           width: 30,
    //           decoration: const BoxDecoration(
    //             borderRadius: BorderRadius.all(Radius.circular(20)),
    //             image: DecorationImage(
    //               image:NetworkImage("assets/quote.jpeg"),
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //         // TextField(
    //         //   decoration: InputDecoration(
    //         //     filled: true,
    //         //     fillColor: const Color(0x8AFFFFFF),
    //         //     border: OutlineInputBorder(
    //         //       borderRadius: BorderRadius.circular(2.0),
    //         //       borderSide: BorderSide.none,
    //         //     ),
    //         //     hintText: "Search for drives near you",
    //         //     suffixIcon: const Icon(Icons.search),
    //         //     suffixIconColor: const Color(0xFFE64A19),
    //         //   ),
    //         // ),
    //         const SizedBox(
    //           height: 10.0,
    //         ),
    //         const Align(
    //           alignment: Alignment.centerLeft,
    //           child: Text(
    //             'Recent',
    //             textAlign: TextAlign.left,
    //             style: TextStyle(
    //               fontSize: 20.0,
    //               color: Color(0xFFE64A19),
    //             ),
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 10.0,
    //         ),
    //         AspectRatio(
    //           aspectRatio: 3.5,
    //           child: CarouselSlider(
    //               items: _carouselImages
    //                   .map((item) => Padding(
    //                 padding: const EdgeInsets.only(left: 3, right: 3),
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                       image: DecorationImage(
    //                           image: NetworkImage(item),
    //                           fit: BoxFit.fitWidth)),
    //                 ),
    //               ))
    //                   .toList(),
    //               options: CarouselOptions(
    //                   autoPlay: false,
    //                   enlargeCenterPage: true,
    //                   viewportFraction: 0.8,
    //                   enlargeStrategy: CenterPageEnlargeStrategy.height,
    //                   onPageChanged: (val, carouselPageChangedReason) {
    //                     setState(() {
    //                       _dotPosition = val;
    //                     });
    //                   })),
    //         ),
    //         const SizedBox(
    //           height: 7.0,
    //         ),
    //         DotsIndicator(
    //           dotsCount:
    //           _carouselImages.isEmpty ? 1 : _carouselImages.length,
    //           position: _dotPosition.toDouble(),
    //           decorator: DotsDecorator(
    //             activeColor: Colors.orange,
    //             color: Colors.orange.withOpacity(0.5),
    //             spacing: const EdgeInsets.all(2),
    //             activeSize: const Size(8, 8),
    //             size: const Size(6, 6),
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 15,
    //         ),
    //         // const Align(
    //         //   alignment: Alignment.centerLeft,
    //         //   child: Text(
    //         //     'Categories',
    //         //     textAlign: TextAlign.left,
    //         //     style: TextStyle(
    //         //       fontSize: 20.0,
    //         //       fontWeight: FontWeight.bold,
    //         //       color: Colors.white,
    //         //     ),
    //         //   ),
    //         // ),
    //         // Flexible(
    //         //   child: GridView(
    //         //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //         //         crossAxisCount: 2),
    //         //     children: <Widget>[
    //         //       Container(
    //         //         decoration: BoxDecoration(
    //         //           color: Colors.white,
    //         //           borderRadius: BorderRadius.circular(40.0),
    //         //         ),
    //         //         margin: const EdgeInsets.all(40),
    //         //         child: ClipRRect(
    //         //           borderRadius: BorderRadius.circular(40.0),
    //         //           child:
    //         //           Image.asset("assets/heart.jpg", fit: BoxFit.cover),
    //         //         ),
    //         //       ),
    //         //       Container(
    //         //         decoration: BoxDecoration(
    //         //           color: Colors.white,
    //         //           borderRadius: BorderRadius.circular(40.0),
    //         //         ),
    //         //         margin: const EdgeInsets.all(40),
    //         //         child: ClipRRect(
    //         //           borderRadius: BorderRadius.circular(40.0),
    //         //           child: Image.asset("assets/heart.jpg",
    //         //               fit: BoxFit.cover),
    //         //         ),
    //         //       ),
    //         //       ConstrainedBox(
    //         //         constraints:
    //         //         const BoxConstraints.tightFor(height: 500, width: 1000),
    //         //         child: ElevatedButton(
    //         //           onPressed: () {},
    //         //           style: ElevatedButton.styleFrom(
    //         //             primary: Colors.grey,
    //         //             textStyle: const TextStyle(
    //         //               fontSize: 20,
    //         //             ),
    //         //           ),
    //         //           child: const Text(
    //         //             'See All Categories',
    //         //           ),
    //         //         ),
    //         //       ),
    //         //     ],
    //         //   ),
    //         // ),
    //         StaggeredGrid.count(
    //           crossAxisCount: 4,
    //           mainAxisSpacing: 4,
    //           crossAxisSpacing: 4,
    //           children:  [
    //             StaggeredGridTile.count(
    //                 crossAxisCellCount: 2,
    //                 mainAxisCellCount: 2,
    //                 child: Image.network('https://sadsindia.org/wp-content/uploads/2020/05/maxvision-sws-450x450.jpg')),
    //             StaggeredGridTile.count(
    //               crossAxisCellCount: 2,
    //               mainAxisCellCount: 1,
    //               child: Image.network('https://sadsindia.org/wp-content/uploads/2020/05/maxvision-sws-450x450.jpg'),
    //             ),
    //             StaggeredGridTile.count(
    //               crossAxisCellCount: 1,
    //               mainAxisCellCount: 1,
    //               child: Image.network('https://sadsindia.org/wp-content/uploads/2020/05/maxvision-sws-450x450.jpg'),
    //             ),
    //             StaggeredGridTile.count(
    //               crossAxisCellCount: 1,
    //               mainAxisCellCount: 1,
    //               child: Image.network('https://sadsindia.org/wp-content/uploads/2020/05/maxvision-sws-450x450.jpg'),
    //             ),
    //             StaggeredGridTile.count(
    //               crossAxisCellCount: 4,
    //               mainAxisCellCount: 2,
    //               child: Image.network('https://sadsindia.org/wp-content/uploads/2020/05/maxvision-sws-450x450.jpg'),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    //   bottomNavigationBar: navPage(),
    // );
  }
}