import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vizstore_manager/controllers/product_list_provider.dart';
import 'package:vizstore_manager/product/widgets/products_table.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async => {
      await context.read<ProductListProvider>().getStore()
    });
  }

  @override
  Widget build(BuildContext context) {

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
              child: ProductTable(),
            ),
          ],
        ),
      ),
    );
  }
}





