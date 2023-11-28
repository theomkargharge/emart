
  //  validator: (value) {
  //                   if (value!.isEmpty) {
  //                     return 'Please enter your email address';
  //                   } else if (!isValidEmail(value)) {
  //                     return 'Please enter a valid email address';
  //                   }
  //                   return null;
  //                 },


//password

  // validator: (value) {
  //                   if (value!.isEmpty) {
  //                     return 'Please enter your password';
  //                   } else if (value.length < 6 || value.length > 10) {
  //                     return 'Password must be 6 to 10 characters long';
  //                   } else if (!RegExp(
  //                           r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+])[a-zA-Z0-9!@#$%^&*()_+]+$')
  //                       .hasMatch(value)) {
  //                     return 'Password must contain at least one digit, one special character, and letters';
  //                   }
  //                   return null;
  //                 },

  /*
  
  bool signupValidation(
  String email,
  String password,
  String name,
  String phone,
) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    showMessage('All fields are empty');
    return false;
  } else if (email.isEmpty) {
    showMessage('Email is Empty');
    return false;
  } else if (name.isEmpty) {
    showMessage('Name is Empty');
    return false;
  } else if (phone.isEmpty) {
    showMessage('Phone is Empty');
    return false;
  } else if (password.isEmpty) {
    showMessage('Password is Empty');
    return false;
  } else {
    return true;
  }
}
  
  
  
   */



  /**
  getmessagefromerrorcode

  String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return 'Email already used . Go to login page.';
    case "account-exitsts-with-different-credential":
      return 'Email already used . Go to login page.';
    case "email-already-in-use":
      return 'Email already used . Go to login page.';
    case "ERROR_WRONG_PASSWORD":
    case 'wrong-password':
      return 'Wrong Password';
    case "ERROR_USER_NOT_FOUND":
      return "No user found with this email";
    case "user-not-found":
      return "No user found with this email";
    case "ERROR_USER_DISABLED":
      return "User disabled";
    case "user-disabled":
      return "User disabled";
    case "ERROR_TOO_MANY_REQUESTS":
      return "Too many requests to log into this account";
    case "operation-not-allowed":
      return 'Too many requests to log into this account';
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Too many requests to log into this account";
    case "ERROR_INVALID_EMAIL":
      return "Email address is invalid";
    case "invalid-email":
      return "E-mail address is invalid";
    default:
      return "Login failed. Please try again";
  }
}



   */

  /*
  bool loginValidation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage('Both fields are empty');
    return false;
  } else if (email.isEmpty) {
    showMessage('Email is Empty');
    return false;
  } else if (password.isEmpty) {
    showMessage('Password is Empty');
    return false;
  } else {
    return true;
  }
}

  





  // sign up validation 

   if (_formKey.currentState!.validate()) {
                      bool isValidated = signupValidation(
                        email.text,
                        password.text,
                        name.text,
                        phone.text,
                      );
                      if (isValidated) {
                        bool isSignedUp = await FirebaseAuthHelper.authHelper
                            .signup(
                                name.text, email.text, password.text, context);
                        if (isSignedUp) {
                          Fluttertoast.showToast(
                              msg: 'Registered Successfully');
                          Routes.instance.push(Login(), context);
                        }
                      }
                    }
  
   */