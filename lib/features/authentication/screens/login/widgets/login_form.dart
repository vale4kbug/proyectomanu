import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/features/authentication/screens/login/controllers/user_controller.dart';
import 'package:proyectomanu/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:proyectomanu/features/authentication/screens/signup/signup.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';
import 'package:proyectomanu/utils/validators/validator.dart';

class TLoginForm extends StatefulWidget {
  const TLoginForm({super.key});

  @override
  State<TLoginForm> createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final userController = Get.find<UserController>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  bool _passwordVisible = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return; // no hagas nada.
    }

    setState(() => _loading = true);
    await userController.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (mounted) {
      setState(() => _loading = false);
    }
    /*   try {
      final response = await AuthService.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      // Login correcto
      Get.snackbar(
          "Éxito", response["message"] ?? "Inicio de sesión correcto.");
      // Es mejor usar offAll para que el usuario no pueda volver atrás a la pantalla de login
      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      Get.snackbar("Error", e.toString().replaceFirst("Exception: ", ""),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            // Email
            TextFormField(
              controller: _emailController,
              validator: (value) => TValidator.validateEmail(value),
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Password
            TextFormField(
              controller: _passwordController,
              validator: (value) => TValidator.validatePassword(value),
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                labelText: TTexts.password,
                suffixIcon: IconButton(
                  icon:
                      Icon(_passwordVisible ? Iconsax.eye : Iconsax.eye_slash),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: const Text(TTexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections / 3),

            // Botones de Login y Crear Cuenta
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _login,
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(TTexts.signIn),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignupScreen()),
                child: const Text(TTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // No olvides liberar los controladores cuando el widget se destruye
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
