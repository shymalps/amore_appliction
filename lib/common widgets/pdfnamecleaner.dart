import 'dart:convert';

///the api response of note url is contained with extra sympols like brackets and hashes it will clean the url and provide the actual url
String cleanresponse(String? data) {
  String result = '';
  String pdf = '';
  if (data != null) {
    // String pdf = jsonDecode(data);
    result = data.replaceAll('[', '').replaceAll(']', '');
    pdf = jsonDecode(result);
  }
  print(pdf);
  return pdf;
}

///it check the given url is pdf or img an give coresponding viewer
