
  String? signinEmailValidation(value) {
                  if (value!.isEmpty) {
                    return 'Enter email address';
                  } else if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$') //check one @ and 1 .
                      .hasMatch(value)) {
                    return 'Enter a valid email address';
                  } else {
                    int atSignCount = value.split('@').length - 1;
                    int dotCount = value.split('.').length - 1;
                    if (atSignCount != 1 || dotCount != 1) {
                      return 'Email address must contain exactly one @ and one .';
                    }
                  }
                  return null;
                }



  String? signinUserNameValidation(value) {
                  if (value!.isEmpty) {
                    return 'You forgot to give Username';
                  } else if (value.length < 5) {
                    return 'Enter the valid Username';
                  }
                  return null;
                }





  String? signinPhoneValidation(value) {
                  if (value!.isEmpty) {
                    return 'You forgot to enter phone number';
                  } else if (value.length != 10) {
                    return 'Phone should have 10 Digits';
                  } else if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                }



  String? signinPassValidation(value) {
                  if (value!.isEmpty) {
                    return 'You forgot to enter password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  } else if (!RegExp(
                          r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                      .hasMatch(value)) {
                    return 'Password should have at @1least 1 letter, 1 number, 1 special character';
                  }
                  return null;
                }




