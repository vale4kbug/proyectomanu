import 'dart:math';

class TImages {
  //logo manolingo
  static const String darkAppLogo = "assets/logos/manolingo-logo-blanco.png";
  static const String lightAppLogo = "assets/logos/manolingo-logo-azul.png";
  static const String lightAppLogoconManu =
      "assets/logos/manolingo-logo-azul con manu-flat.png";
  //perfil
  static const String imagenperfil = "assets/logos/applogo.png";
  //social logos
  static const String google = "assets/icons/brands/Google.png";
  static const String facebook = "assets/icons/brands/Facebook.png";
  //onboarding
  static const String onBoardingImage1 =
      "assets/images/on_boarding/OnBoarding1_0000.gif";
  static const String onBoardingImage2 =
      "assets/images/on_boarding/OnBoarding2_0000.gif";
  static const String onBoardingImage3 =
      "assets/images/on_boarding/OnBoarding3_0000.gif";
  //animations
  static const String deliveredEmailIllustration =
      "assets/images/verificaemail.png";
  static const String verifyIllustration =
      "assets/images/correo/verificaemail.png";
  static const String staticSuccesIllutration =
      "assets/images/correo/exito.png";

  //AvataresPerfil

  static const String avatar1 = "assets/logos/applogo.png";
  static const String avatar2 = "assets/correo/exito.png";
  static const String avatar3 = "assets/logos/applogo.png";
  static const String avatar4 = "assets/logos/applogo.png";
  static const String avatar5 = "assets/logos/applogo.png";
  static const String avatar6 = "assets/logos/applogo.png";

  //Iconos Categoriar
  static const String dactidologiaIcon = "assets/logos/applogo.png"; //cambiar

  //Imagenes Diccionario Thumbnail
  static const String thumbnaildactidologiaA =
      "assets/logos/applogo.png"; //cambiar

  //Imagenes Final Nivel
  static const List<String> imagen1Estrella = [
    "assets/logos/applogo.png",
    "assets/logos/applogo.png",
    "assets/logos/applogo.png"
  ];

  static const List<String> imagen2Estrellas = [
    "assets/logos/applogo.png",
    "assets/logos/applogo.png",
    "assets/logos/applogo.png"
  ];

  static const List<String> imagen3Estrellas = [
    "assets/logos/applogo.png",
    "assets/logos/applogo.png",
    "assets/logos/applogo.png"
  ];
  static String imagenPorEstrellas(int estrellas) {
    final random = Random();

    final estrellasReales = (estrellas > 0 && estrellas <= 3) ? estrellas : 1;

    switch (estrellasReales) {
      case 1:
        return imagen1Estrella[random.nextInt(imagen1Estrella.length)];
      case 2:
        return imagen2Estrellas[random.nextInt(imagen2Estrellas.length)];
      case 3:
        return imagen3Estrellas[random.nextInt(imagen3Estrellas.length)];
      default:
        return imagen3Estrellas[random.nextInt(imagen3Estrellas.length)];
    }
  }
}
