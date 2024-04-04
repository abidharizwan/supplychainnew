
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'components/curve.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewOrderStatus(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewOrderStatus extends StatefulWidget {
  const ViewOrderStatus({super.key, required this.title});


  final String title;

  @override
  State<ViewOrderStatus> createState() => _ViewOrderStatusState();
}

class _ViewOrderStatusState extends State<ViewOrderStatus> {

  _ViewOrderStatusState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> quantity_ = <String>[];
  List<String> PRODUCT_ = <String>[];
  List<String> date_ = <String>[];
  List<String> amount_ = <String>[];
  List<String> status_ = <String>[];



  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> quantity = <String>[];
    List<String> PRODUCT = <String>[];
    List<String> date = <String>[];
    List<String> amount = <String>[];
    List<String> status = <String>[];



    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/customer_vieworderstatus/';

      var data = await http.post(Uri.parse(url), body: {
        'lid':sh.getString('lid').toString()
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        quantity.add(arr[i]['quantity'].toString());
        PRODUCT.add(arr[i]['PRODUCT'].toString());
        date.add(arr[i]['date'].toString());
        amount.add(arr[i]['amount'].toString());
        status.add(arr[i]['status'].toString());




        // photo.add(urls+ arr[i]['photo']);

      }

      setState(() {
        id_ = id;
        quantity_=quantity;
        PRODUCT_=PRODUCT;
        date_=date;
        amount_=amount;
        status_=status;

      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          leading: BackButton( ),
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.primary,

          title: Text(widget.title),
        ),
        body:
        ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 4,
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: kGinColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CircleAvatar(
                    //   radius: 40, // Adjust the radius as needed
                    //   backgroundImage: NetworkImage(Image_[index]),
                    // ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            PRODUCT_[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreenColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Quantity:" + quantity_[index],
                            style: TextStyle(
                              color: kGreyColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Date:" + date_[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreenColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Amount: " + amount_[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreenColor,
                            ),
                          ),

                          SizedBox(height: 8),

                          Text(
                            "Status: " + status_[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreenColor,
                            ),
                          ),

                          SizedBox(height: 8),

                        ],
                      ),
                    ),

                  ],
                ),
              ),
            );
          },
        ),

        // ListView.builder(
        //   physics: BouncingScrollPhysics(),
        //   // padding: EdgeInsets.all(5.0),
        //   // shrinkWrap: true,
        //   itemCount: id_.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     return ListTile(
        //       onLongPress: () {
        //         print("long press" + index.toString());
        //       },
        //       title: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Column(
        //             children: [
        //               Card(
        //                 child:
        //                 Row(
        //                     children: [
        //                       // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
        //                       Column(
        //                         children: [
        //                           Padding(
        //                             padding: EdgeInsets.all(5),
        //                             child: Text(quantity_[index]),
        //                           ),
        //                           Padding(
        //                             padding: EdgeInsets.all(5),
        //                             child: Text(PRODUCT_[index]),
        //                           ), Padding(
        //                             padding: EdgeInsets.all(5),
        //                             child: Text(date_[index]),
        //                           ),
        //                           Padding(
        //                             padding: EdgeInsets.all(5),
        //                             child: Text(amount_[index]),
        //                           ),
        //                           Padding(
        //                             padding: EdgeInsets.all(5),
        //                             child: Text(status_[index]),
        //                           ),
        //                         ],
        //                       ),
        //                       // ElevatedButton(
        //                       //   onPressed: () async {
        //                       //
        //                       //     final pref =await SharedPreferences.getInstance();
        //                       //     pref.setString("did", id_[index]);
        //                       //
        //                       //     Navigator.push(
        //                       //       context,
        //                       //       MaterialPageRoute(builder: (context) => ViewSchedule()),
        //                       //     );
        //                       //
        //                       //
        //                       //
        //                       //
        //                       //   },
        //                       //   child: Text("Schedule"),
        //                       // ),
        //                     ]
        //                 )
        //
        //                 ,
        //                 elevation: 8,
        //                 margin: EdgeInsets.all(10),
        //               ),
        //             ],
        //           )),
        //     );
        //   },
        // )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
