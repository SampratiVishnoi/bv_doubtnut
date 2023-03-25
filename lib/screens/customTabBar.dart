import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    //TODO implement iniState

    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Others",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
              selectionColor: Color.fromARGB(255, 238, 235, 235),
            ),
            centerTitle: true,
            bottom: TabBar(
              controller: _controller,
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered))
                    return Colors.amberAccent; //<-- SEE HERE
                  return null;
                },
              ),
              indicatorColor: Colors.black,
              tabs: [
                Tab(
                  text: ("Leave Process"),
                  icon: Icon(
                    Icons.description,
                    color: Colors.white,
                  ),
                ),
                Tab(
                  text: "Clubs",
                  icon: Icon(
                    Icons.groups,
                    color: Colors.white,
                  ),
                ),
                Tab(
                  text: "Faculties",
                  icon: Icon(
                    Icons.person_outline,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _controller,
            children: [
              Center(
                  child: Text(
                "Step 1: Parcel you leave docment from your house that is being signed by your parents.\n\nStep 2: When your leave process is arrived do signed it by you Wareden.\n\nStep 3: Then go to Vaani Mandir and verify your parents signature form the office.\n\nStep 4: Now next step is to go to your Department and do signed this docment by your respective HOD.\n\nStep 5: Now again go to your hostel and signed this leave again by your Warden.\n\nStep 6: Now your final step is to go to Vanni Mandir and submit this leave.From there you'll get a slip that mentions your departure date.\n\nStep 7:Now its a final step where you have to take final signature of your Warden and give half part of the slip to her.\n\n\n\n\n\n\n\n\n\n\n\n\nNOW YOU ARE ALL DONE WITH THE LEAVE PROCESS........",
                style: TextStyle(fontSize: 15, fontFamily: 'OoohBaby'),
              )),
              Center(child: Text("HII")),
              Center(child: Text("Hey")),
            ],
          )),
    );
  }
}