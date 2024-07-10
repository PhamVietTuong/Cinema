class Validation {
  
  static bool isValidPassword(String password) {
    final regex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return regex.hasMatch(password);
  }

 static bool isValidEmail(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return regex.hasMatch(email);
  }

 static bool isValidPhone(String phone) {
    final regex = RegExp(r'^\d{10}$'); // Kiểm tra số điện thoại 10 chữ số
    return regex.hasMatch(phone);
  }

static  bool isValidUsername(String username) {
    final RegExp regex = RegExp(r'^[a-zA-Z0-9_]{8,20}$');
    return regex.hasMatch(username);
  }
}