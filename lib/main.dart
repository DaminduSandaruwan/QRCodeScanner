import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = "Hey there!";
  Future _scanQR() async{
    try{
      String qrResult = await BarcodeScanner.scan().toString();
      setState(() {
        result=qrResult;
      });
    }on PlatformException catch(ex){
      if(ex.code==BarcodeScanner.cameraAccessDenied){
        setState(() {
          result="Camera Permission was Denied!";
        });
      }else{
        setState(() {
          result="Unknown Error : $ex";
        });
      }
    } on FormatException{
      setState(() {
        result="You pressed the back button before scanning";
      });
    }
    catch(e){
      setState(() {
        result="Error : $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text("QR Scanner"),
      ),
      body: Center(
        child: Text(
          result,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat ,
      
    );
  }
}