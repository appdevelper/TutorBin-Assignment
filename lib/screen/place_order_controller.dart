import 'package:get/get.dart';
import 'package:place_order/module/product_model.dart';
import 'package:place_order/shared/common_data.dart';

class PlaceOrderController extends GetxController {

  var productList = <Data>[].obs;
  var totalPrice = (0.0).obs;

  @override
  void onInit() {
    getProductData();
    super.onInit();
  }

  getProductData() {
    productList.clear();
    ProductModel response = ProductModel.fromJson(productJsonData);
    productList.addAll(response.data!);
    productList[0].isOpen = true;
  }

  funOpenList(parentIndex) {
    productList[parentIndex].isOpen = !productList[parentIndex].isOpen;
    productList.refresh();
  }

  increaseQuantity(parentIndex,childIndex){
    if(productList[parentIndex].products![childIndex].instock!){
      productList[parentIndex].products![childIndex].quantity +=1;
      productList.refresh();
    }
    funTotalPrice();
  }

  decreaseQuantity(parentIndex,childIndex){
    if(productList[parentIndex].products![childIndex].quantity>1){
      productList[parentIndex].products![childIndex].quantity -=1;
      productList.refresh();
    }
    else{
      productList[parentIndex].products![childIndex].quantity = 0;
      productList.refresh();
    }
    funTotalPrice();
  }

  funTotalPrice(){
    totalPrice.value = 0.0;
    for(int i=0;i<productList.length;i++){
      for(int j=0;j<productList[i].products!.length;j++){
        if(productList[i].products![j].quantity>0){
          totalPrice.value = totalPrice.value+double.parse((productList[i].products![j].price!*productList[i].products![j].quantity).toString());
        }
      }
    }
  }

}
