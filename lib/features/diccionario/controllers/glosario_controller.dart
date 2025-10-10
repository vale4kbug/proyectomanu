import 'package:get/get.dart';
import 'package:proyectomanu/features/diccionario/models/categoria_glosario_model.dart';
import 'package:proyectomanu/features/diccionario/models/glosario_model.dart';
import 'package:proyectomanu/features/diccionario/services/glosario_service.dart';
import 'package:flutter/material.dart'; // Necesario para TextEditingController

class GlosarioController extends GetxController {
  var isLoadingCategorias = true.obs;
  var categoriasList = <CategoriaGlosario>[].obs;

  var isLoadingItems = true.obs;
  var glosarioList = <GlosarioItem>[].obs;
  var selectedCategoryId = Rxn<int>();

  final TextEditingController searchController = TextEditingController();
  var searchQuery = ''.obs;
  @override
  void onInit() {
    super.onInit();
    fetchCategorias();
    fetchGlosarioItems(); // Carga todos los items
    debounce(
        searchQuery, (_) => fetchGlosarioItems(busqueda: searchQuery.value),
        time: const Duration(milliseconds: 500));
  }

  void fetchCategorias() async {
    try {
      isLoadingCategorias(true);
      var categorias = await GlosarioService.getCategorias();
      categoriasList.assignAll(categorias);
    } finally {
      isLoadingCategorias(false);
    }
  }

  // Este método ahora puede filtrar por categoría
  void fetchGlosarioItems({int? categoriaId, String? busqueda}) async {
    try {
      isLoadingItems(true);

      // Si es una búsqueda, reseteamos la categoría seleccionada
      if (busqueda != null) {
        selectedCategoryId.value = null;
      } else {
        selectedCategoryId.value = categoriaId;
      }

      var items = await GlosarioService.getGlosarioItems(
          categoriaId: categoriaId, busqueda: busqueda);
      glosarioList.assignAll(items);
    } finally {
      isLoadingItems(false);
    }
  }

  void onSearchQueryChanged(String query) {
    searchQuery.value = query;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
