import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String texto1;
  final String texto2;
  final bool registro;

  const Labels(
      {@required this.texto1, @required this.texto2, this.registro = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            texto1,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, (registro) ? 'login' : 'register');
            },
            child: Text(
              texto2,
              style: TextStyle(
                  color: Colors.blue[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
