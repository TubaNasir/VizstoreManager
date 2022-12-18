import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vizstore_manager/controllers/order_details_provider.dart';
import 'package:vizstore_manager/models/order_json.dart';
import 'package:vizstore_manager/views/order_details/widgets/order_item_table.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summary',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold)),
          SizedBox(
            child: OrderItemTable()
          ),
          Divider(color: Colors.black12),
        ],
      ),
    );
  }
}

