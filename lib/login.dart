

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supplychainnew/signup.dart';

import 'home.dart';



void main() {
  runApp(const MyLogin());
}

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyLoginPage(title: 'Login'),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {


  TextEditingController unameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
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
                  child: TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "plz fill";
                        }
                        return null;
                      },
                    controller: unameController,
                    decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Username")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "plz fill";
                        }
                        return null;
                      },
                    controller: passwordController,
                    decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Password")),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                     if (formkey.currentState!.validate()) {
                       _send_data();
                     }



                  },
                  child: Text("Login"),
                ),TextButton(
                  onPressed: () {
                   if (formkey.currentState!.validate()) {
                 _send_data();
                     }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyMySignupPage(title: '',)),
                    );
                  },
                  child: Text("Signup"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _send_data() async{


    String uname=unameController.text;
    String password=passwordController.text;




    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/customer_login/');
    try {
      final response = await http.post(urls, body: {
        'username':uname,
        'password':password,


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {

          String lid=jsonDecode(response.body)['lid'];
          sh.setString("lid", lid);

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
