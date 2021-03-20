import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(
        uid: '1',
        nombre: 'Womo',
        email: 'faculazcano14@gmail.com',
        online: true),
    Usuario(
        uid: '2',
        nombre: 'Magandi',
        email: 'faculazcano14@gmail.com',
        online: true),
    Usuario(
        uid: '3',
        nombre: 'Mudo',
        email: 'faculazcano14@gmail.com',
        online: true),
    Usuario(
        uid: '4',
        nombre: 'Pei',
        email: 'faculazcano14@gmail.com',
        online: false),
    Usuario(
        uid: '5',
        nombre: 'Colo',
        email: 'faculazcano14@gmail.com',
        online: true),
  ];
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    final usuario = authServices.usuario;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            usuario.nombre,
            style: TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'login');
              AuthServices.deleteToken();
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.check_circle,
                color: Colors.blue[400],
              ),
              // Icon(
              //   Icons.offline_bolt,
              //   color: Colors.red,
              // ),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          child: listViewUsuarios(),
          header: WaterDropHeader(
            waterDropColor: Colors.blue[400],
            complete: Icon(
              Icons.check,
              color: Colors.blue[400],
            ),
          ),
          enablePullDown: true,
          onRefresh: _cargarUsuarios,
        ));
  }

  ListView listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (usuario.online) ? Colors.green : Colors.red),
      ),
    );
  }

  _cargarUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
