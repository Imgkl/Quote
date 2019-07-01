import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'gradients.dart';

void main() => runApp(MyApp());
final greyColor = Color(0xff0d0d0d);
final cardColor = Colors.transparent;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: greyColor,
      debugShowCheckedModeBanner: false,
      title: 'Quotes.',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: MyHomePage(
        title: 'quotes.',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final int index = Random().nextInt(4);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          new Stack(
            children: <Widget>[
              Container(
                color: greyColor,
              )
            ],
          ),
          new Positioned(
            top: -75.0,
            right: 85.0,
            child: new Container(
              height: 120.0,
              width: 140.0,
              decoration: BoxDecoration(
                  gradient: yellowOrangeGradient, shape: BoxShape.circle),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 100),
            child: new Container(
              child: Text(
                "quote.",
                style: TextStyle(
                  fontFamily: "appbar",
                  fontSize: 45.0,
                  color: Colors.white,
                  // letterSpacing: 3.5,
                ),
              ),
            ),
          ),
          new Positioned(
            right: -7.0,
            top: 620.0,
            child: new Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                  gradient: yellowOrangeGradient, shape: BoxShape.circle),
            ),
          ),
          new Positioned(
            right: -75.0,
            top: 245.0,
            child: new Container(
              height: 150.0,
              width: 150.0,
              decoration: BoxDecoration(
                  gradient: blackSexyGradient, shape: BoxShape.circle),
            ),
          ),
          new Positioned(
            left: -75.0,
            top: 775.0,
            child: new Container(
              height: 150.0,
              width: 150.0,
              decoration: BoxDecoration(
                  gradient: blackBlueGradient, shape: BoxShape.circle),
            ),
          ),
          new Positioned(
            left: 65.0,
            top: 200.0,
            child: new Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                  gradient: skyBlueGradient, shape: BoxShape.circle),
            ),
          ),
          new Positioned(
            left: 65.0,
            top: 575.0,
            child: new Container(
              height: 25.0,
              width: 25.0,
              decoration: BoxDecoration(
                  gradient: thodaSexyGradient, shape: BoxShape.circle),
            ),
          ),
          new Positioned(
            left: 325.0,
            top: 845.0,
            child: new Container(
              height: 25.0,
              width: 25.0,
              decoration: BoxDecoration(
                  gradient: violetSexyGradient, shape: BoxShape.circle),
            ),
          ),
          new Positioned(
            top: 300,
            left: 45,
            child: Container(
              width: 355,
              height: 455,
              child: new FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('json/quotes.json'),
                builder: (context, snapshot) {
                  var quote = json.decode(snapshot.data.toString());

                  return new PageView.builder(
                    itemCount: quote.length,
                    controller: PageController(
                      viewportFraction: 0.85  ,
                      initialPage: 0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return new Card(
                        elevation: 10,
                        color: cardColor,
                        child: Container(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 19),
                                child: Text(
                                  "" + quote[index]['Quote'],
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.white,
                                    fontFamily: "fontaa",
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.25,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 195.0, top: 25),
                                child: Text(
                                  "-" + quote[index]['Author'],
                                  style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
