class ValidationUtils {
  //Validação do e-mail
  static bool isValidEmail(String email) {
    final RegExp regex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    return regex.hasMatch(email);
  }
}

//Validação da senha
class ValidationResult {
  final String message;
  final bool isValid;

  ValidationResult({required this.message, required this.isValid});
}

class ValidationPassword {
  static List<ValidationResult> validatePassword(String password) {
    List<ValidationResult> validations = [];

    validations.add(ValidationResult(
      message: 'Tamanho mínimo de 8 caracteres',
      isValid: password.length >= 8,
    ));

    validations.add(ValidationResult(
      message: 'Pelo menos uma letra maiúscula',
      isValid: RegExp(r'[A-Z]').hasMatch(password),
    ));

    validations.add(ValidationResult(
      message: 'Pelo menos uma letra minúscula',
      isValid: RegExp(r'[a-z]').hasMatch(password),
    ));

    validations.add(ValidationResult(
      message: 'Pelo menos um número',
      isValid: RegExp(r'[0-9]').hasMatch(password),
    ));

    validations.add(ValidationResult(
      message: 'Pelo menos um símbolo',
      isValid: RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password),
    ));

    return validations;
  }

  static List<String> getInitialValidations() {
    return [
      'Tamanho mínimo de 8 caracteres',
      'Pelo menos uma letra minúscula',
      'Pelo menos uma letra maiúscula',
      'Pelo menos um número',
      'Pelo menos um símbolo',
    ];
  }
}
