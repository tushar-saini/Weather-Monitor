import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_app/CRED.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: USERNAME,
        password: PASSWORD,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Map data = {
    'pm1'       : '_',
    'pm25'      : '_',
    'pm10'      : '_',
    'bpressure' : '_',
    'btemp'     : '_',
    'ddewpoint' : '_',
    'dheatindex': '_',
    'dhumid'    : '_',
    'timestamp' : '-',
  };

  Future<void> getDataFromFirestore() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    await db.collection("home").orderBy('timestamp', descending: true).limit(1).get().then((event) {
      for (var doc in event.docs) {
        data = doc.data();
      }
    });
    
    setState(() {
      _counter++;
    });
  }

  Widget bodyApp(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget> [
          Row(
            children: <Widget> [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 16,
                      height: 140,
                      child: Material(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              Text( 'PM 10: ',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              const SizedBox(height: 15,),
                              Text(
                                data['pm10'] + ' \u03BCg/m\u00B3',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: <Widget> [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 4.0, 8.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width/2 - 12,
                      height: 130,
                      child: Material(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              Text('PM 2.5: ',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                data['pm25'] + ' \u03BCg/m\u00B3',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4.0, 8.0, 8.0, 8.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width/2 - 12,
                      height: 130,
                      child: Material(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              Text('PM 1.0: ',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                data['pm1'] + '  \u03BCg/m\u00B3',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: <Widget> [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 4.0, 8.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width/2 - 12,
                      height: 130,
                      child: Material(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              Text('Temp: ',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                data['btemp'] + ' \u2103',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4.0, 8.0, 8.0, 8.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width/2 - 12,
                      height: 130,
                      child: Material(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              Text('Dewpoint: ',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                data['ddewpoint'] + ' \u2103',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: <Widget> [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 4.0, 4.0, 8.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width/2 - 12,
                      height: 130,
                      child: Material(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              Text('Pressure: ',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                data['bpressure'] + ' hPa',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4.0, 4.0, 8.0, 8.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width/2 - 12,
                      height: 130,
                      child: Material(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              Text('Humidity: ',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                data['dhumid'] + ' %',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: <Widget> [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 16,
                      height: 140,
                      child: Material(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              Text( 'Heat Index: ',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              const SizedBox(height: 15,),
                              Text(
                                data['dheatindex'] + ' \u2103',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 16,
                  height: 140,
                  child: Material(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
                          Text( 'Updated on: ',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(height: 15,),
                          Text(
                            data['timestamp'] == '-'? '-': data['timestamp'].toDate().toString(),
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: bodyApp(context),
      floatingActionButton: FloatingActionButton(
        onPressed: getDataFromFirestore,
        tooltip: 'Data',
        child: const Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
