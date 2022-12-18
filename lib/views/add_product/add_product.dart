import 'dart:typed_data';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:vizstore_manager/constants.dart';
import 'package:vizstore_manager/controllers/add_product_provider.dart';
import 'package:vizstore_manager/widgets/custom_button.dart';
import 'package:vizstore_manager/widgets/custom_button_secondary.dart';
import 'package:vizstore_manager/widgets/header.dart';
import 'package:vizstore_manager/widgets/side_drawer.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();
  TextEditingController _quantityController = new TextEditingController();
  String dropdownvalue = 'Clothes';
  var picked = null;
  final _formKey = GlobalKey<FormState>();
  late Uint8List fileBytes;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => {
          context.read<AddProductProvider>().getUser(),
        });
  }

  @override
  Widget build(BuildContext context) {
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
                        Text('Add New Product',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        Form(
                          key: _formKey,
                          child: Row(
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
                                          ? Center(
                                              child: Icon(Icons.image_outlined))
                                          : Image.memory(fileBytes,
                                              fit: BoxFit.contain),
                                    ),
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      child: CustomButtonSecondary(
                                          text: "Upload Image",
                                          pressed: () async {
                                            picked = await FilePickerWeb.platform
                                                .pickFiles();
                                            if (picked != null) {
                                              fileBytes =
                                                  picked.files.first.bytes;
                                              //File file = await File('image.jpg').writeAsBytes(fileBytes);
                                              //print(file);
                                              String fileName =
                                                  picked.files.first.name;
                                              print(fileName);
                                              setState(() {});
                                            }
                                          })),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.all(16.0),
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Title',
                                          hintText: 'Enter title',
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
                                        controller: _titleController),
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
                                      controller: _descriptionController,
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return '';
                                        }
                                        return null;
                                      },
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
                                              if (text == null || text.isEmpty) {
                                                return '';
                                              }
                                              return null;
                                            },
                                            controller: _priceController,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Quantity',
                                              hintText: 'Enter quantity',
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
                                            controller: _quantityController,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Stack(children: [
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: "Category",
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                        ),
                                      ),
                                      Container(
                                        height: 54,
                                        padding: const EdgeInsets.only(
                                            left: 40.0, right: 20.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(28.0),
                                        ),
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
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
                                              items:
                                                  categories.map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownvalue = newValue!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 200,
                                child: CustomButton(
                                  text: 'Add Product',
                                  pressed: () async {
                                    if(_formKey.currentState!.validate()) {
                                      if (picked != null) {
                                        bool success = await context
                                            .read<AddProductProvider>()
                                            .addProduct(
                                            _titleController.text,
                                            _descriptionController.text,
                                            int.parse(
                                                _quantityController.text),
                                            int.parse(_priceController.text),
                                            dropdownvalue,
                                            fileBytes);
                                        if (success) {
                                          _titleController.clear();
                                          _descriptionController.clear();
                                          _quantityController.clear();
                                          _priceController.clear();
                                        }
                                      }
                                      else{
                                        Toast.show('Please choose an image');
                                      }
                                    }
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
