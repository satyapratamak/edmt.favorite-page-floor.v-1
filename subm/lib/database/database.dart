import 'package:floor/floor.dart';
import 'package:subm/dao/favorite_product_dao.dart';

import '../entity/favorite_product.dart';

// import needed
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [FavoriteProduct])
abstract class FavoriteProductDatabase extends FloorDatabase {
  FavoriteProductDAO get favorite_product_dao;
}
