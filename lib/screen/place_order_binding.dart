import 'package:get/get.dart';

import 'place_order_controller.dart';

class PlaceOrderBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => PlaceOrderController());
  }

}