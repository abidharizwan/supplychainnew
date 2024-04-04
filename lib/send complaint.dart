import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'login.dart';
void main() {
  runApp(const MyChangePassword());
}

class MyChangePassword extends StatelessWidget {
  const MyChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChangePassword',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SendComplaint(title: 'ChangePassword'),
    );
  }
}

class SendComplaint extends StatefulWidget {
  const SendComplaint({super.key, required this.title});

  final String title;

  @override
  State<SendComplaint> createState() => _SendComplaintState();
}

class _SendComplaintState extends State<SendComplaint> {


  @override
  Widget build(BuildContext context) {

    TextEditingController complaintController= new TextEditingController();
    final formkey = GlobalKey<FormState>();


    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
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
                    controller:complaintController,
                    maxLines: 8,

                    decoration: InputDecoration(border: OutlineInputBorder(),label: Text("COMPLAINT")),
                  ),
                ),


                ElevatedButton(
                  onPressed: ()
                  async {
                    if(formkey.currentState!.validate()) {
                      String complaint = complaintController.text.toString();


                      SharedPreferences sh = await SharedPreferences
                          .getInstance();
                      String url = sh.getString('url').toString();
                      String lid = sh.getString('lid').toString();

                      final urls = Uri.parse('$url/customer_sendcomplaint/');
                      try {
                        final response = await http.post(urls, body: {
                          'complaint': complaint,
                          'lid': lid,


                        });
                        if (response.statusCode == 200) {
                          String status = jsonDecode(response.body)['status'];
                          if (status == 'ok') {
                            Fluttertoast.showToast(
                                msg: 'send complaint successfully');
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    HomeNewPage(title: 'Login',)));
                          } else {
                            Fluttertoast.showToast(msg: 'Network error');
                          }
                        }
                        else {
                          Fluttertoast.showToast(msg: 'Network Error');
                        }
                      }
                      catch (e) {
                        Fluttertoast.showToast(msg: e.toString());
                      }
                    }
                  },
                  child: Text("send"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
