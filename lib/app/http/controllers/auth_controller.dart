import 'dart:io';

import 'package:vania/src/exception/validation_exception.dart';
import 'package:vania/vania.dart';
import 'package:vania_ecommerce_api/app/models/user.dart';

class AuthController extends Controller {
  Future<Response> register(Request request) async {
    try {
      request.validate({
        'name': 'required|string|alpha',
        'email': 'required|email',
        'password': 'required|string',
      }, {
        'name.required': 'Name is required',
        'name.string': 'Name must be a string',
        'name.alpha': 'Name must contain only alphabetic characters',
        'email.required': 'Email is required',
        'email.email': 'Invalid email format',
        'password.required': 'Password is required',
      });
    } catch (e) {
      if (e is ValidationException) {
        var errorMessage = e.message;
        var errorMessageList = errorMessage.values.toList();
        return Response.json(
            {"message": errorMessage, "status": HttpStatus.unauthorized}, 401);
      } else {
        return Response.json({
          "msg": "an unexcpected d server side error",
          "code": 500,
          "data": "",
        }, 500);
      }
    }

    try {
      final name = request.input('name');
      final email = request.input('email');
      var password = request.input('password');

      print('$name $email $password');
      var user = await User().query().where('email', '=', email).first();
      if (user != null) {
        return Response.json({
          "msg": "Email already exists",
          "code": 409,
          "data": "",
        }, 409);
      }
      password = Hash().make(password);
      // print(password);
      await User().query().insert({
        "name": name,
        "email": email,
        "password": password,
        "avatar": "images/01.png",
        "description": "No user content found",
        "created_at": DateTime.now(),
        "edited_at": DateTime.now()
      });
      return Response.json(
          {"message": "Register success", "status": 200, "data": ""},
          HttpStatus.ok);
    } catch (e) {
      print('Error: $e');
      return Response.json({
        "msg": "an unexcpected server side error rrr",
        "code": 500,
        "data": "",
      }, 500);
    }
  }

  Future<Response> login(Request request) async {
    try {
      request.validate({
        'email': 'required|email',
        'password': 'required|string',
      }, {
        'email.required': 'Email is required',
        'email.email': 'Invalid email format',
        'password.required': 'Password is required',
      });
    } catch (e) {
      if (e is ValidationException) {
        var errorMessage = e.message;
        var errorMessageList = errorMessage.values.toList();

        return Response.json(
            {"message": errorMessage, "status": HttpStatus.unauthorized}, 401);
      } else {
        return Response.json({
          "msg": "an unexcpected d server side error",
          "code": 500,
          "data": "",
        }, 500);
      }
    }

    try {
      final email = request.input('email');
      var password = request.input('password');

      print('$email $password');
      var user = await User().query().where('email', '=', email).first();
      if (user == null) {
        return Response.json({
          "msg": "User not found",
          "code": 404,
          "data": "",
        }, 404);
      }
      if (!Hash().verify(password, user["password"])) {
        return Response.json({
          "msg": "email or password is wrong!",
          "code": 401,
          "data": "",
        }, 401);
      }

      final auth = Auth().login(user);
      print(auth);

      final token = await auth.createToken(expiresIn: Duration(days: 7));
      String accessToken = token['access_token'];
      return Response.json(
          {"message": "login success", "status": 200, "token": accessToken},
          HttpStatus.ok);
    } catch (e) {
      print('Error: $e');
      return Response.json({
        "msg": "an unexcpected server side error rrr",
        "code": 500,
        "data": "",
      }, 500);
    }
  }

  Future<Response> updatePassword(Request request) async {
    try {
      request.validate({
        'email': 'required|email',
        'password': 'required|string',
      }, {
        'email.required': 'Email is required',
        'email.email': 'Invalid email format',
        'password.required': 'Password is required',
      });
    } catch (e) {
      if (e is ValidationException) {
        var errorMessage = e.message;
        var errorMessageList = errorMessage.values.toList();

        return Response.json(
            {"message": errorMessage, "status": HttpStatus.unauthorized}, 401);
      } else {
        return Response.json({
          "msg": "an unexcpected d server side error",
          "code": 500,
          "data": "",
        }, 500);
      }
    }

    try {
      final email = request.input('email');
      var password = request.input('password');

      print('$email $password');
      var user = await User().query().where('email', '=', email).first();
      if (user == null) {
        return Response.json({
          "msg": "User not found",
          "code": 404,
          "data": "",
        }, 404);
      }

      await User()
          .query()
          .where('email', '=', email)
          .update({"password": Hash().make(password)});

      return Response.json(
          {"message": "update success", "status": 200, "token": ""},
          HttpStatus.ok);
    } catch (e) {
      print('Error: $e');
      return Response.json({
        "msg": "an unexcpected server side error rrr",
        "code": 500,
        "data": "",
      }, 500);
    }
  }
}

final AuthController authController = AuthController();
