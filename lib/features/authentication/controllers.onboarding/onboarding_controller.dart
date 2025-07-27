import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();
  //variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;
  //Actualizar pagina del index cuando se le haga scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;
  //Saltar a un punto dependiendo la pagina seleccionada
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index); // CORREGIDO
  }

  //Actualizar index y saltar a la siguiente pagina
  void nextPage() {
    if (currentPageIndex.value == 2) {
      // Get.to(LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  //Actualizar index y saltar a la ultima
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
