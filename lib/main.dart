import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:quotes/background.dart';
import 'package:quotes/features/quotes/data/datasources/quote_local_data_source.dart';
import 'package:quotes/features/quotes/data/repositories/quote_repository_impl.dart';
import 'package:quotes/features/quotes/domain/entities/quote.dart';
import 'package:quotes/features/quotes/presentation/bloc/bloc.dart';
import 'package:share/share.dart';

import 'features/quotes/data/models/quote_model.dart';
import 'features/quotes/domain/usecases/get_random_quote.dart';
import 'features/quotes/presentation/widgets/widgets.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

final greyColor = Color(0xff0d0d0d);
final cardColor = Colors.red;
final String quotePath = 'assets/quotes.json';

// class MyApp extends StatelessWidget {
//   @override
// Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Number Trivia',
//       theme: ThemeData(
//         primaryColor: Colors.green.shade800,
//         accentColor: Colors.green.shade600,
//       ),
//       home: QuotePage(),
//     );
//   }

// }

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
  // List data;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: greyColor,
        body: _buildBody(context),
      ),
    );
  }
}

BlocProvider<QuoteBloc> _buildBody(BuildContext context) {
  return BlocProvider(
    builder: (_) => QuoteBloc(
      random: GetRandomQuote(
        QuoteRepositoryImpl(
          localDataSource: QuoteLocalDataSourceImpl(quotePath),
        ),
      ),
    ),
    child: Stack(
      children: <Widget>[
        circle(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TitleZone(),
            BlocBuilder<QuoteBloc, QuoteState>(builder: (context, state) {
              if (state is Empty) {
                dispatchRandom(context);
                return Center(child: Text("EMPTY STATE"));
              } else if (state is Loading) {
                return LoadingWidget();
              } else if (state is Loaded) {
                return QuoteZone(state.quote);
              } else {
                return Center(
                  child: Text(
                    "ERROR STATE",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
            }),
            ButtonZone(),
          ],
        )
      ],
    ),
  );
}

void dispatchRandom(BuildContext context) {
  BlocProvider.of<QuoteBloc>(context).dispatch(GetRandomQuoteEvent());
}

Widget getErrorWidget(BuildContext context, FlutterErrorDetails error) {
  return Center(
    child: SpinKitPulse(
      color: Colors.white,
      size: 110.0,
    ),
  );
}

class TitleZone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, top: 30),
      child: Row(
        children: <Widget>[
          new Container(
            child: Text(
              "quote.",
              style: TextStyle(
                fontFamily: "appbar",
                fontSize: 45.0,
                color: Colors.white,
                letterSpacing: 3.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuoteZone extends StatelessWidget {
  final QuoteModel quote;
  QuoteZone(this.quote);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 355,
        // height: 475,
        child: Column(
          children: <Widget>[
            Text(
              quote.quote,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontFamily: "fontaa",
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            Text(
              "-" + quote.author,
              style: TextStyle(
                letterSpacing: 1,
                color: Colors.white.withOpacity(0.50),
              ),
            ),
          ],
        ),
      ),
    );

    // return Container(
    //   width: 355,
    //   height: 475,
    //   child: new FutureBuilder(
    //     future: DefaultAssetBundle.of(context).loadString('json/quotes.json'),
    //     builder: (context, snapshot) {
    //       var quote = json.decode(snapshot.data.toString());

    //       return new PageView.builder(
    //         itemBuilder: (BuildContext context, int index) {
    //           return new PageView(
    //             children: <Widget>[
    //               new Container(
    //                 child: new Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: <Widget>[
    //                     new Padding(
    //                       padding: const EdgeInsets.only(left: 19),
    //                       child: Text(
    //                         "" + quote[_index]['Quote'],
    //                         style: TextStyle(
    //                           fontSize: 30,
    //                           color: Colors.white,
    //                           fontFamily: "fontaa",
    //                           fontWeight: FontWeight.bold,
    //                           letterSpacing: 2,
    //                         ),
    //                       ),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(left: 195.0, top: 25),
    //                       child: Text(
    //                         "-" + quote[_index]['Author'],
    //                         style: TextStyle(
    //                           letterSpacing: 1,
    //                           color: Colors.white.withOpacity(0.50),
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           );
    //         },
    //         physics: NeverScrollableScrollPhysics(),
    //       );
    //     },
    //   ),
    // );
  }
}

class ButtonZone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ButtonSlot(QuoteButton()),
          ButtonSlot(ShareButton())
        ],
      ),
    );
  }
}

class ButtonSlot extends StatelessWidget {
  final Widget button;
  ButtonSlot(this.button);

  @override
  Widget build(BuildContext context) {
    return Container(width: 90, height: 50, child: this.button);
  }
}

class QuoteButton extends StatelessWidget {
  QuoteButton();

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 10,
      color: Colors.yellow.shade700,
      child: new Icon(Icons.panorama_fish_eye, color: Colors.black),
      onPressed: () => dispatchRandom(context),
    );
  }

  void dispatchRandom(BuildContext context) {
    BlocProvider.of<QuoteBloc>(context).dispatch(GetRandomQuoteEvent());
  }
}

class ShareButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 10,
      color: Colors.pink.shade200,
      child: Icon(
        Icons.share,
        color: Colors.black,
      ),
      onPressed: () {
        Share.share(
            'I haven’t failed. I��ve just found 10,000 ways that won’t work. \n\nCheck out this amazing app with 3000+ quotes. \t www.github.com/Imgkl/Quotes.');
      },
    );
  }
}
