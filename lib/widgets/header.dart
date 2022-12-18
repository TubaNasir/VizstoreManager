import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vizstore_manager/constants.dart';
import 'package:vizstore_manager/controllers/product_list_provider.dart';
import 'package:vizstore_manager/models/store_json.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => {
      await context.read<ProductListProvider>().getStore(),
      context.read<ProductListProvider>().getNameInitial()
    });
  }

  @override
  Widget build(BuildContext context) {

    StoreJson store = context.watch<ProductListProvider>().store;
    String nameInitial = context.watch<ProductListProvider>().nameInitial;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Row(
            children: [
              Text(widget.title,
                  style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold)),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 12.0,
                        backgroundColor: PrimaryColor,
                        child: Text(
                          nameInitial,
                          //store.storeManager.toString().substring(0,1),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(store.storeManager),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
            color: Colors.black12,
            height: 2
        ),
      ],
    );
  }
}