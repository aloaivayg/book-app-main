import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class HttpClient {
  static Map<String, String> headerConfig = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  static getRequest(String url,
      {Map<String, dynamic>? params, Map<String, String>? headers}) async {
    // if(UserCredential.isLogged()) {
    //   headerConfig["User-Authorization-Token"] = UserCredential.userToken!;
    // }
    var requestUrl = Uri.parse(url).replace(queryParameters: params);
    return await http.get(requestUrl, headers: headers ?? headerConfig);
  }

  static postRequest(String url,
      {Map<String, dynamic>? params, Map<String, String>? headers}) async {
    // if(UserCredential.isLogged()) {
    //   headerConfig["User-Authorization-Token"] = UserCredential.userToken!;
    // }
    print(url);
    var requestUrl = Uri.parse(url);
    return await http.post(requestUrl,
        body: jsonEncode(params), headers: headers ?? headerConfig);
  }
}
