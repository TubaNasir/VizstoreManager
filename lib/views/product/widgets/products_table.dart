import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vizstore_manager/views/add_product/add_product.dart';
import 'package:vizstore_manager/controllers/product_list_provider.dart';
import 'package:vizstore_manager/models/product_json.dart';
import 'package:vizstore_manager/views/product_details/product_details.dart';
import 'package:vizstore_manager/widgets/custom_button.dart';
import 'package:vizstore_manager/widgets/header.dart';

class ProductTable extends StatefulWidget {
  const ProductTable({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductTable> createState() => _ProductTableState();
}

class _ProductTableState extends State<ProductTable> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => {
          context.read<ProductListProvider>().getMyProducts(),
        });
  }

  @override
  Widget build(BuildContext context) {
    List<ProductJson> products = context.watch<ProductListProvider>().products;

    return SingleChildScrollView(
      child: Column(
        children: [
          Header(title: "Products"),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('My Products',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    CustomButton(
                        text: "Add New",
                        pressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => AddProduct()));
                        })
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
                            "Title",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                          DataColumn(
                              label: Text(
                            "Price",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                          DataColumn(
                              label: Text(
                            "Stock",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                          DataColumn(
                              label: Text(
                            "Sold",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ],
                        rows: List.generate(
                          products.length,
                          (index) => ProductRow(products[index], () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (_) => ProductDetails(
                                        product: products[index])))
                                .then(
                                  (value) => context
                                      .read<ProductListProvider>()
                                      .getMyProducts(),
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
        ],
      ),
    );
  }
}

ProductRow(ProductJson product, VoidCallback onPressed) {
  return DataRow(cells: [
    DataCell(InkWell(onTap: onPressed, child: Text(product.id!))),
    DataCell(SizedBox(width: 300, child: Text(product.title, overflow: TextOverflow.ellipsis,))),
    DataCell(Text("${product.price}")),
    DataCell(Text("${product.stock}")),
    DataCell(Text("${product.sold}")),
  ]);
}
