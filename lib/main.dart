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
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(70),
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(75)),
                ),
                child: SizedBox(
                  width: 128,
                  height: 128,
                  child: Image.asset("assets/hospital.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  "Bem vindo a Dev-Clin",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 50, 35, 8),
                child: emailField,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 5, 35, 8),
                child: passwordField,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(75, 10, 75, 8),
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
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("ok"))
              ],
            );
          });
    }
  }
}
