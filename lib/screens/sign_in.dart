import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import 'sign_up.dart';

class SignInPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        _usernameController.text = userProvider.username;
        _passwordController.text = userProvider.password;

        return Scaffold(
          appBar: _buildAppBar(context),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildWelcomeText(),
                      const SizedBox(height: 16.0),
                      _buildUsernameField(userProvider),
                      const SizedBox(height: 12.0),
                      _buildPasswordField(userProvider),
                      SizedBox(height: 4.0),
                      _buildRememberMeAndForgotPassword(userProvider),
                      const SizedBox(height: 16.0),
                      _buildSignInButton(userProvider, context),
                      const SizedBox(height: 16.0),
                      _buildDivider(context),
                      const SizedBox(height: 16.0),
                      _buildGoogleSignInButton(),
                      Container(height: 50), // Replace Spacer with Container
                      _buildSignUpButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWelcomeText() {
    return const Text(
      'Welcome Back!',
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Row _buildRememberMeAndForgotPassword(UserProvider userProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildRememberMeCheckbox(userProvider),
        _buildForgotPasswordButton(),
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width / 2,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('OR'),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Log In'),
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  TextFormField _buildUsernameField(UserProvider userProvider) {
    return TextFormField(
      controller: _usernameController,
      onChanged: userProvider.updateUsername,
      decoration: InputDecoration(
        labelText: 'Username',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0), // adjust the vertical padding here
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your username';
        }
        // if (value.length < 3) {
        //   return 'Username must be at least 3 characters long';
        // }
        return null;
      },
    );
  }

  TextFormField _buildPasswordField(UserProvider userProvider) {
    return TextFormField(
      controller: _passwordController,
      onChanged: userProvider.updatePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        suffixIcon: IconButton(
          icon: Icon(
              userProvider.isObscure ? Icons.visibility : Icons.visibility_off),
          onPressed: userProvider.toggleObscure,
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: 16.0, horizontal: 10), // adjust the vertical padding here
      ),
      obscureText: userProvider.isObscure,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your password';
        }
        // if (value.length < 6) {
        //   return 'Password must be at least 6 characters long';
        // }
        return null;
      },
    );
  }

  Row _buildRememberMeCheckbox(UserProvider userProvider) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: userProvider.rememberMe,
          onChanged: (value) => userProvider.toggleRememberMe(),
        ),
        const Text('Remember me'),
      ],
    );
  }

  ElevatedButton _buildSignInButton(UserProvider userProvider,
      BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        minimumSize: Size(double.infinity, 50),
      ),
      onPressed: userProvider.isLoading
          ? null
          : () async {
        if (_formKey.currentState!.validate()) {
          await _signIn(userProvider, context);
        }
      },
      child: userProvider.isLoading
          ? CircularProgressIndicator()
          : Text('Sign In'),
    );
  }

  Future<void> _signIn(UserProvider userProvider, BuildContext context) async {
    userProvider.toggleLoading();
    try {
      await userProvider.signIn(userProvider.username, userProvider.password);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
            Text('Successfully logged in as ${userProvider.username}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      userProvider.toggleLoading();
    }
  }

  TextButton _buildSignUpButton(BuildContext context) {
    return TextButton(
      onPressed: () =>
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpPage())),
      child: const Text('Create an account'),
    );
  }

  TextButton _buildForgotPasswordButton() {
    return TextButton(
      onPressed: () {}, // Navigate to Forgot Password page
      child: const Text('Forgot password?'),
    );
  }

  OutlinedButton _buildGoogleSignInButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        primary: Colors.red,
        minimumSize: Size(double.infinity, 50),
      ),
      onPressed: () {},
      child: Text('Sign In with Google'),
    );
  }
}
