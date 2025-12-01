import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:proyectomanu/common/widgets/success_screen/success_screen.dart';
import 'package:proyectomanu/features/authentication/screens/login/login.dart';
import 'package:proyectomanu/features/authentication/screens/login/services/auth_service.dart';
import 'package:proyectomanu/utils/constants/images_strings.dart';
import 'package:proyectomanu/utils/constants/sizes.dart';
import 'package:proyectomanu/utils/constants/text_strings.dart';
import 'package:proyectomanu/utils/helpers/helper_functions.dart';
import 'package:proyectomanu/utils/validators/validator.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String? email;
  const VerifyEmailScreen({super.key, this.email});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isVerifying = false;
  bool _isResending = false;

  // --- 1. Lógica para Verificar el Código ---
  Future<void> _verifyCode() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isVerifying = true);

    try {
      // Llamamos al servicio con el código que escribió el usuario
      await AuthService.verifyEmail(_codeController.text.trim());

      // Si todo sale bien, vamos a la pantalla de éxito
      Get.off(
        () => SuccessScreen(
          image: TImages.staticSuccesIllutration,
          title: TTexts.yourAccountCreatedTitle,
          subtitle: TTexts.yourAccountCreatedSubTitle,
          onPressed: () => Get.offAll(() => const LoginScreen()),
        ),
      );
    } catch (e) {
      Get.snackbar(
        'Error de Verificación',
        e.toString().replaceFirst("Exception: ", ""),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      if (mounted) setState(() => _isVerifying = false);
    }
  }

  // --- 2. Lógica para Reenviar el Correo ---
  Future<void> _resendEmail() async {
    if (widget.email == null || widget.email!.isEmpty) return;

    setState(() => _isResending = true);
    try {
      final response = await AuthService.resendVerificationEmail(widget.email!);
      Get.snackbar('Correo enviado',
          response['message'] ?? 'Revisa tu bandeja de entrada.',
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceFirst("Exception: ", ""),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => const LoginScreen()),
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Imagen
                Image(
                  image: const AssetImage(TImages.deliveredEmailIllustration),
                  width: THelperFunctions.screenWidth() * 0.6,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Título y Subtítulo
                Text(
                  TTexts.confirmEmail,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Text(
                  widget.email ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Text(
                  "Ingresa el código de 6 dígitos que enviamos a tu correo para verificar tu cuenta.", // Texto personalizado
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // --- CAMPO DE CÓDIGO ---
                TextFormField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 24,
                      letterSpacing: 8,
                      fontWeight: FontWeight.bold),
                  validator: (value) =>
                      TValidator.validateEmptyText('Código', value),
                  decoration: const InputDecoration(
                    hintText: "######",
                    prefixIcon: Icon(Iconsax.security_user),
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // --- BOTÓN DE VERIFICAR ---
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isVerifying ? null : _verifyCode,
                    child: _isVerifying
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2))
                        : const Text(TTexts.tcontinue),
                  ),
                ),

                const SizedBox(height: TSizes.spaceBtwItems),

                /*  // --- BOTÓN DE REENVIAR ---
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: _isResending ? null : _resendEmail,
                    child: _isResending
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator())
                        : const Text(TTexts.resendEmail),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
