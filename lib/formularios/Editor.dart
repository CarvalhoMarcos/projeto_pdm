import 'package:flutter/material.dart';

class Editor extends StatefulWidget {
  final TextEditingController _ctrlTexto;
  final String _rotulo, _dica;
  final TextInputType teclado;

  const Editor(this._ctrlTexto, this._rotulo, this._dica, {this.teclado});

  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      controller: widget._ctrlTexto,
      decoration: InputDecoration(
        labelText: widget._rotulo,
        hintText: widget._dica,
      ),
      keyboardType: widget.teclado,
    );
  }
}