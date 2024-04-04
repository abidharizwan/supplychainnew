
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supplychainnew/send%20complaint.dart';
import 'package:supplychainnew/ui/screens/login_screen.dart';
import 'package:supplychainnew/view%20order%20status.dart';
import 'package:supplychainnew/view%20products.dart';
import 'package:supplychainnew/view%20profile%20.dart';
import 'package:supplychainnew/view%20reply.dart';
import 'package:supplychainnew/viewcart.dart';


import 'Send feedback.dart';
import 'editprofile.dart';
import 'login.dart';
void main() {
  runApp(const HomeNew());
}

class HomeNew extends StatelessWidget {
  const HomeNew({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const HomeNewPage(title: 'Home'),
    );
  }
}

class HomeNewPage extends StatefulWidget {
  const HomeNewPage({super.key, required this.title});

  final String title;

  @override
  State<HomeNewPage> createState() => _HomeNewPageState();
}

class _HomeNewPageState extends State<HomeNewPage> {

  String name_="";
  String gender_="";
  String post_="";
  String district_="";
  String place_="";
  String pin_="";

  String email_="";
  String phone_="";
  String photo_="";

  void _send_data() async{



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/customer_viewprofile/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid



      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          String name=jsonDecode(response.body)['name'];
          String email=jsonDecode(response.body)['email'];
          String phone=jsonDecode(response.body)['phone'].toString();
          String place=jsonDecode(response.body)['place'];
          String post=jsonDecode(response.body)['post'];
          String pin=jsonDecode(response.body)['pin'].toString();
          String district=jsonDecode(response.body)['district'];
          String gender=jsonDecode(response.body)['gender'];
          String photo=sh.getString('imgurl').toString()+jsonDecode(response.body)['photo'];


          setState(() {

            name_=name;
            post_=post;
            district_=district;
            place_=place;
            pin_=pin;
            // age_=age;
            gender_=gender;
            email_=email;
            phone_=phone;
            photo_=photo;

          });





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





  String uname_="";
  // String uemail_="";
  String uphoto_="";


  _HomeNewPageState()
  {
    a();
    _send_data();
  }

  a()
  async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String name = sh.getString('name').toString();
    // String email = sh.getString('email').toString();
    String photo =sh.getString("imgurl").toString()+ sh.getString('photo').toString();


    setState(() {
      uname_=name;
      // uemail_=email;
      uphoto_=photo;

    });


  }


  TextEditingController unameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 18, 82, 98),

          title: Text(widget.title),
        ),
        body:
        SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: 280,
                width: double.infinity,
                child: Image.network(
                  photo_,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16.0, 240.0, 16.0, 16.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.only(top: 16.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(left: 110.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            name_,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),

                                          SizedBox(
                                            height: 40,
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      // CircleAvatar(
                                      //   backgroundColor: Colors.blueAccent,
                                      //   child: IconButton(
                                      //       // onPressed: () {
                                      //       //   Navigator.push(context, MaterialPageRoute(builder: (context) =>MyeditPage(title: "Edit"),));
                                      //
                                      //       },
                                      //       icon: Icon(
                                      //         Icons.edit_outlined,
                                      //         color: Colors.white,
                                      //         size: 18,
                                      //       )),
                                      // )
                                    ],
                                  )),
                              SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [Text(gender_), Text("Gender")],
                                    ),
                                  ),
                                  // Expanded(
                                  //   child: Column(
                                  //     children: [Text(age_), Text("Age")],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      photo_),
                                  fit: BoxFit.cover)),
                          margin: EdgeInsets.only(left: 20.0),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("Profile Information"),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Email"),
                            subtitle: Text(email_),
                            leading: Icon(Icons.mail_outline),
                          ),
                          ListTile(
                            title: Text("Phone"),
                            subtitle: Text(phone_),
                            leading: Icon(Icons.phone),
                          ),
                          ListTile(
                            title: Text("Address"),
                            subtitle: Text(
                                '$place_, $pin_, $post_,$district_'),
                            leading: Icon(Icons.map),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Positioned(
              //   top: 60,
              //   left: 20,
              //   child: MaterialButton(
              //     minWidth: 0.2,
              //     elevation: 0.2,
              //     color: Colors.white,
              //     child: const Icon(Icons.arrow_back_ios_outlined,
              //         color: Colors.indigo),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(30.0),
              //     ),
              //     onPressed: () {},
              //   ),
              // ),
            ],
          ),
        ),





        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 18, 82, 98),
                ),
                child:
                Column(children: [

                  Text(
                    'Block chain based supply chain information sharing mechanism',
                    style: TextStyle(fontSize: 20,color: Colors.white),

                  ),
                  CircleAvatar(radius: 29,backgroundImage: NetworkImage(uphoto_)),
                  Text(uname_,style: TextStyle(color: Colors.white)),
                  // Text(uemail_,style: TextStyle(color: Colors.white)),



                ])


                ,
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeNewPage(title: 'home'),));
                },
              ),

              ListTile(
                leading: Icon(Icons.person_pin_outlined),
                title: const Text(' viewprofile '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProfilePage(title: 'viewprofile ',),));
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_basket),
                title: const Text(' viewproduct '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProduct(title: 'viewproduct'),));
                },
              ),





              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: const Text(' viewcart '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Viewcart(title: 'Addtocart'),));
                },

              ),

              ListTile(
                leading: Icon(Icons.shopping_bag),
                title: const Text(' vieworderstatus '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewOrderStatus(title: "vieworderstatus",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.feedback),
                title: const Text(' SendFeedback '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => sENDfEEDBACK(title: "sendfeedback",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: const Text(' Sendcomplaint '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SendComplaint(title: "sendcomplaint",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.reply),
                title: const Text(' Viewreply '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewReplyPage(title: "viewreply",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text('LogOut'),
                onTap: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

