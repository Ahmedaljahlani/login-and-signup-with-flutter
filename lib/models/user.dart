class User {
  final String? username;
  final String? email;
  final String? userType;
  final String? profileImageUrl;
  final String? fullName;
  final String? bio;
  final String? phoneNumber;
  final String? address;
  final String? country;
  final String? city;

  User({
    this.username,
    this.email,
    this.userType,
    this.profileImageUrl,
    this.fullName,
    this.bio,
    this.phoneNumber,
    this.address,
    this.country,
    this.city,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['Email'],
      userType: json['user_type'],
      profileImageUrl: json['profile_image_url'],
      fullName: json['full_name'],
      bio: json['bio'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      country: json['country'],
      city: json['city'],
    );
  }
}

// class User {
//   final String? username;
//   final String? email;
//   final String? userType;
//   final String? profileImageUrl;
//
//   User({this.username, this.email, this.userType, this.profileImageUrl});
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       username: json['username'],
//       email: json['Email'],
//       userType: json['user_type'],
//       profileImageUrl: json['profile_image_url'],
//     );
//   }
// }