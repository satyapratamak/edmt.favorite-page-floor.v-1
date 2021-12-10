// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorFavoriteProductDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FavoriteProductDatabaseBuilder databaseBuilder(String name) =>
      _$FavoriteProductDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FavoriteProductDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$FavoriteProductDatabaseBuilder(null);
}

class _$FavoriteProductDatabaseBuilder {
  _$FavoriteProductDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$FavoriteProductDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FavoriteProductDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FavoriteProductDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$FavoriteProductDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FavoriteProductDatabase extends FavoriteProductDatabase {
  _$FavoriteProductDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FavoriteProductDAO? _favorite_product_daoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FavoriteProduct` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `uid` TEXT, `name` TEXT, `imageUrl` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FavoriteProductDAO get favorite_product_dao {
    return _favorite_product_daoInstance ??=
        _$FavoriteProductDAO(database, changeListener);
  }
}

class _$FavoriteProductDAO extends FavoriteProductDAO {
  _$FavoriteProductDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _favoriteProductInsertionAdapter = InsertionAdapter(
            database,
            'FavoriteProduct',
            (FavoriteProduct item) => <String, Object?>{
                  'id': item.id,
                  'uid': item.uid,
                  'name': item.name,
                  'imageUrl': item.imageUrl
                }),
        _favoriteProductDeletionAdapter = DeletionAdapter(
            database,
            'FavoriteProduct',
            ['id'],
            (FavoriteProduct item) => <String, Object?>{
                  'id': item.id,
                  'uid': item.uid,
                  'name': item.name,
                  'imageUrl': item.imageUrl
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FavoriteProduct> _favoriteProductInsertionAdapter;

  final DeletionAdapter<FavoriteProduct> _favoriteProductDeletionAdapter;

  @override
  Future<FavoriteProduct?> getFavInFavByUid(String uid, int id) async {
    return _queryAdapter.query(
        'SELECT * FROM FavoriteProduct WHERE uid=?1 AND id=?2',
        mapper: (Map<String, Object?> row) => FavoriteProduct(
            id: row['id'] as int?,
            uid: row['uid'] as String?,
            name: row['name'] as String?,
            imageUrl: row['imageUrl'] as String?),
        arguments: [uid, id]);
  }

  @override
  Future<void> insertFav(FavoriteProduct product) async {
    await _favoriteProductInsertionAdapter.insert(
        product, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteFav(FavoriteProduct product) {
    return _favoriteProductDeletionAdapter.deleteAndReturnChangedRows(product);
  }
}
