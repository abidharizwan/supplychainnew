import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supplychainnew/home.dart';

import 'components/curve.dart';






void main() {
  runApp(const ViewSlot());
}

class ViewSlot extends StatelessWidget {
  const ViewSlot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Materials',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF184A2C)),
        useMaterial3: true,
      ),
      home: const Viewcart(title: ''),
    );
  }
}

class Viewcart extends StatefulWidget {
  const Viewcart({super.key, required this.title});

  final String title;

  @override
  State<Viewcart> createState() => _ViewcartState();
}

class _ViewcartState extends State<Viewcart> {

  _ViewcartState(){
    ViewSlot();
  }

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();

    ViewSlot();

    // Initializing Razorpay
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // Disposing Razorpay instance to avoid memory leaks
    _razorpay.clear();
    super.dispose();
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Handle successful payment
    print("Payment Successful: ${response.paymentId}");

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/user_makepayment/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid,



      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {

ViewSlot();
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

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    print("Error in Payment: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
    print("External Wallet: ${response.walletName}");
  }

  void _openCheckout() {

    int am= int.parse(amount_) *100;

    var options = {
      'key': 'rzp_test_HKCAwYtLt0rwQe', // Replace with your Razorpay API key
      'amount': am, // Amount in paise (e.g. 2000 paise = Rs 20)
      'name': 'Flutter Razorpay Example',
      'description': 'Payment for the product',
      'prefill': {'contact': '9747360170', 'email': 'tlikhil@gmail.com'},
      'external': {
        'wallets': ['paytm'] // List of external wallets
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }

  String amount_="0";
  List<String> id_ = <String>[];
  List<String> Productname_ = <String>[];
  List<String> MRP_ = <String>[];
  List<String> Offerprice_ = <String>[];
  List<String> Colour_ = <String>[];
  List<String> Quantity_ = <String>[];
  List<String> Primarymaterial_ = <String>[];
  List<String> Image_ = <String>[];
  get status => null;

  Future<void> ViewSlot() async {
    List<String> id = <String>[];
    List<String> Productname = <String>[];
    List<String> MRP = <String>[];
    List<String> Offerprice = <String>[];
    List<String> Colour = <String>[];
    List<String> Quantity = <String>[];
    List<String> Primarymaterial = <String>[];
    List<String> Image = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String pid = sh.getString('pid').toString();

      String url = '$urls/user_viewcart/';

      var data = await http.post(Uri.parse(url), body: {
        'lid': lid,
        'pid': pid,

      });
      print(data.body);  // Print the raw data

      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];
      String amount = jsondata['amount'].toString();
      sh.setString('amount',amount).toString();

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        Productname.add(arr[i]['Productname'].toString());
        MRP.add(arr[i]['MRP'].toString());
        Offerprice.add(arr[i]['Offerprice'].toString());
        Colour.add(arr[i]['Colour'].toString());
        Quantity.add(arr[i]['Quantity'].toString());
        Primarymaterial.add(arr[i]['Primarymaterial'].toString());
        Image.add(sh.getString('img_url').toString()+arr[i]['Image']);
      }

      setState(() {
        id_ = id;
        Productname_ = Productname;
        MRP_ = MRP;
        Offerprice_ = Offerprice;
        Colour_ = Colour;
        Quantity_ = Quantity;
        Primarymaterial_ = Primarymaterial;
        Image_ = Image;
        amount_=amount;

      });


      print(statuss);
    } catch (e) {
      print("Network Error: $e");
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

  TextEditingController tc= new TextEditingController();
  // void _showInputDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Enter quantity '),
  //         content: TextField(
  //           controller: tc,
  //           decoration: InputDecoration(hintText: "Enter qunitity"),
  //         ),
  //         actions: <Widget>[
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Cancel'),
  //           ),
  //           // ElevatedButton(
  //           //   onPressed: () async {
  //           //
  //           //     SharedPreferences sh = await SharedPreferences.getInstance();
  //           //     String url = sh.getString('url').toString();
  //           //     String lid = sh.getString('lid').toString();
  //           //     String selmid = sh.getString('selmid').toString();
  //           //
  //           //     final urls = Uri.parse('$url/user_addto_cart/');
  //           //     try {
  //           //       final response = await http.post(urls, body: {
  //           //
  //           //         'lid':lid,
  //           //         'mid': selmid,
  //           //         'qty':tc.text.toString()
  //           //
  //           //
  //           //
  //           //       });
  //           //       if (response.statusCode == 200) {
  //           //         String status = jsonDecode(response.body)['status'];
  //           //
  //           //         if (status == 'ok') {
  //           //
  //           //           Fluttertoast.showToast(msg: 'Added to cart');
  //           //           Navigator.of(context).pop();
  //           //
  //           //         }
  //           //         else {
  //           //           Fluttertoast.showToast(msg: 'Failed to add cart');
  //           //           Navigator.of(context).pop();
  //           //         }
  //           //       }                }
  //           //     catch (e){
  //           //       Fluttertoast.showToast(msg: e.toString());
  //           //     }
  //           //
  //           //     // Do something with the input
  //           //     Navigator.of(context).pop();
  //           //   },
  //           //   child: Text('OK'),
  //           // ),
  //         ],
  //       );
  //     },
  //   );
  // }




  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            leading: BackButton( onPressed:() {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeNewPage(title: 'home')),);


            },),

            backgroundColor: Colors.white,
            foregroundColor: Colors.black,

            title: Text(widget.title),
            actions: [
              Text(
                  amount_
              ),
              IconButton(
                icon: Icon(Icons.payment),
                onPressed: () {

                  _openCheckout();





                  // Add action logic here
                },
              ),]
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
                            Productname_[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreenColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "MRP: " + MRP_[index],
                            style: TextStyle(
                              color: kGreyColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Offer : " + Offerprice_[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreenColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Category : " + Colour_[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kDarkGreenColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Unit of measurement : " + Primarymaterial_[index],
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
                    IconButton(
                      onPressed: () async {
                        SharedPreferences sh = await SharedPreferences.getInstance();
                        String url = sh.getString('url').toString();
                        String cid = id_[index].toString();

                        final urls = Uri.parse('$url/removefromcart/');
                        try {
                          final response = await http.post(urls, body: {
                            'cid': cid,
                          });
                          if (response.statusCode == 200) {
                            String status = jsonDecode(response.body)['status'];
                            if (status == 'ok') {
                              Fluttertoast.showToast(msg: 'Removed Successfully');

                              ViewSlot();
                            } else {
                              Fluttertoast.showToast(msg: 'Not Found');
                            }
                          } else {
                            Fluttertoast.showToast(msg: 'Network Error');
                          }
                        } catch (e) {
                          Fluttertoast.showToast(msg: e.toString());
                        }
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        // floatingActionButton: FloatingActionButton(onPressed: () {
        //
        //   _openCheckout();
        //
        // },
        //   child: text(''),
        // ),


      ),
    );
  }
}