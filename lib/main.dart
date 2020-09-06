import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:quotes/services/notification.dart';
import 'package:quotes/widgets/background.dart';
import 'dart:convert';
import 'package:share/share.dart';
import 'package:quotes/widgets/noglow.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifyPushService().init();
  await LocalNotifyPushService().getQuoteString();
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
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity),
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  List data;
  var _index;

  var quote;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    random();
    LocalNotifyPushService().getQuoteString();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      LocalNotifyPushService().init();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void random() {
    setState(
      () {
        _index = Random(_index).nextInt(4000);
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
                  padding: const EdgeInsets.only(left: 20.0, top: 20),
                  child: Row(
                    children: <Widget>[
                      new Container(
                        child: Text("quote.",
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(
                                    color: Colors.white, fontFamily: "appbar")),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Padding(
                                            padding:
                                                const EdgeInsets.only(left: 19),
                                            child: Text(
                                              quote[_index]['Quote'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 2,
                                                      color: Colors.white,
                                                      fontFamily: "fontaa"),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 195.0, top: 25),
                                            child: Text(
                                              "- " + quote[_index]['Author'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                      fontFamily: "fontaa")
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
                          random();
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
