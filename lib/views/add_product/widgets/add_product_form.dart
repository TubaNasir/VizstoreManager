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

class AddProductForm extends StatefulWidget {
  const AddProductForm({Key? key}) : super(key: key);

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  late Uint8List fileBytes;
  var picked;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    String dropdownvalue = context.watch<AddProductProvider>().dropdownvalue;
    final _formKey = GlobalKey<FormState>();

    return Form(
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
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                      color: SecondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: Colors.grey)),
                  child: (picked == null)
                      ? Center(child: Icon(Icons.image_outlined))
                      : Image.memory(fileBytes, fit: BoxFit.contain),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: CustomButtonSecondary(
                      text: "Upload Image",
                      pressed: () async {
                        picked = await FilePickerWeb.platform.pickFiles();
                        if (picked != null) {
                          fileBytes = picked.files.first.bytes;
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
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'Enter title',
                      errorStyle: TextStyle(
                        color: Colors.transparent,
                        fontSize: 0,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon:
                          Icon(Icons.abc), //SuffixIcon(icon: Icons.email)
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                    controller: titleController),
                SizedBox(height: 30),
                TextFormField(
                  minLines: 3,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter description',
                    errorStyle: TextStyle(
                      color: Colors.transparent,
                      fontSize: 0,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Icon(Icons.abc), //SuffixIcon(icon: Icons.email)
                  ),
                  controller: descriptionController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Price',
                          hintText: 'Enter price',
                          errorStyle: TextStyle(
                            color: Colors.transparent,
                            fontSize: 0,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon:
                              Icon(Icons.abc), //SuffixIcon(icon: Icons.email)
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                          hintText: 'Enter quantity',
                          errorStyle: TextStyle(
                            color: Colors.transparent,
                            fontSize: 0,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon:
                              Icon(Icons.abc), //SuffixIcon(icon: Icons.email)
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Stack(children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Category",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  Container(
                    height: 54,
                    padding: const EdgeInsets.only(left: 40.0, right: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          focusColor: Colors.white,
                          iconDisabledColor: Colors.white,
                          iconEnabledColor: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          isExpanded: true,
                          value: dropdownvalue,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: SecondaryColor,
                          ),
                          items: categories.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              context
                                  .read<AddProductProvider>()
                                  .setDropdownValue(newValue!);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 200,
                        child: CustomButton(
                          text: 'Add Product',
                          pressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (picked != null) {
                                bool success = await context
                                    .read<AddProductProvider>()
                                    .addProduct(
                                        titleController.text,
                                        descriptionController.text,
                                        int.parse(quantityController.text),
                                        int.parse(priceController.text),
                                        dropdownvalue,
                                        fileBytes);
                                if (success) {
                                  titleController.clear();
                                  descriptionController.clear();
                                  quantityController.clear();
                                  priceController.clear();
                                  picked = null;
                                  setState(() {});
                                }
                              } else {
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
    );
  }
}
