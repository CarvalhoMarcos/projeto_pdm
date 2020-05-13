import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pdm/pages/PageInicial.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevCLin',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _ctrlEmail = TextEditingController();
  TextEditingController _ctrlSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      controller: _ctrlEmail,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
    );
    final passwordField = TextField(
      controller: _ctrlSenha,
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Senha",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
    );
    final buttonLogin = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: RaisedButton(
          color: Colors.lightGreen,
          child: Text(
            "Login",
            textAlign: TextAlign.center,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          onPressed: () => fazerLogin(context)),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(35),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 250, 8, 8),
                child: emailField,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: passwordField,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buttonLogin,
              )
            ],
          ),
        ),
      ),
    );
  }

  fazerLogin(context) async {
    try {
      AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _ctrlEmail.text, password: _ctrlSenha.text);

      if (user.user != null) {
        _ctrlSenha.text = "";

        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => PaginaInicial()));
      } else {}
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Erro de Login"),
              content: SingleChildScrollView(
                child: Text("Verifique se Email ou Senha estão corretos"),
              ),
              actions: <Widget>[
                FlatButton(onPressed: () {
                  Navigator.of(context).pop();
                }, child: Text("ok"))
              ],
            );
          });
    }
  }
}
