import 'package:flutter/material.dart';
import 'package:vizstore_manager/controllers/add_product_provider.dart';
import 'package:vizstore_manager/controllers/login_provider.dart';
import 'package:vizstore_manager/controllers/order_details_provider.dart';
import 'package:vizstore_manager/controllers/order_list_provider.dart';
import 'package:vizstore_manager/controllers/product_details_provider.dart';
import 'package:vizstore_manager/controllers/product_list_provider.dart';
import 'package:vizstore_manager/views/login/login.dart';
import 'package:vizstore_manager/repositories/order_repository.dart';
import 'package:vizstore_manager/repositories/product_repository.dart';
import 'package:vizstore_manager/repositories/store_repository.dart';
import 'package:vizstore_manager/themes.dart';
import 'package:provider/provider.dart';
import 'package:vizstore_manager/controllers/side_drawer_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';

import 'repositories/user_repository.dart';

final getIt = GetIt.instance;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions( apiKey: "AIzaSyDuc4Unbjn9eG7hTdKVmM3xhWrBlbvXwuc", appId: "1:878639397378:web:5e98e7870cd02dce67c51b", messagingSenderId: "878639397378", projectId: "ecommerce-135", storageBucket: "ecommerce-135.appspot.com",),);

  getIt.registerSingleton<StoreRepository>(StoreRepository(), instanceName: 'store');
  getIt.registerSingleton<ProductRepository>(ProductRepository(), instanceName: 'product');
  getIt.registerSingleton<OrderRepository>(OrderRepository(), instanceName: 'order');
  getIt.registerSingleton<UserRepository>(UserRepository(), instanceName: 'user');

  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
      create: (_) => SideDrawerProvider(getIt.get(instanceName: 'store')),
    ),
      ChangeNotifierProvider(
        create: (_) => LoginProvider(getIt.get(instanceName: 'store',),
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => ProductListProvider(getIt.get(instanceName: 'store'),getIt.get(instanceName: 'product'),
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => OrderListProvider(getIt.get(instanceName: 'order'),
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => OrderDetailsProvider(getIt.get(instanceName: 'order'),getIt.get(instanceName: 'user'), getIt.get(instanceName: 'product'),
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => AddProductProvider(getIt.get(instanceName: 'store'),getIt.get(instanceName: 'product'),
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => ProductDetailsProvider(getIt.get(instanceName: 'store'),getIt.get(instanceName: 'product'),
        ),
      ),
  ],
    child: const MyApp(),
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      debugShowCheckedModeBanner: false,
      home: Login()
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
