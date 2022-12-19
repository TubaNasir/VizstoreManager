import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vizstore_manager/controllers/order_list_provider.dart';
import 'package:vizstore_manager/views/order/widget/order_table.dart';
import 'package:vizstore_manager/widgets/loader.dart';
import 'package:vizstore_manager/widgets/side_drawer.dart';

class OrderList extends StatelessWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool isLoading = context.watch<OrderListProvider>().isLoading;

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
                  OrderTable(),
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
