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
  final _tokenController = TextEditingController();
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
        token: _tokenController.text.trim(),
        newPassword: _passwordController.text.trim(),
      );

      Get.snackbar('Éxito',
          response['message'] ?? 'Contraseña actualizada correctamente.');
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
    _tokenController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restablecer Contraseña'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TTexts.changeYourPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Text(
                  'Hemos enviado un token a ${widget.email}. Por favor, ingrésalo abajo junto con tu nueva contraseña.',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Campo para el Token
                TextFormField(
                  controller: _tokenController,
                  validator: (value) =>
                      TValidator.validateEmptyText('Token', value),
                  decoration: const InputDecoration(
                    labelText: 'Token',
                    prefixIcon: Icon(Iconsax.code),
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
                  validator: TValidator.validatePassword,
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
                        : const Text(TTexts.submit),
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
