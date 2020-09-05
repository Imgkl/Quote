import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:quotes/widgets/background.dart';
import 'dart:convert';
import 'package:share/share.dart';
import 'package:quotes/widgets/noglow.dart';

void main() {
 
    runApp(new MyApp());
 
}

final greyColor = Color(0xff0d0d0d);
final cardColor = Colors.red;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: greyColor,
      debugShowCheckedModeBanner: false,
      title: 'Quotes.',
      builder: (BuildContext context, Widget widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return getErrorWidget(context, errorDetails);
        };

        return widget;
      },
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: MyHomePage(
        title: 'quotes.',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List data;
  var _index;

  var quote;

  @override
  void initState() {
    super.initState();
    _random();
  }

  void _random() {
    setState(
      () {
        _index = Random(_index).nextInt(3000);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: greyColor,
        body: Stack(
          children: <Widget>[
            circle(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Row(
                    children: <Widget>[
                      new Container(
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
                    ],
                  ),
                ),
                new Container(
                  width: 355,
                  height: 475,
                  child: new FutureBuilder(
                    future: DefaultAssetBundle.of(context)
                        .loadString('json/quotes.json'),
                    builder: (context, snapshot) {
                      quote = json.decode(snapshot.data.toString());
                      return new PageView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return new PageView(
                            children: <Widget>[
                              ScrollConfiguration(
                                behavior: NoGlow(),
                                child: Center(
                                  child: SingleChildScrollView(
                                    child: new Container(
                                      child: new Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Padding(
                                            padding: const EdgeInsets.only(left: 19),
                                            child: Text(
                                                quote[_index]['Quote'],
                                              style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white,
                                                fontFamily: "fontaa",
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 195.0, top: 25),
                                            child: Text(
                                              "-" + quote[_index]['Author'],
                                              style: TextStyle(
                                                letterSpacing: 1,
                                                color: Colors.white.withOpacity(0.50),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                        physics: NeverScrollableScrollPhysics(),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: 90,
                      height: 50,
                      child: new RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        elevation: 10,
                        color: Colors.yellow.shade700,
                        child: new Icon(Icons.panorama_fish_eye,
                            color: Colors.black),
                        onPressed: () {
                          _random();
                        },
                      ),
                    ),
                    Container(
                      width: 90,
                      height: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        elevation: 10,
                        color: Colors.pink.shade200,
                        child: Icon(
                          Icons.share,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Share.share(
                              "${this.quote[_index]['Quote']}\n\n - ${this.quote[_index]['Author']}");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget getErrorWidget(BuildContext context, FlutterErrorDetails error) {
  return Center(
    child: SpinKitPulse(
      color: Colors.white,
      size: 110.0,
    ),
  );
}
