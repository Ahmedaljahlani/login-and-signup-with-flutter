import 'package:flutter/material.dart';
import 'package:gearandspare_login_signin/screens/sign_in.dart';
import 'package:gearandspare_login_signin/screens/user_dashboard.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        if (userProvider.isSignedIn) {
          return UserDashboard(
            username: userProvider.username,
          ); // Show the dashboard if the user is signed in
        } else {
          return SignInPage(); // Show the sign-in page if the user is not signed in
        }
      },
    );
  }
}

// class UserDashboard extends StatefulWidget {
//   final String username;
//
//   UserDashboard({required this.username});
//
//   @override
//   _UserDashboardState createState() => _UserDashboardState();
// }
//
// class _UserDashboardState extends State<UserDashboard> {
//   late Future<User> futureUser;
//
//   @override
//   void initState() {
//     super.initState();
//     futureUser = fetchUser(widget.username);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Dashboard'),
//       ),
//       body: FutureBuilder<User>(
//         future: futureUser,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   Stack(
//                     clipBehavior: Clip.none,
//                     children: <Widget>[
//                       Container(
//                         height: 200,
//                         decoration: BoxDecoration(
//                           color: Colors.blue,
//                           image: DecorationImage(
//                             image: AssetImage('assets/images/bg.jpg'),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         left: 0,
//                         right: 0,
//                         bottom: -50, // Half the height of the CircleAvatar
//                         child: Container(
//                           width: 100,
//                           height: 100,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.green.shade400,
//                             image: DecorationImage(
//                               image: NetworkImage(
//                                   '${snapshot.data!.profileImageUrl}'),
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 100),
//                   // Adjust this value to make room for the profile image
//                   Text(
//                     '${snapshot.data!.username}',
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blueGrey,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     '${snapshot.data!.email}',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'User Type: ${snapshot.data!.userType}',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   // Add more widgets here to display more user data
//                   Card(
//                     margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             child: Column(
//                               children: <Widget>[
//                                 Text(
//                                   "Posts",
//                                   style: TextStyle(
//                                     color: Colors.redAccent,
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   "520",
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.purpleAccent,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             child: Column(
//                               children: <Widget>[
//                                 Text(
//                                   "Followers",
//                                   style: TextStyle(
//                                     color: Colors.redAccent,
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   "28.5K",
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.purpleAccent,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             child: Column(
//                               children: <Widget>[
//                                 Text(
//                                   "Following",
//                                   style: TextStyle(
//                                     color: Colors.redAccent,
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   "134",
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.purpleAccent,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // Placeholder for future widgets
//                   Container(
//                     height: 200,
//                     color: Colors.grey[200],
//                     child: Center(child: Text('Future widget placeholder')),
//                   ),
//                 ],
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Center(child: Text("${snapshot.error}"));
//           }
//           return Center(child: CircularProgressIndicator());
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Call the signOut method
//           Provider.of<UserProvider>(context, listen: false).signOut();
//         },
//         child: Icon(Icons.logout),
//       ),
//     );
//   }
// }
//
// Future<User> fetchUser(String username) async {
//   final response = await http.get(Uri.parse(
//       'http://192.168.1.102/gearandspare/users.php?username=$username'));
//
//   if (response.statusCode == 200) {
//     print(response.body);
//     return User.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load user');
//   }
// }


//
// class UserDashboard extends StatelessWidget {
//   const UserDashboard({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('You\'ve Logged In'),
//             ElevatedButton(
//               onPressed: () {
//                 // Call the signOut method
//                 Provider.of<UserProvider>(context, listen: false).signOut();
//               },
//               child: Text('Sign Out'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
