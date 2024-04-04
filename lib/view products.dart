
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supplychainnew/quantity.dart';

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
      home: const ViewProduct(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewProduct extends StatefulWidget {
  const ViewProduct({super.key, required this.title});


  final String title;

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {

  _ViewProductState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> name_ = <String>[];
  List<String> description_ = <String>[];
  List<String> category_ = <String>[];
  List<String> unitofmeasurement_ = <String>[];
  List<String> Image_ = <String>[];



  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> name = <String>[];
    List<String> description = <String>[];
    List<String> category = <String>[];
    List<String> unitofmeasurement = <String>[];
    List<String> Image = <String>[];



    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String imgurl = sh.getString('imgurl').toString();
      String url = '$urls/customer_viewproduct/';

      var data = await http.post(Uri.parse(url), body: {


      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        name.add(arr[i]['name']);
        description.add(arr[i]['description']);
        category.add(arr[i]['category']);
        unitofmeasurement.add(arr[i]['unitofmeasurement']);
        Image.add(imgurl+arr[i]['Image']);



        // photo.add(urls+ arr[i]['photo']);

      }

      setState(() {
        id_ = id;
        name_=name;
        description_=description;
        category_=category;
        unitofmeasurement_=unitofmeasurement;
        Image_=Image;

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
                    CircleAvatar(
                      radius: 40, // Adjust the radius as needed
                      backgroundImage: NetworkImage(Image_[index]),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name_[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreenColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Category:" + category_[index],
                            style: TextStyle(
                              color: kGreyColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Description:" + description_[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreenColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Unitofmeasurement: " + unitofmeasurement_[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreenColor,
                            ),
                          ),

                          SizedBox(height: 8),
                      ElevatedButton(
                                               onPressed: () async {

                                                  final pref =await SharedPreferences.getInstance();
                                                  pref.setString("pid", id_[index]);

                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => QuantityPage(title: '',)),
                                                  );




                                                },
                                                child: Text("Add to cart")),
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
        //                       CircleAvatar(radius: 50,backgroundImage: NetworkImage(Image_[index])),
        //                       Column(
        //                         children: [
        //                           Padding(
        //                             padding: EdgeInsets.all(5),
        //                             child: Text(name_[index]),
        //                           ),
        //                           Padding(
        //                             padding: EdgeInsets.all(5),
        //                             child: Text(description_[index]),
        //                           ), Padding(
        //                             padding: EdgeInsets.all(5),
        //                             child: Text(category_[index]),
        //                           ),
        //                           Padding(
        //                             padding: EdgeInsets.all(5),
        //                             child: Text(unitofmeasurement_[index]),
        //                           ),
        //
        //                         ],
        //                       ),
        //                        ElevatedButton(
        //                        onPressed: () async {
        //
        //                           final pref =await SharedPreferences.getInstance();
        //                           pref.setString("pid", id_[index]);
        //
        //                           Navigator.push(
        //                             context,
        //                             MaterialPageRoute(builder: (context) => QuantityPage(title: '',)),
        //                           );
        //
        //
        //
        //
        //                         },
        //                         child: Text("Add to cart"),
        //                       ),
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
