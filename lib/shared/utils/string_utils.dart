bool isNumber(String? str) {
  if (str == null) {
    return false;
  }

  if (str.isEmpty) {
    return false;
  }
  
  try {
    double.parse(str);
    return true;
  } catch (e) {
    return false;
  }
  
}
