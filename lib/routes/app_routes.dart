import 'package:get/get.dart';
import 'package:place_order/routes/routes_name.dart';
import 'package:place_order/screen/place_order_binding.dart';
import 'package:place_order/screen/place_order_screen.dart';

class AppRoutes {
  static var routes = [
    GetPage(
      name: RoutesName().placeOrder,
      page: () => const PlaceOrderScreen(),
      binding: PlaceOrderBinding(),
    ),
  ];
}