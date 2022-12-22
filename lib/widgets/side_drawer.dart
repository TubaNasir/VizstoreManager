import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vizstore_manager/constants.dart';
import 'package:vizstore_manager/controllers/product_list_provider.dart';
import 'package:vizstore_manager/views/login/login.dart';
import 'package:vizstore_manager/models/store_json.dart';
import 'package:vizstore_manager/views/order/order_list.dart';
import 'package:vizstore_manager/views/product/product_list.dart';
import 'package:vizstore_manager/widgets/custom_button.dart';
import 'package:vizstore_manager/widgets/custom_button_secondary.dart';
import 'package:vizstore_manager/widgets/drawer_list_tile.dart';
import 'package:vizstore_manager/controllers/side_drawer_provider.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => {
          await context.read<ProductListProvider>().getStore(),
          context.read<ProductListProvider>().getStoreInitial()
        });
  }

  @override
  Widget build(BuildContext context) {
    StoreJson store = context.watch<ProductListProvider>().store;
    String storeInitial = context.watch<ProductListProvider>().storeInitial;

    return Container(
      color: Colors.black87,
      child: Column(children: [
        DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: PrimaryColor,
                child: Text(
                  storeInitial,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25
                  ),
                ),
              ),
              SizedBox(height:20),
              Expanded(
                child: Text(store.storeName,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              )
            ],
          ),
        ),
        DrawerListTile(
            title: 'Products',
            icon: Icons.add_chart_rounded,
            selected:
                context.watch<SideDrawerProvider>().productPage == 'products',
            onTap: () {
              context.read<SideDrawerProvider>().setPage('products');
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductList(),
                ),
              );
            }),
        DrawerListTile(
            title: 'Orders',
            icon: Icons.add_box_outlined,
            selected:
                context.watch<SideDrawerProvider>().productPage == 'orders',
            onTap: () {
              context.read<SideDrawerProvider>().setPage('orders');
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OrderList(),
                ),
              );
            }),
        DrawerListTile(
            title: 'Logout',
            icon: Icons.exit_to_app,
            selected: false,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        content: Text('Are you sure you want to logout?', style: TextStyle(fontWeight: FontWeight.bold),),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 40,
                                width: 90,
                                child: CustomButtonSecondary(
                                  pressed: () => {
                                    context.read<SideDrawerProvider>().logout(),
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ),
                                    ),
                                    context.read<SideDrawerProvider>().setPage('products'),
                                },
                                  text: 'Yes',
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                width: 90,
                                child: CustomButton(
                                  pressed: () => Navigator.pop(context),
                                  text: 'No',
                                ),
                              ),
                            ],
                          ),
                        ]);
                  });
            }),
      ]),
    );
  }
}
