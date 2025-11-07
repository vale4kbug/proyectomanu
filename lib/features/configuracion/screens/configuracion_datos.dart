import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyectomanu/common/widgets/appbar/appbar.dart';
import 'package:proyectomanu/features/authentication/screens/login/controllers/user_controller.dart';
import 'package:proyectomanu/features/authentication/screens/login/services/auth_service.dart';
import 'package:proyectomanu/features/configuracion/widgets/configuracion_datos_menu.dart';
import 'package:proyectomanu/features/diccionario/widgets/heading_section.dart';
import 'package:proyectomanu/utils/constants/colors.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart';
import 'package:proyectomanu/utils/validators/validator.dart';

class ConfiguracionDatosScreen extends StatefulWidget {
  const ConfiguracionDatosScreen({super.key});

  @override
  State<ConfiguracionDatosScreen> createState() =>
      _ConfiguracionDatosScreenState();
}

class _ConfiguracionDatosScreenState extends State<ConfiguracionDatosScreen> {
  final controller = Get.find<UserController>();

  final List<String> avatares = [
    TImages.avatar1,
    TImages.avatar2,
    TImages.avatar3,
    TImages.avatar4,
    TImages.avatar5,
    TImages.avatar6,
  ];

  // --- Diálogo para pedir contraseña ---
  Future<String?> _pedirContrasena(String titulo) async {
    final TextEditingController passController = TextEditingController();
    return Get.dialog<String>(
      AlertDialog(
        title: Text(titulo,
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: TColors.primaryColor)),
        content: TextField(
          controller: passController,
          obscureText: true,
          decoration:
              const InputDecoration(labelText: "Ingresa tu contraseña actual"),
        ),
        actions: [
          TextButton(
              onPressed: () => Get.back(result: null),
              child: const Text("Cancelar")),
          ElevatedButton(
              onPressed: () => Get.back(result: passController.text),
              child: const Text("Confirmar")),
        ],
      ),
    );
  }

  // --- Diálogo para editar un campo ---
  Future<void> _mostrarDialogoEdicion(String tipo, String valorActual) async {
    final TextEditingController inputController =
        TextEditingController(text: valorActual);

    final String? nuevoValor = await Get.dialog<String>(
      AlertDialog(
        title: Text("Cambiar $tipo",
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: TColors.primaryColor)),
        content: TextField(
          controller: inputController,
          decoration: InputDecoration(labelText: "Nuevo $tipo"),
          obscureText: tipo == 'contraseña', // oculta si es contraseña
        ),
        actions: [
          TextButton(
              onPressed: () => Get.back(), child: const Text("Cancelar")),
          ElevatedButton(
              onPressed: () => Get.back(result: inputController.text),
              child: const Text("Guardar")),
        ],
      ),
    );

    // --- Verificar si canceló o no cambió nada ---
    if (nuevoValor == null || nuevoValor.isEmpty || nuevoValor == valorActual) {
      return;
    }

    // --- Aplicar validaciones según el tipo ---
    String? error;

    switch (tipo) {
      case 'nombre':
        error = TValidator.validateEmptyText('Nombre', nuevoValor);
        break;
      case 'nombre de usuario':
        error = TValidator.validateUsername(nuevoValor);
        break;
      case 'contraseña':
        error = TValidator.validatePassword(nuevoValor);
        break;
    }

    if (error != null) {
      Get.snackbar("Error de validación", error,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade900);
      return;
    }

    // --- Si pasa validación, pedir contraseña ---
    final contrasena = await _pedirContrasena("Verificación de Seguridad");
    if (contrasena == null || contrasena.isEmpty) return;

    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    try {
      await AuthService.actualizarPerfil(
        contrasenaActual: contrasena,
        nuevoNombre: tipo == 'nombre' ? nuevoValor : null,
        nuevoNombreUsuario: tipo == 'nombre de usuario' ? nuevoValor : null,
        nuevaContrasena: tipo == 'contraseña' ? nuevoValor : null,
      );
      await controller.recargarUsuario();
      Get.back(); // Cierra el spinner
      Get.snackbar("Éxito", "Tu $tipo se ha actualizado correctamente.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade900);
    } catch (e) {
      Get.back(); // Cierra el spinner
      Get.snackbar("Error", e.toString().replaceFirst("Exception: ", ""),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade900);
    }
  }

  // --- Diálogo para seleccionar avatar ---
  Future<void> _seleccionarAvatar() async {
    final String? avatarSeleccionado = await Get.dialog<String>(AlertDialog(
      title: const Text("Elige tu Avatar",
          style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: TColors.primaryColor)),
      content: SizedBox(
        width: double.maxFinite,
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: avatares.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Get.back(result: avatares[index]),
              child: CircleAvatar(
                  backgroundImage: AssetImage(avatares[index]), radius: 30),
            );
          },
        ),
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text("Cancelar")),
      ],
    ));

    if (avatarSeleccionado == null) return;

    final contrasena = await _pedirContrasena("Verificación de Seguridad");
    if (contrasena == null || contrasena.isEmpty) return;

    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    try {
      await AuthService.actualizarPerfil(
        contrasenaActual: contrasena,
        nuevaImagenPerfil: avatarSeleccionado,
      );
      await controller.recargarUsuario();
      Get.back(); // Cierra el spinner
      Get.snackbar("Éxito", "Tu foto de perfil ha sido actualizada.");
    } catch (e) {
      Get.back(); // Cierra el spinner
      Get.snackbar("Error", e.toString().replaceFirst("Exception: ", ""));
    }
  }

  // --- Diálogo para borrar cuenta ---
  Future<void> _borrarCuenta() async {
    final contrasena = await _pedirContrasena("¡Acción Permanente!");
    if (contrasena == null || contrasena.isEmpty) return;

    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    try {
      await AuthService.borrarCuenta(contrasena);
      Get.back(); // Cierra el spinner
      controller.logout(); // Llama al logout del controlador
    } catch (e) {
      Get.back(); // Cierra el spinner
      Get.snackbar("Error", e.toString().replaceFirst("Exception: ", ""));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
          showBackArrow: true, title: Text(TTexts.configDatosTitle1)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(() {
            // Obx para que los sub se actualicen
            final usuario = controller.usuario.value;
            if (usuario == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                TSectionHeading(title: TTexts.configDatosTitle),
                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems),
                TConfigDatosMenu(
                  title: TTexts.name,
                  subTitle: usuario.nombre,
                  onPressed: () =>
                      _mostrarDialogoEdicion("nombre", usuario.nombre),
                ),
                TConfigDatosMenu(
                  title: TTexts.username,
                  subTitle: usuario.nombreUsuario,
                  onPressed: () => _mostrarDialogoEdicion(
                      "nombre de usuario", usuario.nombreUsuario),
                ),
                TConfigDatosMenu(
                  title: TTexts.configDatosFoto,
                  subTitle: 'Toca para cambiar tu avatar',
                  onPressed: _seleccionarAvatar,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                TSectionHeading(title: TTexts.configDatosTitle2),
                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems),
                TConfigDatosMenu(
                    title: TTexts.configDatosID,
                    subTitle: usuario.id.toString(),
                    onPressed: () {
                      Get.snackbar(
                        "Campo protegido",
                        "El ID del usuario no se puede modificar.",
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: TColors.secondaryColor,
                      );
                    }),
                TConfigDatosMenu(
                  title: 'Correo',
                  subTitle: usuario.email,
                  onPressed: () {
                    Get.snackbar(
                      "Campo protegido",
                      "El correo electrónico no se puede modificar.",
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: TColors.secondaryColor,
                    );
                  },
                ), //solo vista
                TConfigDatosMenu(
                  title: 'Contraseña',
                  subTitle: '********',
                  onPressed: () => _mostrarDialogoEdicion("contraseña", ""),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _borrarCuenta,
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red)),
                    child: const Text(TTexts.eliminarCuentaBoton,
                        style: TextStyle(color: Colors.red)),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
