import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://api.ezuite.com/api/External_Api/Mobile_Api/Invoke';

  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'API_Body': [
            {
              'Unique_Id': '',
              'Pw': password,
            }
          ],
          'Api_Action': 'GetUserData',
          'Company_Code': username,
        }),
      );

      final responseData = jsonDecode(response.body);

      // Check if the response has a Message field
      if (responseData['Message'] != null) {
        return {
          'Status_Code': responseData['Status_Code'] ?? 400,
          'Message': responseData['Message'],
          'Response_Body': responseData['Response_Body'] ?? []
        };
      }

      return responseData;
    } catch (e) {
      return {
        'Status_Code': 500,
        'Message': 'Connection failed. Please check your internet connection.',
        'Response_Body': []
      };
    }
  }
}
