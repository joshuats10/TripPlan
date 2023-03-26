class TouristAttraction {
  String id;
  double latitude;
  double longitude;
  String name;
  String photo;

  TouristAttraction(
      this.id, this.latitude, this.longitude, this.name, this.photo);
}

///　北海道の名所
final tourist_attractions = [
  TouristAttraction('1', 43.0779575, 141.337819, '北海道大学', 'dummy'),
  TouristAttraction('2', 43.0692162, 141.3473406, '175°DENO坦々麺札幌駅北口店', 'dummy'),
  TouristAttraction('3', 43.05432, 141.3517185, 'UTAGE SAPPORO', 'dummy'),
  TouristAttraction('4', 43.0673817, 141.3416878, 'ラーメン二郎札幌店', 'dummy'),
  TouristAttraction('5', 43.072069, 141.331253, '焼肉と料理シルクロード', 'dummy'),
];
