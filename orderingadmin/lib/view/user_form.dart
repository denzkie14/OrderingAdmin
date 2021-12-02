import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:orderingadmin/controller/users_controller.dart';
import 'package:orderingadmin/model/user_model.dart';
import 'package:orderingadmin/service/http_service.dart';
import 'package:orderingadmin/util/prefs.dart';

class UserForm extends StatefulWidget {
  // const UserForm({ Key? key }) : super(key: key);
  final User? user;

  UserForm({this.user});
  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final api = HttpService();
  final UsersController _controller = Get.put(UsersController());
  final TextStyle style = const TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.green);
  final format = DateFormat("yyyy-MM-dd");
  final pref = SharedPref();

  final TextEditingController cFname = TextEditingController();

  final TextEditingController cMname = TextEditingController();

  final TextEditingController cLname = TextEditingController();

  final TextEditingController cGender = TextEditingController();

  final TextEditingController birthday = TextEditingController();

  final TextEditingController cUsername = TextEditingController();

  final TextEditingController cPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String selectedGender = "Male";
  String selectedType = "User";
  String selectedExt = "N/A";
  DateTime selectedDate = DateTime.now();

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       selectedDate = picked;
  //     });
  // }

  List<DropdownMenuItem<String>> get genderItem {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Male"), value: "Male"),
      const DropdownMenuItem(child: Text("Female"), value: "Female"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get extItem {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Ext. Name"), value: "N/A"),
      const DropdownMenuItem(child: Text("JR."), value: "JR."),
      const DropdownMenuItem(child: Text("SR."), value: "SR."),
      const DropdownMenuItem(child: Text("III"), value: "III"),
      const DropdownMenuItem(child: Text("IV"), value: "IV"),
      const DropdownMenuItem(child: Text("V"), value: "V"),
      const DropdownMenuItem(child: Text("VI"), value: "VI"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get userTypeItem {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("User"), value: "User"),
      const DropdownMenuItem(child: Text("Admin"), value: "Admin"),
    ];
    return menuItems;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.user != null) {
      setState(() {
        cUsername.text = widget.user!.username ?? "";
        cFname.text = widget.user!.fname ?? "";
        cMname.text = widget.user!.mname ?? "";
        cLname.text = widget.user!.lname ?? "";
        selectedExt = widget.user!.ext_name ?? "N/A";
        selectedGender = widget.user!.gender ?? "";
        selectedDate = widget.user!.birthday ?? DateTime.now();
        selectedType = widget.user!.user_type ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 12,
                ),
                if (widget.user == null)
                  TextFormField(
                    controller: cUsername,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please provide Username';
                      }
                      return null;
                    },
                    obscureText: false,
                    style: style,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Username",
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
                if (widget.user == null)
                  TextFormField(
                    controller: cPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please provide Password';
                      }
                      return null;
                    },
                    obscureText: true,
                    style: style,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Password",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                  ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: cFname,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide First Name';
                    }
                    return null;
                  },
                  obscureText: false,
                  style: style,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "First Name",
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
                  controller: cMname,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please your Username';
                  //   }
                  //   return null;
                  // },
                  obscureText: false,
                  style: style,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Middle Name",
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
                  controller: cLname,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide Last Name';
                    }
                    return null;
                  },
                  obscureText: false,
                  style: style,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Last Name",
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
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        // borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      border: OutlineInputBorder(
                        // borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      // filled: true,
                      // fillColor: Colors.blueAccent,
                    ),
                    //  dropdownColor: Colors.blueAccent,
                    value: selectedExt,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedExt = newValue!;
                      });
                    },
                    items: extItem),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: 55,
                  child: InkWell(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(1900, 1),
                          lastDate: DateTime(2101));
                      if (picked != null && picked != selectedDate) {
                        setState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              DateFormat('MMMM dd, yyyy').format(selectedDate)),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50))),
                ),
                const SizedBox(
                  height: 12,
                ),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        // borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      border: OutlineInputBorder(
                        // borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      // filled: true,
                      // fillColor: Colors.blueAccent,
                    ),
                    //  dropdownColor: Colors.blueAccent,
                    value: selectedGender,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue!;
                      });
                    },
                    items: genderItem),
                const SizedBox(
                  height: 12,
                ),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        //    borderSide: BorderSide(color: Colors.green, width: 1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      border: OutlineInputBorder(
                        //  borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // filled: true,
                      // fillColor: Colors.blueAccent,
                    ),
                    //  dropdownColor: Colors.blueAccent,
                    value: selectedType,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedType = newValue!;
                      });
                    },
                    items: userTypeItem),
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
                      onPressed: () {
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
                          if (widget.user == null) {
                            _addUser();
                          } else {
                            _updateUser();
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
        'User Information',
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

  _addUser() async {
    try {
      User u = User();
      u.username = cUsername.text;
      u.password = cPassword.text;
      u.fname = cFname.text;
      u.mname = cMname.text;
      u.lname = cLname.text;
      u.ext_name = selectedExt;
      u.gender = selectedGender;
      u.user_type = selectedType;
      u.birthday = selectedDate;
      print(u.toJson());

      var response = await api.addUser(u);
      if (response.statusCode == 200) {
        print('Success adding user!');
        _controller.loadUser();
      } else {
        var body = jsonDecode(response.body);
        print(response.statusCode.toString() + ': ' + body);
      }
    } catch (e) {
      print('Error adding user: ' + e.toString());
    }
  }

  _updateUser() async {
    try {
      User u = User();
      u.user_id = widget.user!.user_id;
      // u.username = cUsername.text;
      // u.password = cPassword.text;
      u.fname = cFname.text;
      u.mname = cMname.text;
      u.lname = cLname.text;
      u.ext_name = selectedExt;
      u.gender = selectedGender;
      u.user_type = selectedType;
      u.birthday = selectedDate;
      print(u.toJson());

      var response = await api.updateUser(u);
      if (response.statusCode == 200) {
        print('Success updating user!');
        _controller.loadUser();
      } else {
        var body = jsonDecode(response.body);
        print(response.statusCode.toString() + ': ' + body);
      }
    } catch (e) {
      print('Error adding user: ' + e.toString());
    }
  }
}
