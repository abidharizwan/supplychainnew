import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supplychainnew/ui/screens/login_screen.dart';

import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ipcontroller=TextEditingController();

  get http => null;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller:ipcontroller,

                decoration: InputDecoration(border: OutlineInputBorder(),label: Text("type")),
              ),
            ),


            ElevatedButton(
              onPressed: () async {

                String ip= ipcontroller.text.toString();
                SharedPreferences sh = await SharedPreferences.getInstance();
                sh.setString("url", "http://"+ip+":8000/myapp");
                sh.setString("imgurl", "http://"+ip+":8000");
                sh.setString("img_url", "http://"+ip+":8000");
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LoginScreen(),));

              },
              child: Text("connect"),
            ),

          ],
        ),
      ),
    );
  }
}
