//import 'package:firebase_auth/firebase_auth';
import 'dart:async';

import 'package:bv_doubtnut/screens/books.dart';
import 'package:bv_doubtnut/screens/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

import 'customTabBar.dart';


class HomeScreen extends StatefulWidget {
  
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  late final PageController pageController;
  ScrollController _scrollController = ScrollController();
  int pageNo = 0;

  Timer? carasouelTmer;

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 10), (timer) {
      if (pageNo == 2) {
        pageNo = 0;
      }
      var animateToPage = pageController.animateToPage(
        pageNo,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCirc,
      );
      pageNo++;
    });
  }
  /*Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Logout"),
          onPressed: () {
            
            FirebaseAuth.instance.signOut().then((value) {
              print("Signed Out");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignIn_Screen()));
            });
          },
        ),
      ),
    );
  }*/
  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    carasouelTmer = getTimer();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showBtmAppBr = false;
        setState(() {});
      } else {
        showBtmAppBr = true;
        setState(() {});
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
  bool showBtmAppBr = true;

Widget build(BuildContext context) {
	return Scaffold(
    extendBodyBehindAppBar:true,
    appBar: AppBar(
        title: const Text(
          "Search",
        ),
        actions: [
          IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                context: context,
                // delegate to customize the search bar
                delegate: CustomSearchDelegate()
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),

    body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const SizedBox(
                height: 0.0,
                width: double.maxFinite,
                
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ListTile(
                  onTap: () {},
                  selected: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                  ),
                  selectedTileColor: Colors.indigoAccent.shade100,
                  title: Text(
                    "Welcome",
                    style: Theme.of(context).textTheme.subtitle1!.merge(
                          const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0,
                          ),
                        ),
                  ),
                  subtitle: Text(
                    "BV DOUBTNUT IS HERE TO HELP YOU",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  
              
              trailing: PopUpMen(
                    menuList: const [
                      PopupMenuItem(
                        child: Text("About Us"),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(
                            Icons.logout,
                          ),
                          title: Text("Log Out"),
                        ),
                      ),
                    ],
                    icon: CircleAvatar(
                      backgroundImage: const NetworkImage(
                        'https://leverageedublog.s3.ap-south-1.amazonaws.com/blog/wp-content/uploads/2019/09/23165047/Importance-of-Books.jpg',
                      ),
                      child: Container(),
                    ),
                     ),
                ),
              ),
              SizedBox(
                height: 120,
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) {
                    pageNo = index;
                    setState(() {});
                  },
                  itemBuilder: (_, index) {
                    return AnimatedBuilder(
                      animation: pageController,
                      builder: (ctx, child) {
                        return child!;
                      },
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("Hello you tapped at ${index + 1} "),
                            ),
                          );
                        },
                        onPanDown: (d) {
                          carasouelTmer?.cancel();
                          carasouelTmer = null;
                        },
                        onPanCancel: () {
                          carasouelTmer = getTimer();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              right: 8, left: 8, top: 24, bottom: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: Colors.amberAccent,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 1,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.circle,
                        size: 12.0,
                        color: pageNo == index
                            ? Colors.indigoAccent
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              )*/
              
            ],
          ),
        ),
      ),
      
     
      bottomNavigationBar: AnimatedContainer(
        color:Color(0xFF76FF03) ,
        child: BottomAppBar(
          notchMargin: 8.0,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.home_outlined,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.bookmark,
                ),
              ),
              
              IconButton(
                onPressed: () {
                   Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const  MyBooks()),
                );
                 
                },
                icon: const Icon(
                  CupertinoIcons.book_fill,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.arrow_down_to_line,
                ),
              ),
               IconButton(
                
                icon: const Icon(
                  CupertinoIcons.heart,
                ),
                onPressed: () {
              // method to show the search bar
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CustomTabBar()),
                );
            },
              ),
            ],
          ),
        ),
        duration: const Duration(
          milliseconds: 800,
        ),
        curve: Curves.easeInOutSine,
        height: showBtmAppBr ? 70 : 0,
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  List<String> searchTerms = [
    "Btech CSE Ist Year Books",
    "Btech IT Ist  Year Books",
    "Btech CSE Ist Year Resources",
    "Btech IT Ist Year Resources",
  ];
     
  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }
 
  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }
 
  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var books in searchTerms) {
      if (books.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(books);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
 
  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var books in searchTerms) {
      if (books.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(books);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
);
}
}

class PopUpMen extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  const PopUpMen({Key? key, required this.menuList, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      itemBuilder: ((context) => menuList),
      icon: icon,
    );
  }
}



