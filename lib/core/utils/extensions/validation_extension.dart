extension Validator on String {
  /// If the password is empty, return a string that says so. Otherwise, return null.
  String? isPasswordValid() {
    if (length == 0) {
      return 'Enter PIN Number';
    }

    if (length < 4) {
      return 'PIN Number Must Contain 4 Numbers';
    }
    return null;
  }

  /// It checks if the mobile number is valid or not.
  String? isMobileValid() {
    if (length == 10 && RegExp(r"^[6-9]\d{9}$").hasMatch(this)) {
      return null;
    }

    if (length == 0) {
      return 'Enter Mobile Number';
    }

    return 'Enter Valid Mobile Number';
  }

  /// This function returns a String if the coupon code is invalid, or null if it's valid.
  String? isCouponCodeValid() {
    if (length == 16 && RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this)) {
      return null;
    }

    if (length == 0) {
      return 'Enter Coupon Code';
    }

    return 'Enter Valid Coupon code';
  }

  String? isTextValid() {
    if (length > 0 && RegExp(r'^[a-zA-Z]').hasMatch(this)) {
      return null;
    }

    if (length == 0) {
      return 'Please Enter Data';
    }

    return 'Please Enter Data';
  }

  String? isAadharValid() {
    if (length == 12 && RegExp(r'^[0-9]').hasMatch(this)) {
      return null;
    }

    if (length == 0) {
      return 'Please Enter Aadhar Number';
    }

    return 'Please Enter Aadhar Number';
  }

  String? isPincodeValid() {
    if (length == 6 && RegExp(r'^[0-9]').hasMatch(this)) {
      return null;
    }

    if (length == 0) {
      return 'Please Enter Pincode';
    }

    return 'Please Enter Pincode';
  }

}
