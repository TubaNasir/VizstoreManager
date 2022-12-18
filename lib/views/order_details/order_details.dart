import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vizstore_manager/controllers/order_details_provider.dart';
import 'package:vizstore_manager/views/order_details/widgets/order_info.dart';
import 'package:vizstore_manager/views/order_details/widgets/order_summary.dart';
import 'package:vizstore_manager/views/order_details/widgets/title_row.dart';
import 'package:vizstore_manager/widgets/header.dart';
import 'package:vizstore_manager/widgets/side_drawer.dart';

class OrderDetails extends StatefulWidget {
  OrderDetails({Key? key, required this.id}) : super(key: key);

  final String id;
  @override
  State<OrderDetails> createState() => _AddProductState();
}

class _AddProductState extends State<OrderDetails> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => {
          await context.read<OrderDetailsProvider>().getOrderInfo(widget.id),
          await context.read<OrderDetailsProvider>().getUserInfo(),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Header(title: "Orders"),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TitleRow(id: widget.id),
                          OrderInfo(),
                          OrderSummary(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
