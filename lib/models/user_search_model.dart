class MyUsers {
  final String name;
  final String userName;
  final String imageAd;
  bool isFollowed;

  MyUsers(this.name, this.userName, this.imageAd, this.isFollowed);
}

List<MyUsers> listOfUsers = [
  MyUsers("Wentworth Miller", "@Miller", "assets/images/wentworth.jpg", false),
  MyUsers("Dominic Purcellr", "@Purcellr", "assets/images/Dominic.png", false),
  MyUsers("Amaury Nolasco", "@Nolasco", "assets/images/Nolasco.jpg", false),
  MyUsers("Sarah Wayne Callies", "@Callies", "assets/images/sara.jpg", false),
  MyUsers("Robert Knepper", "@Knepper", "assets/images/robert.jpg", false),
  MyUsers("Paul Adelstein", "@Adelstein", "assets/images/adel.jpg", false),
  MyUsers("Rockmond Dunbar", "@Dunbar", "assets/images/Rockmond.png", false),
  MyUsers("Wade Williams", "@Williams", "assets/images/wade.jpg", false),
  MyUsers("Jodi Lyn O'Keefe", "@OKeefe", "assets/images/jody.jpg", false),
  MyUsers("William Fichtner", "@Fichtner", "assets/images/wiliam.jpg", false),
];