import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../models/user_model.dart';
import '../widgets/user_profile_section.dart';
import '../widgets/user_stats.dart';

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
