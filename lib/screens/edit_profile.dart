import 'package:flutter/material.dart';
import 'package:gearandspare_login_signin/models/user.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import 'edit_field.dart';

class EditProfileScreen extends StatelessWidget {
  final User user;

  EditProfileScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        // User user = userProvider.username;
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Profile'),
          ),
          body: ListView(
            children: <Widget>[
              _buildListItem('Username', user.username, context),
              Divider(),
              _buildListItem('Email', user.email, context),
              Divider(),
              _buildListItem('Full Name', user.fullName, context),
              Divider(),
              _buildListItem('Bio', user.bio, context),
              Divider(),
              _buildListItem('Phone Number', user.phoneNumber, context),
              Divider(),
              _buildListItem('Address', user.address, context),
              Divider(),
              _buildListItem('Country', user.country, context),
              Divider(),
              _buildListItem('City', user.city, context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListItem(String label, String? value, BuildContext context) {
    return ListTile(
      leading: Icon(_getLeadingIcon(label)), // Add this line
      title: Text(label),
      subtitle: Text(value ?? ''),
      trailing: IconButton(
        icon: Icon(Icons.edit_outlined),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EditFieldScreen(label: label, value: value)),
          );
        },
      ),
    );
  }

  IconData _getLeadingIcon(String label) {
    switch (label) {
      case 'Username':
        return Icons.person;
      case 'Email':
        return Icons.email;
      case 'Full Name':
        return Icons.account_circle;
      case 'Bio':
        return Icons.info;
      case 'Phone Number':
        return Icons.phone;
      case 'Address':
        return Icons.home;
      case 'Country':
        return Icons.public;
      case 'City':
        return Icons.location_city;
      default:
        return Icons.help;
    }
  }
}