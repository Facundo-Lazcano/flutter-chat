import 'package:chat/global/enviroments.dart';
import 'package:chat/models/usuarios_response.dart';
import 'package:chat/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:chat/models/usuario.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final res = await http.get('${Enviroments.apiUrl}/usuarios', headers: {
        'Content-Type': 'applications/json',
        'x-token': await AuthServices.getToken()
      });

      final usuariosResponse = usuariosResponseFromJson(res.body);
      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
