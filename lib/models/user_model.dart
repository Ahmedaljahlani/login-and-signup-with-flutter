import 'dart:convert';
import 'package:gearandspare_login_signin/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

// Define constants
const String signInUrl = 'http://192.168.1.103/gearandspare/signin.php';
const String signUpUrl = 'http://192.168.1.103/gearandspare/signup.php';

class UserProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  String _fullname = '';
  String _username = '';
  String _password = '';
  String _email = '';
  String _bio = '';
  String _phoneNumber = '';
  String _address = '';
  String _country = '';
  String _city = '';
  String _userRole = 'Buyer';
  bool _isObscure = true;
  bool _rememberMe = false;
  bool _isLoading = false;
  final ValueNotifier<int> refreshNotifier = ValueNotifier(0);

  UserProvider() {
    _loadLoginState();
  }

  bool get isSignedIn => _isSignedIn;

  String get fullname => _fullname;

  String get username => _username;

  String get password => _password;

  String get email => _email;

  String get bio => _bio;

  String get phoneNumber => _phoneNumber;

  String get address => _address;

  String get country => _country;

  String get city => _city;

  String get userRole => _userRole;

  bool get isObscure => _isObscure;

  bool get rememberMe => _rememberMe;

  bool get isLoading => _isLoading;

  void updateUserRole(String role) {
    _userRole = role;
    notifyListeners();
  }

  void toggleSignIn() {
    _isSignedIn = !_isSignedIn;
    notifyListeners();
  }

  void updateFullName(String fullname) {
    _fullname = fullname;
  }

  void updateUsername(String username) {
    _username = username;
  }

  void updatePassword(String password) {
    _password = password;
  }

  void updateEmail(String email) {
    _email = email;
  }

  void updateBio(String bio) {
    _bio = bio;
  }

  void updatePhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
  }

  void updateAddress(String address) {
    _address = address;
  }

  void updateCountry(String country) {
    _country = country;
  }

  void updateCity(String city) {
    _city = city;
  }

  void toggleObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  void toggleRememberMe() {
    _rememberMe = !_rememberMe;
    notifyListeners();
  }

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  Future<User> fetchUser(String username) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.103/gearandspare/users.php?username=$username'));

    if (response.statusCode == 200) {
      print(response.body);
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<void> signIn(String username, String password) async {
    toggleLoading();
    try {
      final response = await http.post(
        Uri.parse(signInUrl),
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['error'] != null) {
          throw Exception(data['error']);
        } else {
          _isSignedIn = true;
          _username = username;
          _password = password;
          notifyListeners();

          // Save the login state and user data only if "Remember me" is checked
          if (_rememberMe) {
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool('isSignedIn', true);
            prefs.setString('username', username);
            prefs.setString('password', password);
          }
        }
      } else {
        throw Exception('Failed to sign in');
      }
    } catch (e) {
      throw e;
    } finally {
      toggleLoading();
    }
  }

  Future<void> signUp(String fullname, String username, String password,
      String email, String role) async {
    final response = await http.post(
      Uri.parse(signUpUrl),
      body: {
        'full_name': fullname,
        'username': username,
        'password': password,
        'email': email,
        'role': role,
      },
    );

    print('full name is: $fullname');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['error'] != null) {
        throw Exception(data['error']);
      } else {
        _fullname = fullname;
        _username = username;
        _password = password;
        _email = email;
        _userRole = role;
        notifyListeners();
      }
    } else {
      throw Exception('Failed to sign up');
    }
  }

  Future<void> updateProfile(String field, String value) async {
    const String updateProfileUrl =
        'http://192.168.1.103/gearandspare/edit_profile.php';
    toggleLoading();
    try {
      final response = await http.post(
        Uri.parse(updateProfileUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'username': _username,
          field: value,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['error'] != null) {
          throw Exception(data['error']);
        } else {
          notifyListeners();
        }
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      print('Error updating profile: $e');
    } finally {
      toggleLoading();
    }
  }



  void _loadLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    _isSignedIn = prefs.getBool('isSignedIn') ?? false;
    if (_isSignedIn) {
      _username = prefs.getString('username') ?? '';
      _password = prefs.getString('password') ?? '';
    }
    notifyListeners();
  }

  void signOut() {
    _isSignedIn = false;
    _username = '';
    _password = '';
    _email = '';
    _userRole = '';

    // Clear the login state and user data
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('isSignedIn');
      prefs.remove('username');
      prefs.remove('password');
    });

    notifyListeners();
  }
}







// Future<void> signUp(
//     String username, String password, String email, String role) async {
//   final response = await http.post(
//     Uri.parse(signUpUrl),
//     body: {
//       'username': username,
//       'password': password,
//       'email': email,
//       'role': role,
//     },
//   );
//
//   if (response.statusCode == 200) {
//     var data = jsonDecode(response.body);
//     if (data['error'] != null) {
//       throw Exception(data['error']);
//     } else {
//       _isSignedIn = true;
//       _username = username;
//       _password = password;
//       _email = email;
//       _userRole = role;
//       notifyListeners();
//     }
//   } else {
//     throw Exception('Failed to sign up');
//   }
// }