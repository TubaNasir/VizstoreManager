import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vizstore_manager/controllers/product_list_provider.dart';
import 'package:vizstore_manager/views/product/widgets/products_table.dart';
import 'package:vizstore_manager/widgets/loader.dart';
import 'package:vizstore_manager/widgets/side_drawer.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) async => {await context.read<ProductListProvider>().getStore()});
  }

  @override
  Widget build(BuildContext context) {

    bool isLoading = context.watch<ProductListProvider>().isLoading;

    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: SideDrawer(),
            ),
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  ProductTable(),
                  if (isLoading)
                    Positioned(
                        top: MediaQuery.of(context).size.height * 0.5,
                        left: MediaQuery.of(context).size.width * 0.35,
                        child: Loader())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
