class TValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Se requiere un correo electrónico.';
    }

    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegExp.hasMatch(value)) {
      return 'Correo inválido';
    }

    return null; // ✅ si todo bien
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Se requiere la contraseña.';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres.';
    }

    final hasUppercase = value.contains(RegExp(r'[A-Z]'));
    final hasDigits = value.contains(RegExp(r'[0-9]'));
    final hasSpecialCharacters = value.contains(
      RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
    );

    if (!hasUppercase) {
      return 'Debe contener al menos una letra mayúscula.';
    }
    if (!hasDigits) {
      return 'Debe contener al menos un número.';
    }
    if (!hasSpecialCharacters) {
      return 'Debe contener al menos un carácter especial.';
    }

    return null; // ✅ si todo bien
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Se requiere un número de teléfono.';
    }
    // Por ejemplo 10 dígitos para MX
    final phoneRegExp = RegExp(r'^\d{10}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Número de teléfono inválido (debe tener 10 dígitos)';
    }
    return null; // ✅ si todo bien
  }
}
