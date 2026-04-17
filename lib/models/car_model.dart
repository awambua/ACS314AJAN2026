class CarModel {
  String name;
  String year;
  String imageUrl;

  CarModel({required this.name, required this.year, required this.imageUrl});
  // factory CarModel.fromJson(Map<String, dynamic> json) {
  //   return CarModel(
  //     name: json['name'],
  //     year: json['yom'],
  //     imageUrl: json['image'],
  //   );
  // }
}
