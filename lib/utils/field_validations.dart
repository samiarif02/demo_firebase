import '../resources/localization/app_localization.dart';

class FieldValidator {
  // static String? validateEmail(String? value) {
  //   if (value!.isEmpty) {
  //     return LocalizationMap.getValue("email_is_required");
  //   }
  //   if (!RegExp(
  //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  //   ).hasMatch(value)) {
  //     return LocalizationMap.getValue("enter_a_valid_email");
  //   }
  //   return null;
  // }
  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return LocalizationMap.getValue("email_is_required");
    }
    if (!RegExp(r"^[A-Za-z0-9](?!.*([!#$%&'*+/=?^_`{|}~-]){2})[A-Za-z0-9.!#$%&'*+/=?^_`{|}~-]+@[A-Za-z0-9-]+(?:\.[A-Za-z0-9-]+)*$")
        .hasMatch(value)) {
      return LocalizationMap.getValue("enter_a_valid_email");
    }

    if (!RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(value)) {
      return LocalizationMap.getValue("enter_a_valid_email");
    }

    if (value.contains(RegExp(r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'))) {
      return LocalizationMap.getValue("emojis_are_not_allowed_in_email_addresses");
    }

    return null;
  }

  static String? validateUserName(String? value) {
    if (value!.isEmpty) {
      return LocalizationMap.getValue("user_name_is_required");
    }
    if (value.length > 25) {
      return LocalizationMap.getValue("max_user_name_chars");
    }
    if (RegExp(r"^\d+$").hasMatch(value)) {
      return LocalizationMap.getValue("invalid_name");
    }
    return null;
  }

  static String? validateOTP(String? value) {
    if (value!.isEmpty) {
      return LocalizationMap.getValue("please_enter_otp");
    }
    if (value.length < 6) {
      return LocalizationMap.getValue("invalid_otp");
    }
    if (!RegExp(r"([0-9])$").hasMatch(value)) {
      return LocalizationMap.getValue("invalid_otp");
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return LocalizationMap.getValue("please_enter_password");
    }
    if (value.length < 8) {
      return LocalizationMap.getValue("password_should_contain_at_least_eight_character");
    }
    if (!RegExp(r"^(?=.*[A-Za-z@#$])(?=.*\d).{8,}$").hasMatch(value)) {
      return LocalizationMap.getValue("password_should_be_alphanumeric");
    }
    if (!RegExp(r"([A-Z])").hasMatch(value)) {
      return LocalizationMap.getValue("password_should_have_capital_alphabet");
    }

    if (!RegExp(r'^(?=.*?[!@#$%^&*()_+\-=\[\]{}€÷×;:"\\|,.<>\/?])').hasMatch(value.trim())) {
      return LocalizationMap.getValue("password_should_1_special_character");
    }

    return null;
  }

  static String? validatePassword2(String? value) {
    if (value!.isEmpty) {
      return LocalizationMap.getValue("please_enter_password");
    }
    // if (value.length < 8) {
    //   return LocalizationMap.getValue(
    //       "password_should_contain_at_least_eight_character");
    // }
    // if (!RegExp(r"^(?=.*[A-Za-z@#$])(?=.*\d).{8,}$").hasMatch(value)) {
    //   return LocalizationMap.getValue(
    //       "password_should_be_alphanumeric");
    // }
    // if (!RegExp(r"([A-Z])").hasMatch(value)) {
    //   return LocalizationMap.getValue(
    //       "password_should_have_capital_alphabet");
    // }
    //
    // if (!RegExp(r'^(?=.*?[!@#$%^&*()_+\-=\[\]{}€÷×;:"\\|,.<>\/?])').hasMatch(value.trim())) {
    //   return LocalizationMap.getValue("password_should_1_special_character");
    // }

    return null;
  }

  static String? validatePasswordMatch(String? value, String? pass2) {
    if (pass2!.isEmpty) {
      return LocalizationMap.getValue("please_re_enter_your_password");
    }
    if (value != pass2) {
      return LocalizationMap.getValue("password_does_not_match");
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value!.isEmpty) {
      return LocalizationMap.getValue("full_name_is_required");
    }
    if (value.length > 60) {
      return LocalizationMap.getValue("max_full_name_chars");
    }
    if (value.length <= 2) {
      return LocalizationMap.getValue("invalid_name");
    } else if (!RegExp(r'^[^\s]').hasMatch(value)) {
      return LocalizationMap.getValue("invalid_name");
    }
    if (!RegExp(r"^([ \u00c0-\u01ffa-zA-Z'\-])+$").hasMatch(value)) {
      return LocalizationMap.getValue("invalid_name");
    }
    return null;
  }

  static String? validateEmptyField(String? value) {
    if (value!.isEmpty) {
      return LocalizationMap.getValue("field_cant_be_empty");
    }
    return null;
  }

  static String?  validateAboutField(String? value) {
    if (value!.length > 250) {
      return LocalizationMap.getValue("max_about_field_chars");
    } else if (value.isEmpty) {
      return LocalizationMap.getValue("field_cant_be_empty");
    }
    return null;
  }
}
