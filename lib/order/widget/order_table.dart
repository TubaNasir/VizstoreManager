import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vizstore_manager/controllers/order_list_provider.dart';
import 'package:vizstore_manager/models/order_json.dart';
import 'package:vizstore_manager/order_details/order_details.dart';
import 'package:vizstore_manager/widgets/header.dart';
import 'package:vizstore_manager/widgets/loader.dart';

class OrderTable extends StatefulWidget {
  const OrderTable({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderTable> createState() => _OrderTableState();
}

class _OrderTableState extends State<OrderTable> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => {
          context.read<OrderListProvider>().getMyOrders(),
        });
  }

  @override
  Widget build(BuildContext context) {
    List<OrderJson> orders = context.watch<OrderListProvider>().orders;
    bool isLoading = context.watch<OrderListProvider>().isLoading;

    return Column(
      children: [
        Header(title: "Orders"),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('My Orders',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ]),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: DataTable(
                          columns: [
                            DataColumn(
                                label: Text(
                              "ID",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text(
                              "Placed On",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text(
                              "Status",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ],
                          rows: List.generate(
                            orders.length,
                            (index) => OrderRow(orders[index], () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (_) =>
                                          OrderDetails(id: orders[index].id!)))
                                  .then(
                                    (value) => context
                                        .read<OrderListProvider>()
                                        .getMyOrders(),
                                  );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            if(isLoading)
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.5,
                  left: MediaQuery.of(context).size.width * 0.5,
                  child: Loader())
          ],
        ),
      ],
    );
  }
}

OrderRow(OrderJson order, VoidCallback onPressed) {
  return DataRow(cells: [
    DataCell(InkWell(onTap: onPressed, child: Text(order.id!))),
    DataCell(Text(
        "${order.date_created.day}/${order.date_created.month}/${order.date_created.year}")),
    DataCell(Text("${order.status}")),
  ]);
}
