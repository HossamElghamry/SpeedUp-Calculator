import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SpeedUp Calculator",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.white,
      ),
      home: MyHomePage(title: 'SpeedUp Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _amdahl = 0.0;
  var _gustfson = 0.0;
  var _sp = 0.0;
  var _n = 0;

  void _dialog(){
    showDialog(context: context, 
    builder: (_)=> AlertDialog(
          title: new Text("Parallel Algorithms"),
          content: new Text("Calculator for measuring\n\n1- Amdahl's law speedup\n\n2- Gustafson's law speed latency"
          ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
        )   
      );
    }

    void _dialogHTU(){
    showDialog(context: context, 
    builder: (_)=> AlertDialog(
          title: new Text("How to Use SpeedUp Cal"),
          content: new Text("1- Enter the desired serial portion as a percentage\n2- Enter the desired number of processors\n3- Be sure to tap enter after inputting value\n4- Tap on the button at the bottom right to evaluate"
          ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
        )   
      );
    }
  
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }

  void _calculate() {
    var _a =  1.0/((_sp/100.0)+((1.0-(_sp/100.0))/_n));
    var _g =   _n*(1.0-(_sp/100.0))+(_sp/100.0);
    setState(() {
      _amdahl = _a;
      _gustfson = _g;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child:ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text("Hossam Elghamry / Salah El-Sheikh"),
              accountEmail: Text("CSCI 311: Computer Arch. Project"),
            ),
          ListTile(title: Text("How to Use"),trailing: Icon(Icons.touch_app),onTap: ()=>_dialogHTU()),
          Divider(height: 10,),
          ListTile(title: Text("About"),trailing: Icon(Icons.accessibility),onTap: ()=>_dialog())
        ],
      ),),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          
          children: <Widget>[
            Text(
              'Amdahl\'s Law Speedup\n${_amdahl.toStringAsFixed(3)}',
              textAlign:TextAlign.center,
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)
            ),
            Text(
              '\nGustafson\'s Law Speed Latency\n${_gustfson.toStringAsFixed(3)}',
              textAlign:TextAlign.center,
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)
            ),
            TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                labelStyle: TextStyle(color: Colors.white,fontSize: 14),
                labelText: "Serial Portion Percentage"
              ),
              keyboardType: TextInputType.number,
              onFieldSubmitted: (String d){
                setState(() {
                      _sp = double.parse(d);          
                });
              },
            ),
            TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                labelStyle: TextStyle(color: Colors.white,fontSize: 14),
                labelText: "Number of Processors"
              ),
              keyboardType: TextInputType.number,
              onFieldSubmitted: (String d){
                setState(() {
                      _n = int.parse(d);          
                });
              },
            ),
           Text("Press enter on the keyboard\nto enter each desired value",textAlign: TextAlign.center,
           style: TextStyle(color: Colors.white, fontSize: 11),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> _calculate(),
        tooltip: 'Calculate',
        child: Icon(Icons.equalizer),
      ), 
    );
  }
}
