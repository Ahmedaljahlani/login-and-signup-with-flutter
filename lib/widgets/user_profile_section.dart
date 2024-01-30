import 'package:flutter/material.dart';

import '../models/user.dart';
import '../screens/edit_profile.dart';

  class UserProfileSection extends StatelessWidget {
    final User user;

    UserProfileSection({required this.user});

    @override
    Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildProfileImage(),
          const SizedBox(height: 50),
          _buildUserInfo(),
          const SizedBox(height: 20),
          _buildEditProfileButton(context), // Add this line
        ],
      );
    }

    Widget _buildProfileImage() {
      return Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            height: 120,
            margin: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 32,
            bottom: -50,
            child: _buildUserAvatar(),
          ),
        ],
      );
    }

    Widget _buildUserAvatar() {
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue.shade400,
          image: DecorationImage(
            image: user.profileImageUrl != null
                ? NetworkImage('${user.profileImageUrl}') as ImageProvider<Object>
                : AssetImage('assets/images/user_avatar.png') as ImageProvider<
                    Object>, // replace with your placeholder image path
            fit: BoxFit.contain,
          ),
          border: Border.all(
            color: Colors.white,
            width: 3.0,
          ),
        ),
      );
    }

    Widget _buildUserInfo() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildUserDetails(),
        ),
      );
    }

    List<Widget> _buildUserDetails() {
      return [
        if (user.username != null)
          _buildUserDetail(
              '${user.username}', Colors.blueGrey, 24, FontWeight.bold),
        if (user.email != null)
          _buildUserDetail('${user.email}', Colors.grey[600]!, 16),
        if (user.fullName != null)
          _buildUserDetail('${user.fullName}', Colors.grey[600]!, 16),
        if (user.bio != null)
          _buildUserDetail('${user.bio}', Colors.grey[600]!, 16),
        if (user.phoneNumber != null)
          _buildUserDetail('${user.phoneNumber}', Colors.grey[600]!, 16),
        if (user.address != null)
          _buildUserDetail('${user.address}', Colors.grey[600]!, 16),
        if (user.country != null)
          _buildUserDetail('${user.country}', Colors.grey[600]!, 16),
        if (user.city != null)
          _buildUserDetail('${user.city}', Colors.grey[600]!, 16),
      ];
    }

    Widget _buildUserDetail(String text, Color color, double fontSize,
        [FontWeight fontWeight = FontWeight.normal]) {
      return Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      );
    }

    Widget _buildEditProfileButton(BuildContext context) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.all(0.0),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            elevation: MaterialStateProperty.all(2.0),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return Color(0xFF1877F2); // Facebook blue color when the button is pressed
                return Color(0xFF1877F2); // Facebook blue color as the default color
              },
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfileScreen(
                  user: user,
                ),
              ),
            );
          },
          child: Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

// Widget _buildUserAvatar() {
//   return Container(
//     width: 100,
//     height: 100,
//     decoration: BoxDecoration(
//       shape: BoxShape.circle,
//       color: Colors.green.shade400,
//       image: DecorationImage(
//         image: NetworkImage('${user.profileImageUrl}'),
//         fit: BoxFit.contain,
//       ),
//       border: Border.all(
//         color: Colors.white,
//         width: 3.0,
//       ),
//     ),
//   );
// }
