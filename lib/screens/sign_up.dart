import 'package:flutter/material.dart';
import 'package:gearandspare_login_signin/main.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';

class SignUpPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: <Widget>[
                _buildTextFormField(
                  controller: _fullNameController,
                  labelText: 'Full Name',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your full name' : null,
                  onChanged: userProvider.updateFullName,
                ),
                _buildTextFormField(
                  controller: _usernameController,
                  labelText: 'Username',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your username' : null,
                  onChanged: userProvider.updateUsername,
                ),
                _buildTextFormField(
                  controller: _passwordController,
                  labelText: 'Password',
                  obscureText: true,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your password' : null,
                  onChanged: userProvider.updatePassword,
                ),
                _buildTextFormField(
                  controller: _confirmPasswordController,
                  labelText: 'Confirm Password',
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) return 'Please confirm your password';
                    if (value != _passwordController.text)
                      return 'Passwords do not match';
                    return null;
                  },
                  onChanged: (String) {},
                ),
                _buildTextFormField(
                  controller: _emailController,
                  labelText: 'Email',
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter your email';
                    if (!value.contains('@'))
                      return 'Please enter a valid email';
                    return null;
                  },
                  onChanged: userProvider.updateEmail,
                ),
                SizedBox(
                  height: 16.0,
                ),
                _buildSignUpButton(userProvider, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?) validator,
    required void Function(String) onChanged,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
          contentPadding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 10.0), // adjust the vertical padding here
        ),
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }

  Widget _buildSignUpButton(UserProvider userProvider, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
          onPrimary: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          minimumSize: Size(double.infinity, 50),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            userProvider.toggleLoading();
            try {
              await userProvider.signUp(
                _usernameController.text,
                _passwordController.text,
                _emailController.text,
                userProvider.userRole,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Successfully signed up')),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.toString())),
              );
            }
            userProvider.toggleLoading();
          }
        },
        child: userProvider.isLoading
            ? CircularProgressIndicator()
            : Text('Sign Up'),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////
// class SignUpPage extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   final _emailController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     var userProvider = Provider.of<UserProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Sign Up')),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             child: Column(
//               children: <Widget>[
//                 _buildRoleButtons(userProvider),
//                 _buildTextFormField(
//                   controller: _usernameController,
//                   labelText: 'Username',
//                   validator: (value) =>
//                       value!.isEmpty ? 'Please enter your username' : null,
//                   onChanged: userProvider.updateUsername,
//                 ),
//                 _buildTextFormField(
//                   controller: _passwordController,
//                   labelText: 'Password',
//                   obscureText: true,
//                   validator: (value) =>
//                       value!.isEmpty ? 'Please enter your password' : null,
//                   onChanged: userProvider.updatePassword,
//                 ),
//                 _buildTextFormField(
//                   controller: _confirmPasswordController,
//                   labelText: 'Confirm Password',
//                   obscureText: true,
//                   validator: (value) {
//                     if (value!.isEmpty) return 'Please confirm your password';
//                     if (value != _passwordController.text)
//                       return 'Passwords do not match';
//                     return null;
//                   },
//                   onChanged: (String) {},
//                 ),
//                 _buildTextFormField(
//                   controller: _emailController,
//                   labelText: 'Email',
//                   validator: (value) {
//                     if (value!.isEmpty) return 'Please enter your email';
//                     if (!value.contains('@'))
//                       return 'Please enter a valid email';
//                     return null;
//                   },
//                   onChanged: userProvider.updateEmail,
//                 ),
//                 SizedBox(
//                   height: 16.0,
//                 ),
//                 _buildSignUpButton(userProvider, context),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRoleButtons(UserProvider userProvider) {
//     return IntrinsicWidth(
//       child: Container(
//         height: 40,
//         padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             RoleButton(
//               role: 'Buyer',
//               isSelected: userProvider.userRole == 'Buyer',
//               onSelect: () => userProvider.updateUserRole('Buyer'),
//             ),
//             SizedBox(width: 4),
//             RoleButton(
//               role: 'Seller',
//               isSelected: userProvider.userRole == 'Seller',
//               onSelect: () => userProvider.updateUserRole('Seller'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextFormField({
//     required TextEditingController controller,
//     required String labelText,
//     required String? Function(String?) validator,
//     required void Function(String) onChanged,
//     bool obscureText = false,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: TextFormField(
//         controller: controller,
//         onChanged: onChanged,
//         decoration: InputDecoration(
//           labelText: labelText,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
//           contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0), // adjust the vertical padding here
//         ),
//         obscureText: obscureText,
//         validator: validator,
//       ),
//     );
//   }
//
//   Widget _buildSignUpButton(UserProvider userProvider, BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 16.0),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           primary: Colors.red,
//           onPrimary: Colors.white,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//           minimumSize: Size(double.infinity, 50),
//         ),
//         onPressed: () async {
//           if (_formKey.currentState!.validate()) {
//             if (userProvider.userRole.isEmpty) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Please select a role')),
//               );
//               return;
//             }
//             userProvider.toggleLoading();
//             try {
//               await userProvider.signUp(
//                 _usernameController.text,
//                 _passwordController.text,
//                 _emailController.text,
//                 userProvider.userRole,
//               );
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Successfully signed up')),
//               );
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => MyApp()),
//               );
//             } catch (e) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text(e.toString())),
//               );
//             }
//             userProvider.toggleLoading();
//           }
//         },
//         child: userProvider.isLoading
//             ? CircularProgressIndicator()
//             : Text('Sign Up'),
//       ),
//     );
//   }
// }
//
// class RoleButton extends StatelessWidget {
//   final String role;
//   final bool isSelected;
//   final VoidCallback onSelect;
//
//   RoleButton({
//     required this.role,
//     required this.isSelected,
//     required this.onSelect,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Tooltip(
//       message: role == 'Buyer'
//           ? 'Buy products on our platform'
//           : 'Sell products on our platform',
//       child: SizedBox(
//         width: 100, // Adjust this value as needed
//         child: isSelected
//             ? ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                   primary: Colors.blue,
//                 ),
//                 onPressed: onSelect,
//                 child: Text(
//                   role,
//                   style: TextStyle(color: Colors.white),
//                 ),
//               )
//             : GestureDetector(
//                 onTap: onSelect,
//                 child: Center(
//                   child: Text(
//                     role,
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }
