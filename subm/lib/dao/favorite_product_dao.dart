import 'package:floor/floor.dart';
import '../entity/favorite_product.dart';

@dao
abstract class FavoriteProductDAO {
  @Query('SELECT * FROM FavoriteProduct WHERE uid=:uid AND id=:id')
  Future<FavoriteProduct?> getFavInFavByUid(String uid, int id);

  @insert
  Future<void> insertFav(FavoriteProduct product);

  @delete
  Future<int> deleteFav(FavoriteProduct product);
}
