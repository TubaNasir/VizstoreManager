import 'dart:typed_data';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:vizstore_manager/constants.dart';
import 'package:vizstore_manager/controllers/product_details_provider.dart';
import 'package:vizstore_manager/models/product_json.dart';
import 'package:vizstore_manager/widgets/custom_button.dart';
import 'package:vizstore_manager/widgets/custom_button_secondary.dart';
import 'package:vizstore_manager/widgets/header.dart';
import 'package:vizstore_manager/widgets/side_drawer.dart';
import 'package:flutter/services.dart';
import 'package:image_network/image_network.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({Key? key, required this.product}) : super(key: key);

  final ProductJson product;
  @override
  State<ProductDetails> createState() => _AddProductState();
}

class _AddProductState extends State<ProductDetails> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();

  bool editable = false;
  bool enabled = true;
  var picked = null;
  late Uint8List fileBytes;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => {
          _titleController.text = widget.product.title,
          _descriptionController.text = widget.product.description,
          _priceController.text = widget.product.price.toString(),
          _quantityController.text = widget.product.stock.toString(),
          context.read<ProductDetailsProvider>().setProduct(widget.product),
          context
              .read<ProductDetailsProvider>()
              .setDropdownValue(widget.product.category)
        });
  }

  @override
  Widget build(BuildContext context) {
    bool editable = context.watch<ProductDetailsProvider>().editable;
    String dropdownvalue =
        context.watch<ProductDetailsProvider>().dropdownvalue;
    ToastContext().init(context);

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
              child: Column(
                children: [
                  Header(title: "Products"),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Product ID: ${widget.product.id}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.45,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    decoration: BoxDecoration(
                                        color: SecondaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        border: Border.all(color: Colors.grey)),
                                    child: (picked == null)
                                        ? ImageNetwork(
                                            image: widget.product.image,
                                            fitWeb: BoxFitWeb.contain,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.45,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25)
                                        : Image.memory(fileBytes,
                                            fit: BoxFit.contain),
                                  ),
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    child: CustomButtonSecondary(
                                        text: "Change Image",
                                        pressed: () async {
                                          picked = await FilePickerWeb.platform
                                              .pickFiles();

                                          if (picked != null) {
                                            fileBytes =
                                                picked.files.first.bytes;
                                            String fileName =
                                                picked.files.first.name;
                                            print(fileName);
                                            //setState(() {});
                                            context
                                                .read<ProductDetailsProvider>()
                                                .changeImage(fileBytes);
                                            // Upload file
                                            //await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes);
                                          }
                                        })),
                              ],
                            ),
                            Form(
                              key: _formKey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Name',
                                        hintText: 'Enter name',
                                        errorStyle: TextStyle(
                                          color: Colors.transparent,
                                          fontSize: 0,
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        suffixIcon: Icon(Icons
                                            .abc), //SuffixIcon(icon: Icons.email)
                                      ),
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return '';
                                        }
                                        return null;
                                      },
                                      controller: _titleController,
                                      readOnly: !editable,
                                    ),
                                    SizedBox(height: 30),
                                    TextFormField(
                                      minLines: 3,
                                      maxLines: 4,
                                      decoration: InputDecoration(
                                        labelText: 'Description',
                                        hintText: 'Enter description',
                                        errorStyle: TextStyle(
                                          color: Colors.transparent,
                                          fontSize: 0,
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        suffixIcon: Icon(Icons
                                            .abc), //SuffixIcon(icon: Icons.email)
                                      ),
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return '';
                                        }
                                        return null;
                                      },
                                      controller: _descriptionController,
                                      readOnly: !editable,
                                    ),
                                    SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Price',
                                              hintText: 'Enter price',
                                              errorStyle: TextStyle(
                                                color: Colors.transparent,
                                                fontSize: 0,
                                              ),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              suffixIcon: Icon(Icons
                                                  .abc), //SuffixIcon(icon: Icons.email)
                                            ),
                                            validator: (text) {
                                              if (text == null ||
                                                  text.isEmpty) {
                                                return '';
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: _priceController,
                                            readOnly: !editable,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Quantity',
                                              hintText: 'Enter quantity',
                                              errorStyle: TextStyle(height: 0),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              suffixIcon: Icon(Icons
                                                  .abc), //SuffixIcon(icon: Icons.email)
                                            ),
                                            validator: (text) {
                                              if (text == null ||
                                                  text.isEmpty) {
                                                return 'Field cannot be empty';
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            controller: _quantityController,
                                            readOnly: !editable,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Stack(children: [
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: "Category",
                                          enabled: enabled,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                        ),
                                      ),
                                      Container(
                                        height: 64,
                                        padding: const EdgeInsets.only(
                                            left: 40.0, right: 20.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(28.0),
                                        ),
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                            // <- Here
                                            splashColor:
                                                Colors.transparent, // <- Here
                                            highlightColor:
                                                Colors.transparent, // <- Here
                                            hoverColor: Colors.transparent,
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              focusColor: Colors.white,
                                              iconDisabledColor: Colors.white,
                                              iconEnabledColor: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(28),
                                              isExpanded: true,
                                              value: dropdownvalue,
                                              icon: const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: SecondaryColor,
                                              ),
                                              items: categories
                                                  .map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items),
                                                );
                                              }).toList(),
                                              onChanged: editable
                                                  ? (String? newValue) {
                                                      print(newValue);
                                                      setState(() {
                                                        context
                                                            .read<
                                                                ProductDetailsProvider>()
                                                            .setDropdownValue(
                                                                newValue!);
                                                      });
                                                    }
                                                  : null,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        (editable == false)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 200,
                                      child: CustomButton(
                                        text: 'Edit',
                                        pressed: () {
                                          context
                                              .read<ProductDetailsProvider>()
                                              .changeEditable();
                                        },
                                      )),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 200,
                                      child: CustomButton(
                                        text: 'Save Changes',
                                        pressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context
                                                .read<ProductDetailsProvider>()
                                                .updateProduct(
                                                    _titleController.text,
                                                    _descriptionController.text,
                                                    int.parse(
                                                        _quantityController
                                                            .text),
                                                    int.parse(
                                                        _priceController.text),
                                                    dropdownvalue);
                                            context
                                                .read<ProductDetailsProvider>()
                                                .changeEditable();
                                          }
                                        },
                                      )),
                                  Container(
                                      width: 200,
                                      child: CustomButtonSecondary(
                                        text: 'Cancel',
                                        pressed: () {
                                          _titleController.text =
                                              widget.product.title;
                                          _descriptionController.text =
                                              widget.product.description;
                                          _priceController.text =
                                              widget.product.price.toString();
                                          _quantityController.text =
                                              widget.product.stock.toString();
                                          dropdownvalue =
                                              widget.product.category;
                                          context
                                              .read<ProductDetailsProvider>()
                                              .changeEditable();
                                          _formKey.currentState!.reset();
                                        },
                                      )),
                                ],
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
