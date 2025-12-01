import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/features/authentication/screens/login/login.dart';
import 'package:proyectomanu/features/authentication/screens/login/services/auth_service.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';
import 'package:proyectomanu/utils/validators/validator.dart';

class ResetPassword extends StatefulWidget {
  final String email; // Recibimos el email para referencia
  const ResetPassword({super.key, required this.email});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _codeController =
      TextEditingController(); // Renombrado de _tokenController
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _loading = false;
  bool _passwordVisible = false;

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      Get.snackbar('Error', 'Las contraseñas no coinciden.',
          backgroundColor: Colors.orange, colorText: Colors.white);
      return;
    }

    setState(() => _loading = true);

    try {
      final response = await AuthService.resetPassword(
        token: _codeController.text.trim(), // Enviamos el código como token
        newPassword: _passwordController.text.trim(),
      );

      Get.snackbar('Éxito',
          response['message'] ?? 'Contraseña actualizada correctamente.',
          backgroundColor: Colors.green, colorText: Colors.white);

      // Limpiamos la pila de navegación y vamos al Login
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceFirst("Exception: ", ""),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Centramos el contenido
              children: [
                // Icono o Imagen
                const Icon(Iconsax.password_check,
                    size: 100, color: Colors.blueAccent),
                const SizedBox(height: TSizes.spaceBtwSections),

                Text(
                  TTexts.changeYourPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Text(
                  'Hemos enviado un código de seguridad a ${widget.email}. Por favor, ingrésalo abajo para crear tu nueva contraseña.',
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Campo para el Código (Token)
                TextFormField(
                  controller: _codeController,
                  validator: (value) =>
                      TValidator.validateEmptyText('Código', value),
                  keyboardType:
                      TextInputType.number, // Teclado numérico para el código
                  textAlign: TextAlign.center, // Texto centrado
                  style: const TextStyle(
                      fontSize: 24,
                      letterSpacing: 5), // Estilo grande para el código
                  decoration: const InputDecoration(
                    labelText: 'Código de Verificación',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Iconsax.security_safe),
                    hintText: "######",
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Campo para la nueva contraseña
                TextFormField(
                  controller: _passwordController,
                  validator: TValidator.validatePassword,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    labelText: TTexts.password,
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _passwordVisible ? Iconsax.eye : Iconsax.eye_slash),
                      onPressed: () =>
                          setState(() => _passwordVisible = !_passwordVisible),
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Campo para confirmar contraseña
                TextFormField(
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Confirma tu contraseña';
                    if (value != _passwordController.text)
                      return 'Las contraseñas no coinciden';
                    return null;
                  },
                  obscureText: !_passwordVisible,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar Contraseña',
                    prefixIcon: Icon(Iconsax.password_check),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Botón de enviar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _resetPassword,
                    child: _loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Restablecer Contraseña"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
