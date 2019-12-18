import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:validators/validators.dart' as validator;

enum ErrorHandlingType { Throw, Future }

class CommonUtils {
  static String phoneNumberValidator(String phone) {
    return null;
  }

  static String creditValidator(String credit) {
    credit = credit.trim();
    if (!validator.isInt(credit)) {
      return "لطفا عدد وارد کنید!";
    }
    if (int.parse(credit) < 10000) {
      return "مقداری بیش تر از ۱۰۰۰۰ وارد کنید.";
    }
    return null;
  }

  static String shebaValidator(String sheba) {
    return null;
    sheba = sheba.replaceAll(" ", "");
    if (sheba.length != 28) {
      return "شماره شبا معتبر وارد کنید.";
    }
    if (!validator.isAlphanumeric(sheba)) {
      return "شماره شبا معتبر وارد کنید.";
    }
    if (!sheba.startsWith("IR")) {
      return "شماره شبا معتبر وارد کنید.";
    }
    if (!validator.isNumeric(sheba.split("IR")[1])) {
      return "شماره شبا معتبر وارد کنید.";
    }
    return null;
  }

  static String humanifyMapString(dynamic x){
    
  }

  static dynamic extractErrorMessage(dynamic response) {
    var body;
    try{
      response as Response;
      body = response.body;
    }catch(err){
      body = response.toString();
    }
    try {
      return (json.decode(body) as Map<dynamic, dynamic>)['err'];
    } catch (e) {
      return "Error!";
    }
  }

  static String humanifyErrorMessage(dynamic error){
    print(error);
    if(error.toString().contains("SocketException") && error.toString().contains("Network is unreachable")){
      return "No Internet Connection!";
    }else if(error.toString().contains("SocketException") || error.toString().contains("HttpException") || error.toString().contains("HttpsException")){
      return "Unknown Error Accured!";
    }
    return error.toString();
  }

  static String bankCartNumberValidator(String sheba) {
    return null;
    if (!validator.isNumeric(sheba)) {
      return "شماره کارت معتبر وارد کنید.";
    }
    if (sheba.length != 16) {
      return "شماره کارت معتبر وارد کنید.";
    }
    return null;
  }

  static String plainStringValidator(String text) {
    return null;
    if (validator.isAlphanumeric(text)) {
      return "متن معتبر نیست";
    }
    return null;
  }

  static double min(double a, double b) {
    if (a >= b) return b;
    return a;
  }

  static double max(double a, double b) {
    if (a <= b) return b;
    return a;
  }

  static void printAndThrowError(Exception e) {
    print(e);
    throw e;
  }

  static void showSnackBarWithError(String errMessage, BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(errMessage),
        duration: Duration(milliseconds: errMessage.length * 60),
      ),
    );
  }

  static String createReadablePrice(String price) {
    String priceBeforeDot = "";
    if (price.contains(".")) {
      priceBeforeDot = price.split(".")[1];
      price = price.split(".")[0];
    }
    for (int i = price.length - 3; i > 0; i -= 3) {
      price = price.substring(0, i) + "," + price.substring(i);
    }
    return price + (priceBeforeDot == "" ? "" : ".$priceBeforeDot");
  }
}
