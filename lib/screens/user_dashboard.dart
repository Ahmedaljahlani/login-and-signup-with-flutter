import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../models/user_model.dart';

class UserDashboard extends StatelessWidget {
  final String username;

  const UserDashboard({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    return ValueListenableBuilder(
      valueListenable: userProvider.refreshNotifier,
      builder: (context, value, child) {
        return FutureBuilder<User>(
          future: userProvider.fetchUser(username),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return ErrorScreen(
                errorMessage: 'Failed to load user data',
                onRetry: () {
                  userProvider.refreshNotifier.value++;
                },
              );
            } else {
              return _buildUserDashboard(context, snapshot.data!);
            }
          },
        );
      },
    );
  }

  Widget _buildUserDashboard(BuildContext context, User user) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            UserProfileSection(user: user),
            StatsCard(),
            FutureWidgetPlaceholder(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: Provider.of<UserProvider>(context, listen: false).signOut,
        child: Icon(Icons.logout),
      ),
    );
  }
}

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
              : AssetImage('assets/images/user_avatar.png') as ImageProvider<Object>, // replace with your placeholder image path
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
}

class StatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            _buildStatColumn("Posts", "520"),
            _buildStatColumn("Followers", "28.5K"),
            _buildStatColumn("Following", "134"),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String title, String value) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              color: Colors.purpleAccent,
            ),
          ),
        ],
      ),
    );
  }
}

class FutureWidgetPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.grey[200],
      child: Center(child: Text('Future widget placeholder')),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  ErrorScreen({required this.errorMessage, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(errorMessage),
          ElevatedButton(
            onPressed: onRetry,
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }
}
