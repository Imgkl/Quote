import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quotes/main.dart';

class LocalNotifyPushService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String author = "";
  String quote = "";
  
  init() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    var initializationSettingsIOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeating channel id',
      'repeating channel name',
      'repeating description',
      playSound: true,
      enableVibration: true,
      styleInformation: BigTextStyleInformation(''),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
    flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      "✨Here is an amazing quote.",
      getQuoteString(),
      RepeatInterval.EveryMinute,
      platformChannelSpecifics,
    );
  }

  getQuoteString() {

    // var authorJson = [
    //   "Dr. Seuss",
    //   "Marilyn Monroe",
    //   "Oscar Wilde",
    //   "Albert Einstein",
    //   "Bernard M. Baruch",
    //   "William W. Purkey",
    //   "Dr. Seuss",
    //   "Marcus Tullius Cicero",
    //   "Frank Zappa",
    //   "Mae West",
    //   "Mahatma Gandhi",
    // ];

    var quoteJson = [
      "Don't cry because it's over, smile because it happened. \n- Dr. Seuss",
      "I'm selfish, impatient and a little insecure. I make mistakes, I am out of control and at times hard to handle. But if you can't handle me at my worst, then you sure as hell don't deserve me at my best. \n- Marilyn Monroe",
      "Be yourself; everyone else is already taken. \n- Oscar Wilde",
      "Two things are infinite: the universe and human stupidity; and I'm not sure about the universe. \n- Albert Einstein",
      "Be who you are and say what you feel, because those who mind don't matter, and those who matter don't mind.\n- Bernard M. Baruch",
      "You've gotta dance like there's nobody watching,Love like you'll never be hurt,Sing like there's nobody listening,And live like it's heaven on earth. \n- William W. Purkey",
      "You know you're in love when you can't fall asleep because reality is finally better than your dreams.\n- Dr. Seuss",
      "A room without books is like a body without a soul. \n- Marcus Tullius Cicero",
      "So many books, so little time.\n- Frank Zappa",
      "You only live once, but if you do it right, once is enough. \n- Mae West",
      "Be the change that you wish to see in the world.\n- Mahatma Gandhi",
    ];

    var randomNumber = Random().nextInt(10);
    print(randomNumber);
    return  quoteJson[randomNumber];
    // this.author = authorJson[randomNumber];
  }

  getAuthor() => this.author;
  getQuote() => this.quote;

  Future onSelectNotification(String payload) {
    print("Clicked");
  }
}
