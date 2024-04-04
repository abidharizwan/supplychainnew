import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'home.dart';

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
      home: const sENDfEEDBACK(title: 'Review'),
    );
  }
}

class sENDfEEDBACK extends StatefulWidget {
  const sENDfEEDBACK({super.key, required this.title});



  final String title;

  @override
  State<sENDfEEDBACK> createState() => _sENDfEEDBACKState();
}

class _sENDfEEDBACKState extends State<sENDfEEDBACK> {
  String _rating="";
  // TextEditingController reviewController=new TextEditingController();
  TextEditingController ratingController=new TextEditingController();
  final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomeNewPage(title: ""),));
          },
        ),],
        backgroundColor: Color.fromARGB(255, 18, 82, 98),

        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,

        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/'), fit: BoxFit.cover),
          ),
          child: Center(

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: RatingBar.builder(
                    initialRating: 1,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating=rating.toString();
                      });

                    },
                  ),
                ),



                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(



                    onPressed: () async {
                      if(_formKey.currentState!.validate()) {
                        // String review=_review;
                        String rating = _rating;
                        SharedPreferences sh = await SharedPreferences
                            .getInstance();
                        String url = sh.getString('url').toString();
                        String lid = sh.getString('lid').toString();

                        final urls = Uri.parse('$url/customer_sendfeedback/');
                        try {
                          final response = await http.post(urls, body: {
                            'rating': rating,
                            // 'did':sh.getString("did").toString(),

                            'lid': lid,

                            // 'rid': sh.getString("rid").toString(),


                          });
                          if (response.statusCode == 200) {
                            String status = jsonDecode(response.body)['status'];
                            if (status == 'ok') {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    HomeNewPage(title: "Home"),));

                              Fluttertoast.showToast(msg: ' succesfuly');
                            } else {
                              Fluttertoast.showToast(msg: 'failed to send ');
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  String? Validatereview(String value){
    if(value.isEmpty){
      return 'please enter a review';
    }
    return null;
  }
}