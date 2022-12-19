import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vizstore_manager/controllers/order_details_provider.dart';
import 'package:vizstore_manager/models/order_json.dart';
import 'package:vizstore_manager/models/product_json.dart';

class OrderItemTable extends StatefulWidget {
  const OrderItemTable({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderItemTable> createState() => _OrderItemTableState();
}

class _OrderItemTableState extends State<OrderItemTable> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => {
          await context.read<OrderDetailsProvider>().getAllProducts(),
        });
  }

  @override
  Widget build(BuildContext context) {
    OrderJson order = context.watch<OrderDetailsProvider>().order;
    List<ProductJson> products =
        context.read<OrderDetailsProvider>().getProductList(order);

    return DataTable(
      dataRowHeight: 100,
      columns: [
        DataColumn(
            label: Text(
          "ID",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        DataColumn(
            label: Text(
          "Title",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        DataColumn(
            label: Text(
          "Quantity",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ],
      rows: List.generate(
        order.cart.length,
        (index) => OrderRow(products[index], order.cart[index].quantity, () {
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (_) => OrderDetails(id: orders[index].id!)));
        }),
      ),
    );
  }
}

OrderRow(ProductJson product, int quantity, VoidCallback onPressed) {
  return DataRow(cells: [
    DataCell(InkWell(onTap: onPressed, child: Text(product.id!))),
    DataCell(Text("${product.title}")),
    DataCell(Text("x${quantity}")),
  ]);
}
