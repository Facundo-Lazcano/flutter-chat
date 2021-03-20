import 'package:chat/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: checkLoginState(context),
            builder: (context, snapshot) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthServices>(context, listen: false);

    final autenticado = await authService.isLoggedIn();
    if (autenticado) {
      Navigator.pushReplacementNamed(context, 'usuarios');
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
