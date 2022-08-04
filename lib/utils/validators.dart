import 'package:validators/validators.dart';

String? validateURL(String? value) {
  if (value!.isEmpty) {
    return 'Please enter a URL';
  } else if (!isURL(value)) {
    return 'Please enter a valid URL';
  } else {
    return null;
  }
}
