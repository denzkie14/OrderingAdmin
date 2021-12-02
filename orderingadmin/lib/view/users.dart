import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:orderingadmin/controller/users_controller.dart';
import 'package:orderingadmin/view/user_form.dart';

class UsersPage extends StatelessWidget {
  // const UsersPage({ Key? key }) : super(key: key);
  //final UsersController _controller = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
    // _controller.loadUser();

    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(
        child: GetBuilder<UsersController>(
            init: UsersController(),
            builder: (value) {
              if (value.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (value.usersList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(value.errorMessage.value),
                      IconButton(
                        onPressed: () {
                          value.loadUser();
                        },
                        icon: const Icon(Ionicons.refresh_outline),
                        iconSize: Get.height / 16,
                      )
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  value.loadUser();
                  return Future.value();
                },
                child: Center(
                  child: ListView.builder(
                      itemCount: value.usersList.length,
                      itemBuilder: (context, index) {
                        final user = value.usersList.elementAt(index);

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 10,
                            child: ListTile(
                              onTap: () {},
                              title: Text(user.fname ?? ''),
                              subtitle: Text(user.user_type ?? ''),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      color: Colors.green,
                                      icon:
                                          const Icon(Ionicons.pencil_outline)),
                                  IconButton(
                                      color: Colors.red,
                                      onPressed: () {},
                                      icon: const Icon(Ionicons.trash_outline))
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[600],
        child: const Icon(Ionicons.add_outline),
        onPressed: () {
          Get.to(() => UserForm());
        },
      ),
    );
  }

  buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Users',
        style: TextStyle(color: Colors.green),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Ionicons.chevron_back_outline,
          color: Colors.green,
        ),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
}
