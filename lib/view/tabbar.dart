
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'affichageDemande.dart';
import 'affichageHistory.dart';


class FirstTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return affichageDemande();
  }


}

class SecondTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return affichageHistory();
  }
}

class TabBarExample extends StatefulWidget {
  TabBarExample({Key? key}) : super(key: key);

  @override
  _TabBarExampleState createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<TabBarExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110.0),
        child: AppBar(
          backgroundColor: Color(0xFF105EA0),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(10.0),
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 25, bottom: 8), // Adjust top padding
              child: Text(
                'Request',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Georgia",
                ),
              ),
            ),
          ),
        ),
      ),

      body: SafeArea(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: <Widget>[
                        ButtonsTabBar(
                          backgroundColor: Color(0xFF105EA0),
                          unselectedBackgroundColor: Color(0xFF3C77E1),
                          unselectedLabelStyle: TextStyle(color: Colors.white),
                          tabs: [
                            Tab(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal:50.0),
                                child: Text("Requests",
                                style: TextStyle(
                                  color: Colors.white,  // Set the text color explicitly
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ),
                            Tab(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 50.0), // Adjust the value as needed
                                child: Text("History",
                                  style: TextStyle(
                                    color: Colors.white,  // Set the text color explicitly
                                    fontWeight: FontWeight.bold,
                                  ),
                              ),
                            ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: <Widget>[
                              FirstTabContent(),
                              SecondTabContent(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );

  }
}

