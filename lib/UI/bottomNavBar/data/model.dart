class Model {
  final int id;
  final String imagePath;
  final String name;

  Model({
    this.id,
    this.imagePath,
    this.name,
  });
}

List<Model> navBtn = [
  Model(id: 0, imagePath: 'assets/icons/home.png', name: 'Home'),
  Model(id: 1, imagePath: 'assets/icons/search.png', name: 'Search'),
  Model(id: 4, imagePath: 'assets/icons/user.png', name: 'Profile'),
];