import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/features/authentication/screens/login/services/auth_service.dart';
import 'package:proyectomanu/features/authentication/screens/signup/verify_email.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';
import 'package:proyectomanu/utils/validators/validator.dart';

class TSignupForm extends StatefulWidget {
  const TSignupForm({super.key});

  @override
  State<TSignupForm> createState() => _TSignupFormState();
}

class _TSignupFormState extends State<TSignupForm> {
  // 1. Clave global para el formulario
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _usuarioController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // 2. Variables de estado
  bool _loading = false;
  bool _passwordVisible = false;
  bool _termsAccepted = false; // Para el estado del checkbox

  Future<void> _register() async {
    // 3. Primero, valida el formulario y el checkbox
    if (!_formKey.currentState!.validate()) {
      return; // Si los campos no son válidos, no continúa.
    }

    /* if (!_termsAccepted) {
      // Muestra un error si no se aceptan los términos
      Get.snackbar("Aceptar Términos",
          "Debes aceptar los términos y condiciones para continuar.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white);
      return;
    }
*/
    setState(() => _loading = true);

    try {
      final response = await AuthService.register(
        nombre: _nombreController.text.trim(),
        apellido: _apellidoController.text.trim(),
        nombreUsuario: _usuarioController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        authProvider: "local",
      );

      Get.snackbar(
          "Éxito",
          response["message"] ??
              "Registro exitoso. Por favor verifica tu correo.");

      // Se pasa el email a la pantalla de verificación.
      Get.to(() => VerifyEmailScreen(email: _emailController.text.trim()));
    } catch (e) {
      Get.snackbar("Error", e.toString().replaceFirst("Exception: ", ""),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 4. Asigna la clave al widget Form
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _nombreController,
                  validator: (value) =>
                      TValidator.validateEmptyText("Nombre", value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TTexts.name,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: _apellidoController,
                  validator: (value) =>
                      TValidator.validateEmptyText("Apellido", value),
                  decoration: const InputDecoration(
                    labelText: TTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          TextFormField(
            controller: _usuarioController,
            validator: (value) => TValidator.validateUsername(value),
            decoration: const InputDecoration(
              labelText: TTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          TextFormField(
            controller: _emailController,
            validator: (value) => TValidator.validateEmail(value),
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          TextFormField(
            controller: _passwordController,
            validator: (value) => TValidator.validatePassword(value),
            obscureText: !_passwordVisible, // Controlado por la variable
            decoration: InputDecoration(
              labelText: TTexts.password,
              prefixIcon: const Icon(Iconsax.password_check),
              suffixIcon: IconButton(
                icon: Icon(_passwordVisible ? Iconsax.eye : Iconsax.eye_slash),
                onPressed: () {
                  setState(() => _passwordVisible = !_passwordVisible);
                },
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /*  // 5. Checkbox de Términos y Condiciones
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: _termsAccepted,
                  onChanged: (value) {
                    setState(() {
                      _termsAccepted = value!;
                    });
                  },
                ),
              ),
             const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(text: '${TTexts.iAgreeTo} '),
                    TextSpan(
                      text: TTexts.privacyPolicy,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: Theme.of(context).primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                    TextSpan(text: ' ${TTexts.and} '),
                    TextSpan(
                      text: TTexts.termsofUse,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: Theme.of(context).primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
*/
          const SizedBox(height: TSizes.spaceBtwSections),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _loading ? null : _register,
              child: _loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(TTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }

  // 6. Liberar todos los controladores
  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _usuarioController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
