import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// class to make requests to the my API
class ApiController {

  //function to create a new user - sending a post request to the API
  Future<bool> createNewUser(
      {required final String email,
      required final String studentID,
      required final String dob,
      required final String major,
      required final String bestMovie,
      required final String bestFood,
      required final String compassRes,
      required final String password,
      required final String yearClass,
      // required final String imageUrl,
      required final String fullName}) async {
    final http.Response response = await http.post(
      Uri.parse(
          'https://us-central1-ash-social-net.cloudfunctions.net/ash_network/profile'),

      //body - in Json format
      body: jsonEncode(
        <String, dynamic>{
          'student-id': studentID,
          'dob': dob,
          'major': major,
          'best-movie': bestMovie,
          'best-food': bestFood,
          'compass-resident': compassRes,
          'class': yearClass,
          'full-name': fullName,
          'email': email
        },
      ),
    );
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }


  //fundtion to retrieve a user from the database using the API
  Future<http.Response?> getUser({required String email}) async {
    try {
      String url =
          'https://us-central1-ash-social-net.cloudfunctions.net/ash_network/profile/$email';
      final http.Response response = await http.get(Uri.parse(url));
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  //function to update an existing user
  Future<bool> updateUser({
    required final String email,
    required final String studentID,
    required final String major,
    required final String bestMovie,
    required final String bestFood,
  }) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(
            'https://us-central1-ash-social-net.cloudfunctions.net/ash_network/userUpdate'),
        body: jsonEncode(
          <String, dynamic>{
            'student-id': studentID,
            'major': major,
            'best-movie': bestMovie,
            'best-food': bestFood,
            'email': email
          },
        ),
      );
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  //function to create a new message
  Future<bool> createNewMessage(
      {required final String email,
      required final String datePosted,
      required final String messageBody,
      required final String fullName}) async {
    final http.Response response = await http.post(
      Uri.parse(
          'https://us-central1-ash-social-net.cloudfunctions.net/ash_network/message'), //unique identifier of the API (Cloud Firebase Legacy)

      //body - in Json format
      body: jsonEncode(
        <String, dynamic>{
          'date-send': datePosted,
          'message-body': messageBody,
          'sender-name': fullName,
          'sender-email': email
        },
      ),
    );
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //function to delete a message
  Future<http.Response?> deleteMessage({required String msgId}) async {
    try {
      String url =
          'https://us-central1-ash-social-net.cloudfunctions.net/ash_network/message/$msgId';
      final http.Response response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
