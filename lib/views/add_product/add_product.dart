import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:vizstore_manager/controllers/add_product_provider.dart';
import 'package:vizstore_manager/views/add_product/widgets/add_product_form.dart';
import 'package:vizstore_manager/widgets/header.dart';
import 'package:vizstore_manager/widgets/side_drawer.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => {
          context.read<AddProductProvider>().getUser(),
        });
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

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
              child: Column(
                children: [
                  Header(title: "Products"),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Add New Product',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        AddProductForm()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

