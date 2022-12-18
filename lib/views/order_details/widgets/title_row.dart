import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vizstore_manager/controllers/order_details_provider.dart';
import 'package:vizstore_manager/models/order_json.dart';
import 'package:vizstore_manager/widgets/custom_button.dart';
import 'package:vizstore_manager/widgets/custom_button_secondary.dart';

class TitleRow extends StatefulWidget {
  const TitleRow({Key? key, required this.id}) : super(key: key);

  final String id;
  @override
  State<TitleRow> createState() => _TitleRowState();
}

class _TitleRowState extends State<TitleRow> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => {
          await context.read<OrderDetailsProvider>().getOrderInfo(widget.id),
        });
  }

  @override
  Widget build(BuildContext context) {
    OrderJson order = context.watch<OrderDetailsProvider>().order;

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        child: Text('Order ID: ${order.id}',
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(fontWeight: FontWeight.bold)),
      ),
      if (order.status == 'Placed')
        Row(
          children: [
            CustomButtonSecondary(
                text: "Cancel",
                pressed: () {
                  context
                      .read<OrderDetailsProvider>()
                      .updateOrderStatus("Cancelled");
                }),
            CustomButton(
                text: "Accept",
                pressed: () {
                  context
                      .read<OrderDetailsProvider>()
                      .updateOrderStatus("Confirmed");
                }),
          ],
        )
      else
        SizedBox(height: 30),
    ]);
  }
}
