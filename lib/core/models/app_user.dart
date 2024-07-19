class AppUser {
  final String id;
  final String name;
  final String email;
  final String exclusiveCode;
  final String permissionType;
  final String imageURL;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.exclusiveCode,
    required this.permissionType,
    required this.imageURL,
  });
}