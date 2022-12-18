import 'package:flutter/material.dart';
import 'package:vizstore_manager/views/order/widget/order_table.dart';
import 'package:vizstore_manager/widgets/side_drawer.dart';

class OrderList extends StatelessWidget {
  const OrderList({Key? key}) : super(key: key);

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
              child: OrderTable(),
            ),
          ],
        ),
      ),
    );
  }
}





