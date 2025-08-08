import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/features/home/home.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          backgroundColor: darkMode ? Colors.black : Colors.white,
          indicatorColor: darkMode
              ? const Color.fromARGB(177, 174, 214, 245)
              : const Color.fromARGB(255, 180, 217, 246),
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home, color: TColors.primaryColor),
              label: 'Aprender',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.weight_1, color: TColors.primaryColor),
              label: 'Ejercicios',
            ),

            NavigationDestination(
              icon: Icon(Iconsax.smallcaps, color: TColors.primaryColor),
              label: 'Diccionario',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.happyemoji, color: TColors.primaryColor),
              label: 'Perfil',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.setting, color: TColors.primaryColor),
              label: 'Configuración',
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    Container(color: Colors.purple),
    Container(color: Colors.orange),
    Container(color: Colors.blue),
    Container(color: Colors.yellow),
  ];
}
