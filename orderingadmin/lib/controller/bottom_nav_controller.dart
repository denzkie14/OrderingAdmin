import 'package:get/get.dart';

enum BottomPage { HOME, ORDERS, SEARCH, NOTIFICATIONS, PROFILE }

class BottomNavController extends GetxController {
  int _pageIndex = 2;
  var _title = 'Gravitea'.obs;
  get selectedPage => _pageIndex;

  get selectedPageTitle => _title;

  setPage(int page) {
    _pageIndex = page;
    switch (page) {
      case 0:
        //  _pageIndex = 0;
        _title.value = 'Notifications';
        break;
      case 1:
        _title.value = 'My Orders';
        //   _pageIndex = 1;
        break;
      case 2:
        _title.value = 'Gravitea';
        //  _pageIndex = 2;
        break;
      case 3:
        _title.value = 'Search';
        //  _pageIndex = 3;
        break;
      case 4:
        _title.value = 'Wishlist';
        //  _pageIndex = 4;
        break;
    }

    update();
  }
}
