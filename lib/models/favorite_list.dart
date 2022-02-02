import 'package:my_street_vendor/models/favorite_model.dart';

class FavoriteList{
  List<FavoriteModel>? favorite;

  FavoriteList({this.favorite});

  factory FavoriteList.fromJson(List<dynamic> parsedJson) {

    List<FavoriteModel> fav =  <FavoriteModel>[];

    fav = parsedJson.map((i)=>FavoriteModel.fromJson(i)).toList();

    return FavoriteList(
      favorite: fav
    );

  }
}