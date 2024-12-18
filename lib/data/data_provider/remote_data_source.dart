import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/auth/auth_state_model.dart';
import 'network_parser.dart';
import 'remote_url.dart';

abstract class RemoteDataSource {
  Future login(AuthStateModel body);

  Future checkUser(AuthStateModel body);

  Future sendOtp(AuthStateModel body);

  Future verifyOtp(AuthStateModel body);

  Future addUser(AuthStateModel body);

  Future logout(String token);

}

typedef CallClientMethod = Future<http.Response> Function();

class RemoteDataSourceImpl extends RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  final headers = {
    // 'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  final postDeleteHeader = {
    'Accept': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  @override
  Future login(AuthStateModel body) async {
    final mapBody = jsonEncode(body.toMap());
    final uri = Uri.parse(RemoteUrls.login);
    final clientMethod = client.post(uri, body: mapBody, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future addUser(AuthStateModel body) async {
    final mapBody = jsonEncode(body.toAddMap());
    final uri = Uri.parse(RemoteUrls.addUser);
    final clientMethod = client.post(uri, body: mapBody, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future checkUser(AuthStateModel body) async {
    final mapBody = jsonEncode({'email': body.email});
    final uri = Uri.parse(RemoteUrls.checkUser);
    final clientMethod = client.post(uri, body: mapBody, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future verifyOtp(AuthStateModel body) async {
    final mapBody = jsonEncode({"email": body.email,"otp": body.otp});
    final uri = Uri.parse(RemoteUrls.verifyOtp);
    final clientMethod = client.post(uri, body: mapBody, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future sendOtp(AuthStateModel body) async {
    final mapBody = jsonEncode({'email': body.email});
    final uri = Uri.parse(RemoteUrls.sendOtp);
    debugPrint('send-otp-body $mapBody - $uri');
    final clientMethod = client.post(uri, body: mapBody, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future logout(String token) async {
    final uri = Uri.parse(RemoteUrls.logout(token));
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }


// @override
// Future<String> updatePropertyRequest(
//     String id, AddPropertyModel data, String token) async {
//   final headers = postDeleteHeader;
//   final uri = Uri.parse(RemoteUrls.updatePropertyUrl(id, token));
//
//   final request = http.MultipartRequest('POST', uri);
//   request.fields.addAll(data.toMap());
//
//   request.headers.addAll(headers);
//
//   if (data.image.isNotEmpty && !data.image.contains('https://')) {
//     final thumbImage =
//         await http.MultipartFile.fromPath('thumbnail_image', data.image);
//     request.files.add(thumbImage);
//   }
//   for (int i = 0; i < data.galleryImage.length; i++) {
//     final element = data.galleryImage[i];
//     if (element.image.isNotEmpty && !element.image.contains('https://')) {
//       final file = await http.MultipartFile.fromPath(
//           'slider_images[$i]', element.image);
//       request.files.add(file);
//     }
//   }
//   if (data.propertyVideoDto.videoThumbnail.isNotEmpty &&
//       !data.propertyVideoDto.videoThumbnail.contains('https://')) {
//     final file = await http.MultipartFile.fromPath(
//         'video_thumbnail', data.propertyVideoDto.videoThumbnail);
//     request.files.add(file);
//   }
//
//   if (data.propertyPlanDto.isNotEmpty) {
//     for (int i = 0; i < data.propertyPlanDto.length; i++) {
//       final element = data.propertyPlanDto[i].planImages;
//       final id = data.propertyPlanDto[i].id;
//       if (element.isNotEmpty && !element.contains('https://')) {
//         final file =
//             await http.MultipartFile.fromPath('plan_images[$i]', element);
//         request.files.add(file);
//       }
//     }
//   }
//
//   http.StreamedResponse response = await request.send();
//   final clientMethod = http.Response.fromStream(response);
//
//   final responseJsonBody =
//       await NetworkParser.callClientWithCatchException(() => clientMethod);
//   return responseJsonBody['message'] as String;
// }

// @override
// Future getPropertyEditInfo(String id, String token) async {
//   final uri = Uri.parse(RemoteUrls.editInfoUrl(id, token));
//
//   final clientMethod = client.get(uri, headers: headers);
//   final responseJsonBody =
//       await NetworkParser.callClientWithCatchException(() => clientMethod);
//   return responseJsonBody;
// }
}
