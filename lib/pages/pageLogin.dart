import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DevCLin"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Text("DevCLin"),
              color: Colors.lightGreen,
            )
          ],
        )
        /*  Center(
      child: TextField()),
            Center(
      child: RaisedButton(onPressed: ()=> null),
            )
          */
      ),
    );
  }
}
