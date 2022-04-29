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
  Model(id: 1, imagePath: 'assets/icons/favorite.png', name: 'Favorite'),
  Model(id: 2, imagePath: 'assets/icons/destination.png', name: 'Travel'),
  Model(id: 3, imagePath: 'assets/icons/planner.png', name: 'MyTrip'),

];