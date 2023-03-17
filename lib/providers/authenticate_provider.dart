import 'dart:async';
import 'package:my_pet_store/imports.dart';
import '../data/shared_preferences.dart';
import '../exceptions/firebase_except.dart';
import 'package:http/http.dart' as http;

class AuthenticateProvider with ChangeNotifier {
  String? _idUser;
  dynamic _token;
  DateTime? _dateExpires;
  Timer? _logout;

  static const _base_url =
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBI5i4q1z8ZypO9z3povlBgK5Fq-WsC5KI";

  bool get getIsAuth {
    return getToken != null;
  }

  String? get idUser {
    return getIsAuth ? _idUser : null;
  }

  String? get getToken {
    if (_token != null &&
        _dateExpires != null &&
        _dateExpires!.isAfter(DateTime.now())) {
      return _token;
    } else {
      return null;
    }
  }

  Future<void> register(email, password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(email, password) async {
    return _authenticate(email, password, "signInWithPassword");
  }

  void logout() {
    _token = null;
    _idUser = null;
    _dateExpires = null;

    if (_logout != null) {
      _logout!.cancel();
      _logout = null;
    }
    Store.remove('userData');

    notifyListeners();
  }

  void _autoLogout() {
    if (_logout != null) {
      _logout!.cancel();
    }

    final timeLogout = _dateExpires!.difference(DateTime.now()).inSeconds;
    _logout = Timer(Duration(seconds: timeLogout), logout);
  }

  Future<void> tryAutoLogin() async {
    if (getIsAuth) {
      return Future.value();
    }

    final userData = await Store.getMap('userData');
    if (userData == null) {
      return Future.value();
    }

    final expiryDate = DateTime.parse(userData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return Future.value();
    }

    _idUser = userData["userId"];
    _token = userData["token"];
    _dateExpires = expiryDate;

    _autoLogout();
    notifyListeners();
    return Future.value();
  }

  Future<void> _authenticate(email, password, urlSegment) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBI5i4q1z8ZypO9z3povlBgK5Fq-WsC5KI");
    final response = await http.post(url,
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));

    final responseBody = json.decode(response.body);
    if (responseBody["error"] != null) {
      throw FireBaseException(responseBody['error']['message']);
    } else {
      _token = responseBody["idToken"];
      _idUser = responseBody['localId'];
      _dateExpires = DateTime.now().add(
        Duration(
          seconds: int.parse(responseBody["expiresIn"]),
        ),
      );
      Store.saveMap('userData', {
        "token": _token,
        "userId": _idUser,
        "expiryDate": _dateExpires!.toIso8601String(),
      });
      _autoLogout();
      notifyListeners();
    }
  }
}
