// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class  MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ReadingStatsScreen(),
    );
  }
}

class ReadingStatsScreen extends StatefulWidget {
  @override
  _ReadingStatsScreenState createState() => _ReadingStatsScreenState();
}

class _ReadingStatsScreenState extends State<ReadingStatsScreen> {
  Future<int> fetchRandomNumber() async {
    final response = await http.get(
      Uri.parse(
          'https://www.randomnumberapi.com/api/v1.0/random?min=100&max=1000&count=1'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)[0];
    } else {
      throw Exception('Failed to load random number');
    }
  }

  final List<String> avatarImages = [
    'assets/avatar1.jpg',
    'assets/avatar2.jpg',
    'assets/avatar3.jpg',
    'assets/avatar4.jpg',
    'assets/avatar5.jpg',
    'assets/avatar6.jpg',
    'assets/avatar7.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(33, 33, 33, 1),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.jpg'),
            ),
            SizedBox(width: 10),
            Text(
              'Amy\'s reader stats',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            buildwarcard(),
            SizedBox(height: 05),
            buildProgressCard(),
            SizedBox(height: 05),
            Row(
              children: [
                Expanded(child: buildCardContainer(buildTimeCard())),
                SizedBox(width: 10),
                Expanded(child: buildCardContainer(buildStreakCard())),
              ],
            ),
            SizedBox(height: 05),
            Row(
              children: [
                Expanded(child: buildCardContainer(buildLevelCard())),
                SizedBox(width: 10),
                Expanded(child: buildCardContainer(buildBadgesCard())),
              ],
            ),
            SizedBox(height: 10),
            buildfriends(),
            SizedBox(height: 17),
            buildLeaderboard(),
          ],
        ),
      ),
    );
  }

  Widget buildCardContainer(Widget card) {
    return Container(
      width: double.infinity,
      height: 200, // fixed height for the cards
      child: card,
    );
  }

  Widget buildwarcard() {
    return Container(
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/warbook.jpeg',
            width: 50,
            height: 50,
          ), 
          SizedBox(width: 10),
          Expanded(
              child: Text('War and Peace',
                  style: TextStyle(color: Colors.white, fontSize: 20))),
          SizedBox(width: 10),

          Container(
            height: 35,
            width: 35,
            padding: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 41, 43, 44),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  // if needed
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProgressCard() {
    return Card(
      color: Color.fromARGB(255, 247, 198, 76),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('PROGRESS', style: TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  height: 35,
                  width: 35,
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 231, 177, 0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Image.asset(
                    'assets/upload.png',
                    height: 30.0,
                    width: 30.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            FutureBuilder<int>(
              future: fetchRandomNumber(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  int progress = snapshot.data ?? 0;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/openbook.png',
                                    height: 40.0,
                                    width: 40.0,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '$progress',
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Out of 1,225 pages',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '#5 among friends',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 14),
                      LinearProgressIndicator(
                        value: progress / 1225,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 0, 0, 0)),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(avatarImages[0]),
                            radius: 15,
                          ),
                          SizedBox(
                              width: 50), 
                          CircleAvatar(
                            backgroundImage: AssetImage(avatarImages[1]),
                            radius: 15,
                          ),
                          SizedBox(
                              width: 30), 
                          CircleAvatar(
                            backgroundImage: AssetImage(avatarImages[2]),
                            radius: 15,
                          ),
                          SizedBox(
                              width: 20), 
                          CircleAvatar(
                            backgroundImage: AssetImage(avatarImages[3]),
                            radius: 15,
                          ),
                          SizedBox(width: 10), 
                          Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(avatarImages[4]),
                                radius: 15,
                              ),
                              Transform.translate(
                                offset: Offset(18,0), 
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(avatarImages[5]),
                                  radius: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox( width:30),
                          CircleAvatar(
                            backgroundImage: AssetImage(avatarImages[6]),
                            radius: 15,
                          ),
                        ],
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTimeCard() {
    return Card(
      color: Color.fromARGB(255, 216, 125, 83),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "TIME",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Container(
                  height: 35,
                  width: 35,
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 206, 110, 54),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Image.asset(
                    'assets/upload.png',
                    height: 20.0,
                    width: 20.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(Icons.access_time, size: 35.0),
                SizedBox(width: 8.0),
                Text(
                  "6:24",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              "Global avg. read time for your progress 7:28",
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            Text(
              "23% faster",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStreakCard() {
    return Card(
      color: Color.fromARGB(255, 164, 209, 92),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "STREAK",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Container(
                  height: 35,
                  width: 35,
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 134, 192, 67),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Image.asset(
                    'assets/upload.png',
                    height: 20.0,
                    width: 20.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Image.asset(
                  'assets/flash.png',
                  height: 30.0,
                  width: 30.0,
                ),
                SizedBox(width: 8.0),
                Text(
                  "7",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              "Day streak, come back tomorrow to keep it up!",
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            Text(
              "19% more consistent",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLevelCard() {
    return IntrinsicHeight(
      child: Card(
        color: Color.fromARGB(255, 168, 126, 156),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "LEVEL",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 35,
                    width: 35,
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 139, 76, 121),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Image.asset(
                      'assets/upload.png',
                      height: 20.0,
                      width: 20.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Image.asset(
                    'assets/crown.png',
                    height: 35.0,
                    width: 35.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    "2",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                "145 reader points to level up! ",
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              Text(
                "Top 5% for this book",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBadgesCard() {
    return IntrinsicHeight(
      child: Card(
        color: Color.fromARGB(255, 100, 224, 214),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Badges",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 35,
                    width: 35,
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 48, 216, 216),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(
                      'assets/upload.png',
                      height: 20.0,
                      width: 20.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(
                    'assets/badge1.png',
                    width: 40,
                    height: 31,
                  ),
                  Image.asset(
                    'assets/badge2.png',
                    width: 40,
                    height: 31,
                  ),
                  Image.asset(
                    'assets/badge3.png',
                    width: 40,
                    height: 31,
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(
                    'assets/badge4.png',
                    width: 40,
                    height: 31,
                  ),
                  Image.asset(
                    'assets/badge5.png',
                    width: 40,
                    height: 31,
                  ),
                  Image.asset(
                    'assets/badge6.png',
                    width: 40,
                    height: 31,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildfriends() {
    return Row(
      children: <Widget>[
        Container(
          width: 320,
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 63, 74, 80),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '+ Add friends',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.0), // Optional spacing between containers
        Container(
          height: 35,
          width: 35,
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 41, 43, 44),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Image.asset(
            'assets/upload.png',
            height: 20.0,
            width: 20.0,
          ),
        ),
      ],
    );
  }

  Widget buildLeaderboard() {
    return Row(
      children: <Widget>[
        Text(
          'Leaderboard',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }
}
