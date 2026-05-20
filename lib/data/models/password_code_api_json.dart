import 'auth.dart';

/// Builds API body for password code delivery (exactly one field).
Map<String, dynamic> passwordCodeRequestToApiJson(PasswordCodeRequest request) {
  final body = <String, dynamic>{};
  if (request.mobileNumber != null && request.mobileNumber!.trim().isNotEmpty) {
    body['MobileNumber'] = request.mobileNumber;
  } else if (request.email != null && request.email!.trim().isNotEmpty) {
    body['Email'] = request.email;
  } else if (request.username != null && request.username!.trim().isNotEmpty) {
    body['Username'] = request.username;
  }
  return body;
}

/// Validates that exactly one of mobileNumber, email, username is provided.
bool isValidPasswordCodeRequest(PasswordCodeRequest request) {
  final count = [
    request.mobileNumber,
    request.email,
    request.username,
  ].where((v) => v != null && v.trim().isNotEmpty).length;
  return count == 1;
}
