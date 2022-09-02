import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:place_order/shared/app_text_style.dart';

import 'place_order_controller.dart';

class PlaceOrderScreen extends GetView<PlaceOrderController> {
  const PlaceOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Expanded(
                  child: Obx(
                    () => ListView.separated(
                      itemCount: controller.productList.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, parentIndex) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.funOpenList(parentIndex);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 4),
                                          child: Text(
                                            controller.productList[parentIndex]
                                                    .title ??
                                                '',
                                            style: boldTextStyle(fontSize: 18.0),
                                          ),
                                        ),
                                        parentIndex > 2
                                            ? const SizedBox()
                                            : const Icon(
                                                Icons.assistant_rounded,
                                                color: Colors.black,
                                                size: 14,
                                              )
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          (controller.productList[parentIndex]
                                                  .products!.length)
                                              .toString(),
                                          style: boldTextStyle(
                                            fontSize: 17.0,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        Icon(
                                          !controller
                                                  .productList[parentIndex].isOpen
                                              ? Icons.keyboard_arrow_right
                                              : Icons.keyboard_arrow_down,
                                          color: Colors.grey[400],
                                          size: 36,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            getProductList(parentIndex)
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          color: Colors.grey[350],
                          thickness: 1.2,
                        );
                      },
                    ),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.only(left: 12,right: 12,top: 12,bottom: 12),
                  margin: const EdgeInsets.only(top: 20),

                  child: Row(
                    children:  [
                      Expanded(
                        child: Center(
                          child: Text(
                            'Place Order',
                            style: boldTextStyle(fontSize: 18.0,color: Colors.white),
                          ),
                        ),
                      ),
                     Obx(() =>  Text(
                       '\$ ${(controller.totalPrice.value).toStringAsFixed(2)}',
                       style: boldTextStyle(fontSize: 18.0,color: Colors.white),
                     ),)
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  getProductList(parentIndex) {
    if (!controller.productList[parentIndex].isOpen) {
      return Container();
    } else {
      return Container(
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(10)),
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
        child: ListView.separated(
          itemCount: controller.productList[parentIndex].products!.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, childIndex) {
            var productChildList =
                controller.productList[parentIndex].products![childIndex];
            return Container(
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              productChildList.name ?? '',
                              style: boldTextStyle(fontSize: 16),
                            ),
                            Visibility(
                              visible: productChildList.isFav!,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(15)),
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 2, bottom: 2),
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    'Best Seller',
                                    style: mediumTextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '\$ ${double.parse((productChildList.price ?? '0.0').toString()).toStringAsFixed(2)}',
                          style: boldTextStyle(
                              fontSize: 16, color: Colors.grey[600]),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.orange,
                        ),
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.only(
                        left: 6, right: 6, top: 2, bottom: 2),
                    alignment: Alignment.center,
                    width: 120,
                    child: productChildList.quantity == 0
                        ? InkWell(
                            onTap: () {
                              controller.increaseQuantity(
                                  parentIndex, childIndex);
                            },
                            child: Text(
                              'Add',
                              style: boldTextStyle(
                                fontSize: 16,
                                color: Colors.orange,
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    controller.decreaseQuantity(
                                        parentIndex, childIndex);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.orange,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.orange,
                                ),
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.only(left: 12, right: 12),
                                child: Text(
                                  productChildList.quantity.toString(),
                                  style: boldTextStyle(fontSize: 16),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    controller.increaseQuantity(
                                        parentIndex, childIndex);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.orange,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.grey[350],
              thickness: 1.2,
            );
          },
        ),
      );
    }
  }
}
