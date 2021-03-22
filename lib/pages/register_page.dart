import 'package:chat/helpers/showAlert.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/socket_services.dart';
import 'package:chat/widgets/button.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/input.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Logo('Registro'),
                    _Form(),
                    Labels(
                      registro: true,
                      texto1: '¿Ya tienes cuenta?',
                      texto2: 'Logeate!',
                    ),
                    Text(
                      'Términos y condiciones de uso',
                      style: TextStyle(fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    final socketService = Provider.of<SocketService>(context);

    final nameController = new TextEditingController();
    final textController = new TextEditingController();
    final passController = new TextEditingController();
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          Input(
            icon: Icons.person_outline,
            textController: nameController,
            placeholder: 'Name',
          ),
          Input(
            icon: Icons.email_outlined,
            textController: textController,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          Input(
            textController: passController,
            placeholder: 'Password',
            icon: Icons.lock_outline,
            isPassword: true,
          ),
          Button(
            titulo: 'Crear Cuenta',
            onPressed: authServices.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final registroOk = await authServices.register(
                        nameController.text,
                        textController.text.trim(),
                        passController.text.trim());

                    if (registroOk == true) {
                      socketService.connect();
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      mostrarAlerta(context, 'Registro Incorrecto', registroOk);
                    }
                  },
          )
        ],
      ),
    );
  }
}
