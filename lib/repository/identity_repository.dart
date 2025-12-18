import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/identity.dart';
import '../utils/api_call.dart';
import 'dart:convert';
import 'package:path/path.dart';

class IdentityRepository {

  /// Register identity with file upload
  Future<bool> registerIdentity(
      Map<String, dynamic> data, File? file, String token) async {
    try {
      final uri = Uri.parse(ApiCall.identityApi);

      // Create multipart request
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      // Add normal fields
      data.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Add file if present
      if (file != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'identity_document',
            file.path,
            filename: basename(file.path),
          ),
        );
      }

      // Send request
      final response = await request.send();
      final respStr = await response.stream.bytesToString();

      final jsonResp = json.decode(respStr);

      if (response.statusCode == 201 && jsonResp['success'] == true) {
        return true;
      } else {
        print("REGISTER IDENTITY FAILED: $jsonResp");
        return false;
      }
    } catch (e, stack) {
      print("REGISTER IDENTITY ERROR: $e");
      print(stack);
      return false;
    }
  }

  Future<List<IdentityModel>> fetchIdentities(String token) async {
    try {
      final uri = Uri.parse(ApiCall.identityApi);

      final response = await http.get(
        uri,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      print("RESPONSE: ${response.body}");

      final jsonResp = json.decode(response.body);

      if (response.statusCode == 200 && jsonResp["success"] == true) {
        final List dataList = jsonResp["data"] ?? [];
        return dataList.map((e) => IdentityModel.fromJson(e)).toList();
      } else {
        print("FETCH IDENTITIES FAILED: $jsonResp");
        return [];
      }
    } catch (e, stack) {
      print("FETCH IDENTITIES ERROR: $e");
      print(stack);
      return [];
    }
  }

}
