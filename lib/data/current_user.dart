class CurrentUser {
  final String id;
  final String name;
  final String photoUrl;
  final bool isAnonymous;
  final DateTime createdAt;
  final DateTime updatedAt;

  CurrentUser(this.id, this.name, this.photoUrl, this.isAnonymous,
      this.createdAt, this.updatedAt);
}

CurrentUser getDummyCurrentUser() {
  return CurrentUser(
      "0", "DummyUser", "", true, DateTime.now(), DateTime.now());
}
