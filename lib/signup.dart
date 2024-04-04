

import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:supplychainnew/ui/screens/login_screen.dart';


void main() {
  runApp(const MyMySignup());
}

class MyMySignup extends StatelessWidget {
  const MyMySignup({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MySignup',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyMySignupPage(title: 'MySignup'),
    );
  }
}

class MyMySignupPage extends StatefulWidget {
  const MyMySignupPage({super.key, required this.title});

  final String title;

  @override
  State<MyMySignupPage> createState() => _MyMySignupPageState();
}

class _MyMySignupPageState extends State<MyMySignupPage> {


  String gender = "Male";
  File? uploadimage;
  TextEditingController nameController= new TextEditingController();
  TextEditingController emailController= new TextEditingController();
  TextEditingController phoneController= new TextEditingController();
  TextEditingController placeController= new TextEditingController();
  TextEditingController postController= new TextEditingController();
  TextEditingController pinController= new TextEditingController();
  TextEditingController districtController= new TextEditingController();
  TextEditingController passwordController= new TextEditingController();
  TextEditingController confirmpaswordController= new TextEditingController();
  final formkey = GlobalKey<FormState>();





  // Future<void> chooseImage() async {
  //   // final choosedimage = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   //set source: ImageSource.camera to get image from camera
  //   setState(() {
  //     // uploadimage = File(choosedimage!.path);
  //   });
  // }




  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{ return true; },
      child:
      Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key:formkey ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Image.asset(
                    "assets/images/vector-1.png",
                    width: 413,
                    height: 457,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    textDirection: TextDirection.ltr,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Log In',
                        style: TextStyle(
                          color: Color(0xFF755DC1),
                          fontSize: 27,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "plz fill";
                          }
                          return null;
                        },

                        controller: nameController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF393939),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            color: Color(0xFF755DC1),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF837E93),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF9F7BFF),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "plz fill";
                          }
                          return null;
                        },
                        controller: emailController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF393939),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Color(0xFF755DC1),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF837E93),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF9F7BFF),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "plz fill";
                          }
                          return null;
                        },
                        controller: phoneController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF393939),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          labelStyle: TextStyle(
                            color: Color(0xFF755DC1),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF837E93),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF9F7BFF),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "plz fill";
                          }
                          return null;
                        },
                        controller: placeController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF393939),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Place',
                          labelStyle: TextStyle(
                            color: Color(0xFF755DC1),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF837E93),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF9F7BFF),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "plz fill";
                          }
                          return null;
                        },
                        controller: postController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF393939),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Post',
                          labelStyle: TextStyle(
                            color: Color(0xFF755DC1),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF837E93),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF9F7BFF),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "plz fill";
                          }
                          return null;
                        },
                        controller: pinController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF393939),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Pin',
                          labelStyle: TextStyle(
                            color: Color(0xFF755DC1),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF837E93),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF9F7BFF),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "plz fill";
                          }
                          return null;
                        },
                        controller: districtController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF393939),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'District',
                          labelStyle: TextStyle(
                            color: Color(0xFF755DC1),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF837E93),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF9F7BFF),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "plz fill";
                          }
                          return null;
                        },

                        controller: passwordController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF393939),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Color(0xFF755DC1),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF837E93),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF9F7BFF),

                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "plz fill";
                          }
                          return null;
                        },
                        controller: confirmpaswordController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF393939),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Confirmpassword',
                          labelStyle: TextStyle(
                            color: Color(0xFF755DC1),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF837E93),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF9F7BFF),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: SizedBox(
                          width: 329,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                _send_data();
                              }
                              },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF9F7BFF),
                            ),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Row(
                      //   children: [
                      //     const Text(
                      //       'Don’t have an account?',
                      //       style: TextStyle(
                      //         color: Color(0xFF837E93),
                      //         fontSize: 13,
                      //         fontFamily: 'Poppins',
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     ),
                      //     const SizedBox(
                      //       width: 2.5,
                      //     ),
                      //     InkWell(
                      //       onTap: () {
                      //
                      //       },
                      //       child: const Text(
                      //         'Sign Up',
                      //         style: TextStyle(
                      //           color: Color(0xFF755DC1),
                      //           fontSize: 13,
                      //           fontFamily: 'Poppins',
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // const Text(
                      //   'Forget Password?',
                      //   style: TextStyle(
                      //     color: Color(0xFF755DC1),
                      //     fontSize: 13,
                      //     fontFamily: 'Poppins',
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // Scaffold(
      //   appBar: AppBar(
      //     backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //     title: Text(widget.title),
      //   ),
      //   body: SingleChildScrollView(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         if (_selectedImage != null) ...{
      //           InkWell(
      //             child:
      //             Image.file(_selectedImage!, height: 400,),
      //             radius: 399,
      //             onTap: _checkPermissionAndChooseImage,
      //             // borderRadius: BorderRadius.all(Radius.circular(200)),
      //           ),
      //         } else ...{
      //           // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
      //           InkWell(
      //             onTap: _checkPermissionAndChooseImage,
      //             child:Column(
      //               children: [
      //                 Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
      //                 Text('Select Image',style: TextStyle(color: Colors.cyan))
      //               ],
      //             ),
      //           ),
      //         },
      //         Padding(
      //           padding: const EdgeInsets.all(8),
      //           child: TextField(
      //             controller: nameController,
      //             decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Name")),
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.all(8),
      //           child: TextField(
      //             controller: emailController,
      //             decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Email")),
      //           ),
      //         ),
      //         RadioListTile(value: "Male", groupValue: gender, onChanged: (value) { setState(() {gender="Male";}); },title: Text("Male"),),
      //         RadioListTile(value: "Female", groupValue: gender, onChanged: (value) { setState(() {gender="Female";}); },title: Text("Female"),),
      //         RadioListTile(value: "Other", groupValue: gender, onChanged: (value) { setState(() {gender="Other";}); },title: Text("Other"),),
      //         Padding(
      //           padding: const EdgeInsets.all(8),
      //           child: TextField(
      //             controller: phoneController,
      //             decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Phone")),
      //           ),
      //         ),   Padding(
      //           padding: const EdgeInsets.all(8),
      //           child: TextField(
      //             controller: placeController,
      //
      //             decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Place")),
      //           ),
      //         ),   Padding(
      //           padding: const EdgeInsets.all(8),
      //           child: TextField(
      //             controller: postController,
      //
      //             decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Post")),
      //           ),
      //         ),   Padding(
      //           padding: const EdgeInsets.all(8),
      //           child: TextField(
      //             controller: pinController,
      //
      //             decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Pin")),
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.all(8),
      //           child: TextField(
      //             controller: districtController,
      //
      //             decoration: InputDecoration(border: OutlineInputBorder(),label: Text("District")),
      //           ),
      //         ),       Padding(
      //           padding: const EdgeInsets.all(8),
      //           child: TextField(
      //             controller: passwordController,
      //
      //             decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Password")),
      //           ),
      //         ),       Padding(
      //           padding: const EdgeInsets.all(8),
      //           child: TextField(
      //             controller: confirmpaswordController,
      //
      //             decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Confirmpassword")),
      //           ),
      //         ),
      //
      //         ElevatedButton(
      //           onPressed: () {
      //
      //             _send_data() ;
      //
      //           },
      //           child: Text("Signup"),
      //         ),TextButton(
      //           onPressed: () {},
      //           child: Text("Login"),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
  void _send_data() async{

    String uname=nameController.text;
    String email=emailController.text;
    String phone=phoneController.text;
    String place=placeController.text;
    String post=postController.text;
    String pin=pinController.text;
    String district=districtController.text;
    String password=passwordController.text;
    String confirmpassword=confirmpaswordController.text;


    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/customer_signup/');
    try {

      final response = await http.post(urls, body: {
        "photo":photo,
        "gender":gender,
        'name':uname,
        'email':email,
        'phone':phone,
        'place':place,
        'post':post,
        'pin':pin,
        'district':district,
        'password':password,
        'confirmpassword':confirmpassword,


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {

          Fluttertoast.showToast(msg: 'Registration Successfull');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => LoginScreen(),));
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
  File? _selectedImage;
  String? _encodedImage;
  Future<void> _chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
        photo = _encodedImage.toString();
      });
    }
  }

  Future<void> _checkPermissionAndChooseImage() async {
    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadImage();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Please go to app settings and grant permission to choose an image.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  String photo = '';

}
