import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as root_bundle;

import '../model/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
          future: readJsonDatabase(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            } else if (snapshot.hasData) {
              var items = snapshot.data as List<Product>;
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 8,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                child: Image(
                                  image: NetworkImage(items[index].imageUrl),
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'img/image_not_found.jpg',
                                      fit: BoxFit.fill,
                                    );
                                  },
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                              ),
                              flex: 2,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                        right: 8,
                                      ),
                                      child: Text(
                                        items[index].name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                        right: 8,
                                      ),
                                      child: Text(
                                        '\$${items[index].price}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              flex: 6,
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  Future<List<Product>> readJsonDatabase() async {
    final rawData = await root_bundle.rootBundle
        .loadString('assets/data/my_product_json.json');

    final list = json.decode(rawData) as List<dynamic>;

    return list.map((m) => Product.fromJson(m)).toList();
  }
}
