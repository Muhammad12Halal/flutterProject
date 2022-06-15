// ignore_for_file: unnecessary_new
String? validateEmail(value) {
  String? msg;

  RegExp regex = new RegExp(
  r"(\w+)");
  if (value.isEmpty) {
    msg = "Your Email is required";
  } else if (!regex.hasMatch(value)) {
    msg = "Please provide a valid email address";
  }
  return msg;
}
