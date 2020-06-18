import 'package:flutter/material.dart';
import 'package:projeto_pdm/pages/PageConsulta.dart';
import 'package:projeto_pdm/pages/PageMedico.dart';
import 'package:projeto_pdm/pages/PagePaciente.dart';
import 'package:projeto_pdm/pages/pageCobertura.dart';
import 'package:projeto_pdm/pages/pageEspecialidade.dart';
import 'package:projeto_pdm/pages/pageTipoPagamento.dart';

class PaginaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DevClin"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Image.asset("assets/plano.png",width: 25,height: 25,),
              title: Text("Coberturas"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListaCoberturas(),
                    ));
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Image.asset("assets/organization.png",width: 25,height: 25,),
              title: Text("Especialidades"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListaEspecialidades(),
                    ));
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Image.asset("assets/money.png",width: 25,height: 25,),
              title: Text("Formas de Pagamento"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormasPagamento(),
                    ));
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Image.asset("assets/doctor.png",width: 25,height: 25,),
              title: Text("Médicos"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListaMedicos(),
                    ));
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Image.asset("assets/group.png",width: 25,height: 25,),
              title: Text("Pacientes"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListaPacientes(),
                    ));
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Image.asset("assets/consultation.png",width: 25,height: 25,),
              title: Text("Consultas"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListaConsultas(),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}

/*
          Card(
            child: ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Paciente"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Intermedio("Pacientes", FormularioPaciente()),
                  ),
                );
              },
            ),
          )
*/
