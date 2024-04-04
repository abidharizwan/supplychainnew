

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supplychainnew/signup.dart';

import 'home.dart';



void main() {
  runApp(const Quantity());
}

class Quantity extends StatelessWidget {
  const Quantity({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const QuantityPage(title: 'Login'),
    );
  }
}

class QuantityPage extends StatefulWidget {
  const QuantityPage({super.key, required this.title});

  final String title;

  @override
  State<QuantityPage> createState() => _QuantityPageState();
}

class _QuantityPageState extends State<QuantityPage> {


  TextEditingController qController = new TextEditingController();
  final formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),


        body: SingleChildScrollView(
          child: Form(
            key:formkey,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: qController,
                    decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Quantity")),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    _send_data();



                  },
                  child: Text("Add"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _send_data() async{


    String q=qController.text;




    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String pid = sh.getString('pid').toString();

    final urls = Uri.parse('$url/customer_addtocart/');
    try {
      final response = await http.post(urls, body: {
        'Quantity':q,
        'lid':lid,
        'pid':pid


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {

          // String lid=jsonDecode(response.body)['lid'];
          // sh.setString("lid", lid);

          Navigator.push(context, MaterialPageRoute(
            builder: (context) => HomeNewPage(title: "Home"),));
        }else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

}
