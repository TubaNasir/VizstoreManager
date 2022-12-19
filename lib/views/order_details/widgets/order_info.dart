import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vizstore_manager/controllers/order_details_provider.dart';
import 'package:vizstore_manager/models/order_json.dart';
import 'package:vizstore_manager/models/user_json.dart';

class OrderInfo extends StatefulWidget {
  const OrderInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderInfo> createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  @override
  Widget build(BuildContext context) {
    OrderJson order = context.watch<OrderDetailsProvider>().order;
    UserJson user = context.watch<OrderDetailsProvider>().user;

    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(children: [
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text("Placed on:")),
            Text(
                "${order.date_created.day}/${order.date_created.month}/${order.date_created.year}",
                style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        Divider(color: Colors.black12),
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text("Placed by: ")),
            Text("${user.firstName} ${user.lastName}",
                style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        Divider(color: Colors.black12),
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text("Contact")),
            Text(user.contact,
                style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        Divider(color: Colors.black12),
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text("Address")),
            Text(order.address, style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        Divider(color: Colors.black12),
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text("City")),
            Text(order.city, style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        Divider(color: Colors.black12),
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text("Status")),
            Container( decoration: BoxDecoration(
              color: order.status == 'Confirmed'
                  ? Colors.lightGreen
                  : order.status == 'Cancelled'
                  ? Colors.red
                  : Colors.amberAccent,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(order.status, style: TextStyle(fontWeight: FontWeight.w600)),
            )),
          ],
        ),
        Divider(color: Colors.black12),
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text("Total")),
            Text("Rs. ${order.total}",
                style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        Divider(color: Colors.black12),
      ]),
    );
  }
}
