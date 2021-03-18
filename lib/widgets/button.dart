import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String titulo;
  final Function onPressed;

  const Button({@required this.titulo, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            titulo,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      onPressed: () {
        onPressed();
      },
    );
  }
}
