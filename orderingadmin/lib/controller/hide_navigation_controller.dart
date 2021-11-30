import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HideNavbar {
  final ScrollController controller = ScrollController();
  final ValueNotifier<bool> visible = ValueNotifier<bool>(true);

  HideNavbar() {
    visible.value = true;
    controller.addListener(
      () {
        if (controller.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (visible.value) {
            visible.value = false;
          }
        }

        if (controller.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!visible.value) {
            visible.value = true;
          }
        }

        controller.position.isScrollingNotifier.addListener(() {
          if (!controller.position.isScrollingNotifier.value) {
            print('scroll is stopped');
            if (!visible.value) {
              visible.value = true;
            }
          } else {
            print('scroll is started');
          }
        });
      },
    );
  }

  void dispose() {
    controller.dispose();
    visible.dispose();
  }
}
