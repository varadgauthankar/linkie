String? validateURL(String? value) {
  String regEx =
      r'^(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z0-9][a-z0-9-]{0,61}[a-z0-9]$';
  RegExp regex = RegExp(regEx);

  if (value!.isEmpty) {
    return 'Please enter a URL';
  } else if (!regex.hasMatch(value)) {
    return 'Please enter a valid URL';
  } else {
    return null;
  }
}
