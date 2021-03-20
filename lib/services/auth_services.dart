import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:chat/models/usuario.dart';
import 'package:chat/global/enviroments.dart';
import 'package:chat/models/login_response.dart';

class AuthServices with ChangeNotifier {
  Usuario usuario;
  bool _autenticando = false;

  // Create storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool value) {
    this._autenticando = value;
    notifyListeners();
  }

  // getters estaticos del token

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    this.autenticando = true;

    final data = {'email': email, 'password': password};

    final res = await http.post('${Enviroments.apiUrl}/login',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    this.autenticando = false;

    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    this.autenticando = true;

    final data = {'nombre': nombre, 'email': email, 'password': password};

    final res = await http.post('${Enviroments.apiUrl}/login/new',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    this.autenticando = false;

    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      final resbody = jsonDecode(res.body);
      return resbody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');
    final res = await http.get('${Enviroments.apiUrl}/login/renew',
        headers: {'Content-Type': 'application/json', 'x-token': token});

    if (res.statusCode == 200) {
      final loginResponse = loginResponseFromJson(res.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    // Write value
    await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    // Write value
    await _storage.delete(key: 'token');
  }
}
