import 'package:chat/global/enviroments.dart';
import 'package:chat/models/mensajes_response.dart';
import 'package:chat/services/auth_services.dart';
import 'package:http/http.dart' as http;

import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';

class ChatService with ChangeNotifier {
  Usuario usuarioReceptor;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final res = await http.get('${Enviroments.apiUrl}/mensajes/$usuarioID',
        headers: {
          'Content-Type': 'applications/json',
          'x-token': await AuthServices.getToken()
        });

    final mensajesRes = mensajesResponseFromJson(res.body);

    return mensajesRes.mensajes;
  }
}
