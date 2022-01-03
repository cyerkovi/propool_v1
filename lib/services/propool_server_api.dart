import 'package:propool_v1/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:propool_v1/services/secure_storage.dart';
import 'package:propool_v1/utilities/conf_pool_result.dart';
import 'dart:convert';

class ProPoolServer {
  Future<http.Response> requestAuthToken(email, password) async {
    var url = 'https://$kPigskinServerURI/oauth/token';

    http.Response response = await http.post(url, body: {
      'grant_type': 'password',
      'email': email,
      'password': password,
      'client_id': kClientID,
      'client_secret': kClientSecret
      //
    });
    var statusCode = response.statusCode;
    // print('Status code is $statusCode');
    return response;
  }

  Future revokeAuthToken() async {
    String revokeEndpoint = 'oauth/revoke';
    var url = 'https://$kPigskinServerURI/$revokeEndpoint';
    final SecureStorage secureStorage = SecureStorage();
    var accessToken = await secureStorage.readSecureData('access_token');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$kClientID:$kClientSecret'));
    http.Response response = await http.post(url, headers: <String, String>{
      'authorization': '$basicAuth'
    }, body: {
      'token': '$accessToken',
      'client_id': kClientID,
      'client_secret': kClientSecret
    });
    var statusCode = response.statusCode;
    print('Status code from revoke is $statusCode');
    return response;
  }

  Future<String> login(email, password) async {
    String loginReturnStatus;
    http.Response response = await requestAuthToken(email, password);
    String data = response.body;
    // print(data);
    var deCodedData = jsonDecode(data);
    print('deCodedData is');
    print(deCodedData);
    print(deCodedData["access_token"]);
    if (response.statusCode == 200) {
      // store access_token and refresh_token
      final SecureStorage secureStorage = SecureStorage();
      secureStorage.writeSecureData(
          'access_token', deCodedData["access_token"]);
      secureStorage.writeSecureData(
          'refresh_token', deCodedData["refresh_token"]);
      /*
      print('access token data from secure storage is');
      print(await secureStorage.readSecureData('access_token'));
      print('refresh token data from secure storage is');
      print(await secureStorage.readSecureData('refresh_token'));
      */
      loginReturnStatus = 'Success';
    } else if (response.statusCode == 400) {
      loginReturnStatus = 'Invalid Email and/or Password';
    } else if (response.statusCode == 502) {
      loginReturnStatus = 'Service Unavailable - Try again later';
    } else {
      String statusCodeString = response.statusCode.toString();
      loginReturnStatus = 'Login Failure - Status Code $statusCodeString';
    }
    return loginReturnStatus;
  }

  Future logout() async {
    /*
    To log out a user, we can revoke the access token,
     so that the same access token cannot be used anymore.
    To revoke an access token, we need to send a HTTP POST request
     to /oauth/revoke, with token, client_id and client_secret attributes.

    Other than these attributes, we also need to set Authorization
     header for the HTTP request to use Basic Auth, using client_id value
      for the username and client_password value for the password.
     */
    http.Response response = await revokeAuthToken();
    String data = response.body;
    // print('logout response body (data) is');
    // print(data);
    if (data == '{}') {
      print('Success');
      return 'Success';
    } else {
      print('Failure');
      return 'Failure';
    }
  }

  Future getConfPoolResults(endPoint) async {
    var url = 'https://$kPigskinServerURI/$endPoint' + '216';
    final SecureStorage secureStorage = SecureStorage();
    var accessToken = await secureStorage.readSecureData('access_token');
    String bearerAuth = 'Bearer ' + accessToken;
    http.Response response =
        await http.get(url, headers: {'Authorization': '$bearerAuth'});
    if (response.statusCode == 200) {
      String data = response.body;
      // print('response.body is');
      // print(response.body);
      ConfPoolResult confPoolResult = ConfPoolResult.fromJSON(jsonDecode(data));
      return confPoolResult;
    } else {
      print(response.statusCode);
    }
  }

  Future getHomeSeasongameset() async {
    var endPoint = kSeasongamesetShow;
    var url = 'https://$kPigskinServerURI/$endPoint';
    final SecureStorage secureStorage = SecureStorage();
    var accessToken = await secureStorage.readSecureData('access_token');
    String bearerAuth = 'Bearer ' + accessToken;
    http.Response response =
        await http.get(url, headers: {'Authorization': '$bearerAuth'});
    if (response.statusCode == 200) {
      String data = response.body;
      print('response.body is');
      print(response.body);
      // ConfPoolResult confPoolResult = ConfPoolResult.fromJSON(jsonDecode(data));
      //return confPoolResult;
    } else {
      print(response.statusCode);
    }
  }
}
