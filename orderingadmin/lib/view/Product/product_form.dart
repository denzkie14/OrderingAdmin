import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:orderingadmin/controller/category_controller.dart';
import 'package:orderingadmin/controller/product_controller.dart';
import 'package:orderingadmin/model/category_model.dart';
import 'package:orderingadmin/model/product_model.dart';
import 'package:orderingadmin/model/user_model.dart';
import 'package:orderingadmin/service/http_service.dart';
import 'package:orderingadmin/util/alert_dialog.dart';
import 'package:orderingadmin/util/confirm_dialog.dart';
import 'package:orderingadmin/util/loading_dialog.dart';
import 'package:orderingadmin/util/prefs.dart';
import 'package:orderingadmin/util/toast_message.dart';

class ProductForm extends StatefulWidget {
  // const UserForm({ Key? key }) : super(key: key);
  final Product? product;
  final prefs = SharedPref();

  ProductForm({this.product});
  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<State> _keyConfirm = new GlobalKey<State>();
  final api = HttpService();
  final ProductController _controller = Get.put(ProductController());
  final CategoryController _categoryController = Get.put(CategoryController());
  final TextStyle style = const TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black);
  final format = DateFormat("yyyy-MM-dd");
  final pref = SharedPref();

  final TextEditingController cTitle = TextEditingController();
  final TextEditingController cDesc = TextEditingController();
  final TextEditingController cPrice = TextEditingController();
  final TextEditingController cUnit = TextEditingController();
  final TextEditingController cDiscount = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String selectedType = "Table";
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  Category? _selectedCategory = Category();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.product != null) {
      setState(() {
        cDesc.text = widget.product!.title ?? "";
        cTitle.text = widget.product!.title ?? "";
        cDesc.text = widget.product!.item_desc ?? "";
        cPrice.text = widget.product!.price.toString();
        cUnit.text = widget.product!.unit ?? "";

        cDesc.text = widget.product!.discount.toString();

        // cMname.text = widget.user!.mname ?? "";
        // cLname.text = widget.user!.lname ?? "";
        // selectedExt = widget.user!.ext_name ?? "N/A";
        // selectedGender = widget.user!.gender ?? "";
        // selectedDate = widget.user!.birthday ?? DateTime.now();
        // selectedType = widget.user!.user_type ?? "";
      });
    }
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: const CupertinoOptions(
          takePhotoIcon: "Image",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: const MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  Widget buildGridView() {
    if (widget.product != null && images.isEmpty) {
      return CachedNetworkImage(
        imageUrl: '${api.api}Item/Image/${widget.product!.item_id}',
        imageBuilder: (context, imageProvider) => Container(
          width: 300.0,
          height: 300.0,
          decoration: BoxDecoration(
            //   shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }
    if (images.isEmpty) {
      return Container(
        height: 300,
        width: 300,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Tap to select image'),
            ],
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 1,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetBuilder<CategoryController>(
                    init: CategoryController(),
                    builder: (value) {
                      return Container(
                        width: double.infinity,
                        height: 120,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: value.list.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedCategory = value.list[index];
                                    });
                                  },
                                  child: Card(
                                    color: _selectedCategory?.category_id ==
                                            value.list[index].category_id
                                        ? Colors.green
                                        : Colors.white,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                '${api.api}Category/Image/${value.list[index].category_id}',
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width: 85.0,
                                              height: 75.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.green),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 3.0, right: 3.0),
                                            width: 85.0,
                                            child: Text(
                                              '${value.list[index].category_desc}',

                                              style: TextStyle(
                                                  color: _selectedCategory
                                                              ?.category_id ==
                                                          value.list[index]
                                                              .category_id
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              //  softWrap: false,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    }),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: 300,
                  width: 300,
                  child: InkWell(
                      onTap: () {
                        loadAssets();
                      },
                      child: buildGridView()),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: cTitle,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide Title';
                    }
                    return null;
                  },
                  obscureText: false,
                  style: style,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      label: const Text(
                        "Title",
                        style: TextStyle(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(32.0),
                      )),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: cDesc,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide description';
                    }
                    return null;
                  },
                  obscureText: false,
                  style: style,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      label: const Text(
                        "Description",
                        style: TextStyle(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(32.0),
                      )),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: cPrice,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide price';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered
                  obscureText: false,
                  style: style,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      label: const Text(
                        "Price",
                        style: TextStyle(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(32.0),
                      )),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: cUnit,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide unit';
                    }
                    return null;
                  },
                  obscureText: false,
                  style: style,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      label: const Text(
                        "Unit",
                        style: TextStyle(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(32.0),
                      )),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: cDiscount,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please provide dicsount';
                  //   }
                  //   return null;
                  // },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered
                  obscureText: false,
                  style: style,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      label: const Text(
                        "Discount",
                        style: TextStyle(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(32.0),
                      )),
                ),
                const SizedBox(
                  height: 12,
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.green,
                  child: Center(
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () async {
                        if (_selectedCategory!.category_id == null) {
                          ToastMessage.showToastMessage(
                              context,
                              "Please select Category",
                              AlertMessagType.DEFAULT);
                          return;
                        }

                        if (images.isEmpty && widget.product == null) {
                          ToastMessage.showToastMessage(context,
                              "Please select Image", AlertMessagType.DEFAULT);
                          return;
                        }

                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //       content: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text('Processing Request...'),
                          //       CircularProgressIndicator()
                          //     ],
                          //   )),
                          // );
                          if (widget.product == null) {
                            final action = await Confirm.showAlertDialog(
                                  context,
                                  _keyConfirm,
                                  'Add',
                                  'Save new item?',
                                  AlertMessagType.QUESTION,
                                ) ??
                                false;
                            if (action) {
                              await _add();
                              Get.back();
                            }
                          } else {
                            final action = await Confirm.showAlertDialog(
                                  context,
                                  _keyConfirm,
                                  'Update',
                                  'Save changes made for this item?',
                                  AlertMessagType.QUESTION,
                                ) ??
                                false;
                            if (action) {
                              await _update();
                              Get.back();
                            }
                          }
                        }
                      },
                      child: Text("Save",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Product Information',
        style: TextStyle(color: Colors.green),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Ionicons.chevron_back_outline,
          color: Colors.green,
        ),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

  _add() async {
    LoadingDialog.showLoadingDialog(context, _keyLoader, 'Please wait...');
    try {
      for (Asset asset in images) {
        var byteData = await asset.getByteData(quality: 25);
        List<int> _imageData = byteData.buffer.asUint8List();
        var base64Image = base64Encode(_imageData);
        //     User _user = User.fromJson(await pref.read('user'));
        Product u = Product();
        u.title = cTitle.text;
        u.item_desc = cDesc.text;
        u.category_id = _selectedCategory!.category_id;
        u.image = base64Image;
        u.price = double.parse(cPrice.text);
        u.discount = int.parse(cDiscount.text);
        u.unit = cUnit.text;
        u.isActive = true;
        u.isDeleted = false;
        print(u.toJson());

        var response = await api.addProduct(u);
        if (response.statusCode == 200) {
          print('Success adding Category!');

          ToastMessage.showToastMessage(
              context, "Item added.", AlertMessagType.DEFAULT);
          _controller.load();
        } else {
          var body = jsonDecode(response.body);
          ToastMessage.showToastMessage(context,
              "Failed to add, please try again.", AlertMessagType.DEFAULT);
          print(response.statusCode.toString() + ': ' + body);
        }
      }
    } catch (e) {
      ToastMessage.showToastMessage(
          context,
          "Error occured: please check your network and try again.",
          AlertMessagType.DEFAULT);
      print('Error adding Category: ' + e.toString());
    } finally {
      Navigator.pop(_keyLoader.currentContext!, _keyLoader);
    }
  }

  _update() async {
    LoadingDialog.showLoadingDialog(context, _keyLoader, 'Please wait...');
    try {
      ByteData byteData;
      List<int> _imageData;
      String? base64Image;
      for (Asset asset in images) {
        byteData = await asset.getByteData(quality: 25);
        _imageData = byteData.buffer.asUint8List();
        base64Image = base64Encode(_imageData);
      }

      User _user = User.fromJson(await pref.read('user'));
      Product u = Product();
      u.title = cTitle.text;
      u.item_desc = cDesc.text;
      u.category_id = _selectedCategory!.category_id;
      u.image = base64Image;
      u.price = double.parse(cPrice.text);
      u.discount = int.parse(cDiscount.text);
      u.unit = cUnit.text;
      u.isActive = true;
      u.isDeleted = false;

      var response = await api.updateProduct(u);
      if (response.statusCode == 200) {
        print('Success updating Category!');
        CachedNetworkImage.evictFromCache('${api.api}Item/Image/${u.item_id}');
        ToastMessage.showToastMessage(
            context, "Item updated.", AlertMessagType.DEFAULT);
        _controller.load();
      } else {
        var body = jsonDecode(response.body);
        ToastMessage.showToastMessage(context,
            "Failed to update, please try again.", AlertMessagType.DEFAULT);
        print(response.statusCode.toString() + ': ' + body);
      }
    } catch (e) {
      ToastMessage.showToastMessage(
          context,
          "Error occured: please check your network and try again.",
          AlertMessagType.DEFAULT);
      print('Error updating Category: ' + e.toString());
    } finally {
      Navigator.pop(_keyLoader.currentContext!, _keyLoader);
    }
  }
}
