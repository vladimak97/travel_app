class PlaceModel {

  PlaceModel({
    this.name,
    this.image,
    this.date,
    this.price,
    this.about,
  });

  String? name;
  String? image;
  String? date;
  int? price;
  String? about;

  // tworzy instancję place_model na podstawie danych w JSON

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(

    name: json["name"],
    image: json["image"],
    date: json["date"],
    price: json["price"],
    about: json["about"],
  );

  get rating => null;

}
