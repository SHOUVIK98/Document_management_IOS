import 'dart:core';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class IKonService {
  late String _tempTicket;
  late String _ticket;
  late String _softwareId ;
  late final String _globalAccountId = 'b8bbe5c9-ad0d-4874-b563-275a86e4b818';
  late String  _softwareName = "Document Management";
  late String _versionNumber = "1";
  static final IKonService iKonService = new IKonService();



  final String restUrl = "https://ikoncloud-uat.keross.com/rest";
  final String downloadUrl = 'https://ikoncloud-uat.keross.com/download';

  // Hashes the input string using SHA-512.
  Future<String> _hashPassword(String content) async {
    try {
      final bytes = utf8.encode(content);
      final digest = sha512.convert(bytes);
      return digest.toString();
    } catch (error) {
      throw Exception('Hashing failed: $error');
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      // Hash the password
      final hashedPassword = await _hashPassword(password);

      // Define headers
      final headers = {
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
      };

      // Define query parameters
      final params = {
        "inZip": "false",
        "outZip": "true",
        "inFormat": "xml",
        "outFormat": "typedjson",
        "service": "loginService",
        "operation": "login",
        "locale": "en_US",
      };

      // Construct the credential XML string
      final credential = '''
<list>
  <string>
    <content><![CDATA[$username]]></content>
  </string>
  <string>
    <content><![CDATA[$hashedPassword]]></content>
  </string>
</list>
'''.trim().replaceAll(RegExp(r'\s+'), '');

      // Encode the parameters into the URL
      final uri = Uri.parse(restUrl).replace(queryParameters: params);

      // Encode the body as application/x-www-form-urlencoded
      final body = {'arguments': credential};

      // Make the POST request
      final response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Navigate through the JSON structure to find the temporaryTicket
        final tempTicket = responseData['value']?['temporaryTicket']?['value'];
        final ticket = responseData['value']?['ticket']?['value'];

        if (tempTicket != null && tempTicket is String) {
          // Store the temporaryTicket securely
          this._tempTicket = tempTicket;
          return true;
        }

        else if(ticket != null && ticket is String) {
          this._ticket = ticket;

           _softwareId = await  _getSoftwareId(_softwareName, _versionNumber);
          return true;
        }

        else {
          // Temporary ticket not found in response
          return false;
        }
      } else {
        // Handle non-200 responses
        return false;
      }
    } catch (e) {
      // Handle any exceptions
      print('Login error: $e');
      return false;
    }
  }

  Future<bool> validateOtp(String otp) async {
    try {
      // Define headers
      final headers = {
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
      };

      // Retrieve the temporaryTicket from secure storage
      final temporaryTicket = this._tempTicket;
      if (temporaryTicket == null) {
        return false;
      }

      // Define query parameters
      final params = {
        "inFormat": "xml",
        "inZip": "false",
        "locale": "en_US",
        "operation": "validateOTP",
        "outFormat": "typedjson",
        "outZip": "true",
        "service": "loginService",
      };

      // Construct the credential XML string
      final credential = '''
<list>
  <string>
    <content><![CDATA[$temporaryTicket]]></content>
  </string>
  <string>
    <content><![CDATA[$otp]]></content>
  </string>
</list>
'''.trim().replaceAll(RegExp(r'\s+'), '');

      // Encode the parameters into the URL
      final uri = Uri.parse(restUrl).replace(queryParameters: params);

      // Encode the body as application/x-www-form-urlencoded
      final body = {'arguments': credential};

      // Make the POST request
      final response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Navigate through the JSON structure to find the ticket
        final ticket = responseData['value']?['ticket']?['value'];

        if (ticket != null && ticket is String) {
          // Store the ticket securely
          this._ticket = ticket;
          return true;
        } else {
          // Ticket not found in response
          return false;
        }
      } else {
        // Handle non-200 responses
        return false;
      }
    } catch (e) {
      // Handle any exceptions
      print('OTP Validation error: $e');
      return false;
    }
  }

  Future<bool> resetPassword(String userName) async {
    try {
      // Define headers
      final headers = {
        "User-Agent": "Human",
        "Content-Type": "application/x-www-form-urlencoded",
      };

      // Define query parameters
      final params = {
        "inZip": "false",
        "outZip": "false",
        "inFormat": "freejson",
        "outFormat": "freejson",
        "service": "loginService",
        "operation": "resetPassword",
      };

      // Construct the data
      final data = jsonEncode([userName]); // Equivalent to '["$userName"]'

      // Encode the parameters into the URL
      final uri = Uri.parse(restUrl).replace(queryParameters: params);

      // Encode the body as application/x-www-form-urlencoded
      final body = {'arguments': data};

      // Make the POST request
      final response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      print(response);

      if (response.statusCode == 200) {
        // Optionally, you can parse the response data here
        // For example:
        // final responseData = json.decode(response.body);
        // return responseData;
        return true;
      } else {
        // Handle non-200 responses
        return false;
      }
    } catch (error) {
      print("Error during resetPassword API call: $error");
      throw error;
    }
  }

  Future<String> _getSoftwareId(String softwareName,String versionNumber ) async {
    var headers = {
      'User-Agent': 'IKON Job Server',
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    // Define query parameters
    final params = {
      "inZip": "false",
      "outZip": "false",
      "inFormat": "freejson",
      "outFormat": "freejson",
      "service": "softwareService",
      "operation": "mapSoftwareName",
      "locale":"en_US",
      "activeAccountId":this._globalAccountId,
      "ticket": this._ticket
    };

    final uri = Uri.parse(restUrl).replace(queryParameters: params);

    final body = {
      'arguments': jsonEncode([softwareName,versionNumber])
    };

    // Make the POST request
    final response = await http.post(
      uri,
      headers: headers,
      body: body,
    );

    print(response);
    try{
      if (response.statusCode == 200) {
        // Optionally, you can parse the response data here
        // For example:
        // final responseData = json.decode(response.body);
        // return responseData;
        return response.body.replaceAll('\"', "");
      } else {
        // Handle non-200 responses
        return 'false';
      }
    } catch (error) {
      print("Error during getSoftwareId API call: $error");
      throw error;
    }

  }


  Future<List<Map<String, dynamic>>> getMyInstancesV2({
    required String processName,
    required Map<String, dynamic>? predefinedFilters,
    required Map<String, dynamic>? processVariableFilters,
    required Map<String, dynamic>? taskVariableFilters,
    required String? mongoWhereClause,
    required List<String> projections,
    required bool allInstance,})
    async {
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    final params = {
      "inZip": "false",
      "outZip": "false",
      "inFormat": "freejson",
      "outFormat": "freejson",
      "service": "processRuntimeService",
      "operation": "getMyInstancesV2",
      "softwareId": _softwareId,
      "activeAccountId": _globalAccountId,
      "ticket": _ticket
    };

    try {
      final uri = Uri.parse(restUrl).replace(queryParameters: params);

      final arguments = [
        processName,
        _globalAccountId,
        predefinedFilters,
        processVariableFilters,
        taskVariableFilters,
        mongoWhereClause,
        projections,  // Now using the projections parameter instead of empty array
        allInstance
      ];

      final body = {
        'arguments': jsonEncode(arguments)
      };

      final response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(
            responseData.map((item) => Map<String, dynamic>.from(item))
        );
      } else {
        print('API Error: ${response.statusCode} - ${response.reasonPhrase}');
        throw Exception('Failed to get instances: ${response.reasonPhrase}');
      }
    } catch (error) {
      print("Error during getMyInstances API call: $error");
      throw error;
    }
  }

  String getDownloadUrlForFiles(String resourceId, String resourceName, String resourceType) {
      return downloadUrl + "?ticket=" + _ticket + "&resourceId=" + resourceId + "&resourceName=" + resourceName + "&resourceType=" + resourceType;
  }



  Future<String> mapProcessName({required String processName}) async {
      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };

    final params = {
      "inZip": "false",
      "outZip": "false",
      "inFormat": "freejson",
      "outFormat": "freejson",
      "service": "processRuntimeService",
      "operation": "mapProcessName",
      "ticket": _ticket,
      "activeAccountId": _globalAccountId,
      "softwareId": _softwareId
    };

    try {
      final uri = Uri.parse(restUrl).replace(queryParameters: params);

      final arguments = [
        processName,
        _globalAccountId
      ];

      final body = {
        'arguments': jsonEncode(arguments)
      };

      final response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        return response.body.replaceAll('\"', "");
      } else {
        print('API Error: ${response.statusCode} - ${response.reasonPhrase}');
        throw Exception('Failed to map process name: ${response.reasonPhrase}');
      }
    } catch (error) {
      print("Error during mapProcessName API call: $error");
      throw error;
    }
  }


  Future<bool> startProcessV2({required String processId,
     required dynamic  data,
     required dynamic processIdentifierFields
  })
   async {
    try {
      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      final params = {
        "inZip": "false",
        "outZip": "false",
        "inFormat": "freejson",
        "outFormat": "freejson",
        "service": "processRuntimeService",
        "operation": "startProcessV2",
        "ticket": _ticket,
        "activeAccountId": _globalAccountId,
        "softwareId": _softwareId
      };

      final uri = Uri.parse(restUrl).replace(queryParameters: params);

      final arguments = [
        processId,
        data,
        processIdentifierFields
      ];

      final body = {
        'arguments': jsonEncode(arguments)
      };

      final response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final processInstanceID = jsonDecode(response.body);

        // You might want to check specific conditions in the response
        // to determine if the process started successfully
        if (processInstanceID != null) {
          return true;
        } else {
          print('Process start failed: Invalid response data');
          return false;
        }
      } else {
        print('API Error: ${response.statusCode} - ${response.reasonPhrase}');
        print(response.body);
        return false;
      }
    } catch (error) {
      print("Error during startProcessV2 API call: $error");

      return false;
    }
  }

  Future<bool> invokeAction({
    required String taskId,
    required String transitionName,
    required dynamic  data,
    required dynamic processIdentifierFields})
  async {
    try {
      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      final params = {
        "inZip": "false",
        "outZip": "false",
        "inFormat": "freejson",
        "outFormat": "freejson",
        "service": "processRuntimeService",
        "operation": "invokeAction",
        "ticket": _ticket,
        "activeAccountId": _globalAccountId,
        "softwareId": _softwareId
      };

      final uri = Uri.parse(restUrl).replace(queryParameters: params);

      final arguments = [
        taskId,
        transitionName,
        data,
        processIdentifierFields
      ];

      final body = {
        'arguments': jsonEncode(arguments)
      };

      final response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final processInstanceID = jsonDecode(response.body);

        // You might want to check specific conditions in the response
        // to determine if the process started successfully
        if (processInstanceID != null) {
          return true;
        } else {
          print('Process invoke failed: Invalid response data');
          return false;
        }
      } else {
        print('API Error: ${response.statusCode} - ${response.reasonPhrase}');
        print(response.body);
        return false;


      }
    } catch (error) {
      print("Error during invokeAction API call: $error");
      return false;
    }
  }



}