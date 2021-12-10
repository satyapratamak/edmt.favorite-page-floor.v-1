import 'package:floor/floor.dart';

@entity
class FavoriteProduct {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String? uid, name, imageUrl;

  FavoriteProduct(
      {this.id, required this.uid, required this.name, required this.imageUrl});
}
