class UserProfile {
  String name;
  String email;
  String phone;
  String? profileImageUrl;
  String address;
  DateTime? dateOfBirth;
  String gender;

  UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    this.profileImageUrl,
    this.address = 'House #123, Road #45, Dhanmondi, Dhaka',
    this.dateOfBirth,
    this.gender = 'Male',
  });
}