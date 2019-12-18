import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:exchanger2/constants/endpoints.dart';
import 'package:exchanger2/model/transaction.dart';
import 'package:exchanger2/scaffscreens/user_verification_screen.dart';
import 'package:exchanger2/utils/common.dart';
import 'package:exchanger2/utils/resthttp/model/valorerror.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:exchanger2/utils/resthttp/superhttp.dart' as REST;
import 'package:shared_preferences/shared_preferences.dart' as SP;
import 'package:dio/dio.dart' as DIO;
import 'package:exchanger2/utils/resthttp/model/apierror.dart';
import 'package:http_parser/http_parser.dart' as parser;
import 'package:url_launcher/url_launcher.dart' as ul;
import 'package:exchanger2/scaffscreens/SELL_SCREEN.DART';

enum BuyType { Premium, Perfect }

class User with ChangeNotifier {
  bool _isAuth = false;
  String _id;
  String _token;
  SP.SharedPreferences _prefs;
  Map<String, dynamic> _userInfo;
  int _orderCount = 0;
  int _messageCount = 0;

  User() {}

  String get token {
    return _token;
  }

  bool get isVerifying {
    if (_userInfo == null) {
      return false;
    }
    if (_userInfo['cardnumbers'].length == 0 &&
        _userInfo['nationalcode'].length == 0 &&
        _userInfo['selfi'].length == 0) {
      return false;
    }
    return true;
  }

  bool get isLoaded {
    return _userInfo != null;
  }

  int get ordersCount {
    return _orderCount;
  }

  String get maxTarakonesh {
    if (_userInfo == null) return "0 \$";
    return "\$" + _userInfo['limit'].toString();
  }

  Future<dynamic> init() async {
    _prefs = await SP.SharedPreferences.getInstance();
    if (!_prefs.containsKey('token')) {
      _isAuth = false;
      _token = null;
      _userInfo = null;
      return "no token";
    }
    _isAuth = true;
    _token = _prefs.getString('token');

    await getOrders();
    await getModiriatMessages(ErrorHandlingType.Future);

    return await updateUserInfo();
  }

  bool get isUserAuthenticated {
    return _isAuth;
  }

  Future<bool> saveToken(String value) async {
    if (_prefs == null) {
      _prefs = await SP.SharedPreferences.getInstance();
    }
    return _prefs.setString('token', value);
  }

  Future<bool> logOut() async {
    if (_prefs == null) {
      _prefs = await SP.SharedPreferences.getInstance();
    }
    return _prefs.clear().then((val) async {
      await init();
      notifyListeners();
      return val;
    });
  }

  bool get isUserVerified {
    if (_userInfo == null) return false;
    return _userInfo['verify'];
    /*
    List<bool> s = showWhichVerifyPrams;
    return (!s[0] && !s[1] && !s[2]);
    */
  }

  int get messagesCount {
    return _messageCount;
  }

  String get accountName {
    if (_userInfo == null) return "No name is avalable";
    return _userInfo['firstname'] + " " + _userInfo['lastname'];
  }

  List<bool> get showWhichVerifyPrams {
    if (_userInfo == null) return [true, true, true];
    List<bool> retval = [true, true, true];
    if ((_userInfo['cardnumbers'] as List<dynamic>).length > 0) {
      retval[0] = !(_userInfo['cardnumbers'][0]['accept']);
    }
    if ((_userInfo['nationalcode'] as List<dynamic>).length > 0) {
      retval[1] = !_userInfo['nationalcode'][0]['accept'];
    }
    if ((_userInfo['selfi'] as List<dynamic>).length > 0) {
      retval[2] = !_userInfo['selfi'][0]['accept'];
    }
    return retval;
  }

  Future<dynamic> notifyAuthentication() async {
    await init();
    notifyListeners();
  }

  Future<dynamic> updateUserInfo() async {
    if (_token == null) {
      return Future.error("No token found");
    }
    return await REST.get(CREATE_ACCOUNT,
        headers: {'x-auth-token': _token}).then((response) {
      var res = response.response;
      var body = (json.decode(res.body) as Map<String, dynamic>);
      if (res.statusCode > 200)
        return ResponseOrError(error: ApiError(message: body["err"]));
      _userInfo = body;
      notifyListeners();
      return "ok";
    });
  }

  Future<dynamic> createAccount(
      List<String> values, ErrorHandlingType eht) async {
    try {
      return await http.post(
        CREATE_ACCOUNT,
        body: {
          'phonenumber': values[0],
          'firstname': values[1],
          'lastname': values[2],
        },
      ).then((res) {
        var body = (json.decode(res.body) as Map<String, dynamic>);
        if (res.statusCode > 200) throw body['err'];
        _id = body['_id'].toString();
        print("id : create :" + (_id == null ? "null" : _id));
        return "ok";
      }).catchError((e) => throw e);
    } on Exception catch (e) {
      if (eht == ErrorHandlingType.Throw) {
        CommonUtils.printAndThrowError(e);
      } else if (eht == ErrorHandlingType.Future) {
        return Future.error(e);
      }
    }
  }

  Future<dynamic> verifyAccountByPhoneNumber(
      String phonenumber, ErrorHandlingType eht) async {
    try {
      return await http.post(
        VERIFY_PHONE_NUMBER,
        body: {
          'phonenumber': phonenumber,
        },
      ).then((res) {
        var body = (json.decode(res.body) as Map<String, dynamic>);
        if (res.statusCode > 200) throw body['err'];
        _id = body['_id'].toString();
        print("_id(signin):" + (_id == null ? "null" : _id));
        return "ok";
      }).catchError((e) => throw e);
    } catch (e) {
      if (eht == ErrorHandlingType.Throw) {
        CommonUtils.printAndThrowError(e);
      } else if (eht == ErrorHandlingType.Future) {
        return Future.error(e);
      }
    }
  }

  Future<dynamic> sendSmsCode(String code, ErrorHandlingType eht) async {
    print(code);
    print("_id" + (_id == null ? "null" : _id));
    try {
      return await http.post(
        VERIFY_SENT_PHONE_NUMBER,
        body: {
          '_id': _id,
          'code': code,
        },
      ).then((res) async {
        var body = (json.decode(res.body) as Map<String, dynamic>);
        if (res.statusCode > 200) throw body['err'];
        await saveToken(body['jwt'].toString());
        notifyAuthentication();
      }).catchError((e) => throw e);
    } catch (e) {
      print(e);
      if (eht == ErrorHandlingType.Throw) {
        CommonUtils.printAndThrowError(e);
      } else if (eht == ErrorHandlingType.Future) {
        return Future.error(e);
      }
    }
  }

  Future<dynamic> getModiriatMessages(ErrorHandlingType eth) async {
    try {
      return await http
          .get(INBOX, headers: {'x-auth-token': _token}).then((res) {
        if (res.statusCode > 200) {
          throw (json.decode(res.body) as Map<dynamic, dynamic>)['err'];
        }
        var retval = json.decode(res.body) as List<dynamic>;
        _messageCount = retval.length;
        return retval;
      }).catchError((err) => throw err);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<dynamic> getTransactionList(ErrorHandlingType eht) async {
    try {
      return await http
          .get(TRANSACTION, headers: {'x-auth-token': _token}).then((res) {
        if (res.statusCode > 200) {
          throw (json.decode(res.body) as Map<dynamic, dynamic>)['err'];
        }
        var body = json.decode(res.body) as Map<dynamic, dynamic>;
        var transaction = body['transaction'] as List<dynamic>;

        List<TransactionItem> items = [];
        transaction.forEach((item) {
          items.add(TransactionItem(
              item['type'] == "buy" ? Status.Buy : Status.Sell,
              DateTime.parse(item['date']),
              item['amountofpurchase'].toString(),
              item['activationcode'],
              item['typeofpayment'] == "perfectmoney"
                  ? Payment.Perfect
                  : Payment.Premium,
              item['transactionnumber']));
        });
        return items;
      });
    } catch (e) {
      if (eht == ErrorHandlingType.Throw) {
        CommonUtils.printAndThrowError(e);
      } else if (eht == ErrorHandlingType.Future) {
        return Future.error(e);
      }
    }
  }

  Future<dynamic> getWalletInfo(ErrorHandlingType eht) async {
    try {
      return await updateUserInfo().catchError((e) => throw e).then((_) {
        print(_userInfo);
        return _userInfo['wallet']['amount'];
      });
    } catch (e) {
      if (eht == ErrorHandlingType.Throw) {
        CommonUtils.printAndThrowError(e);
      } else if (eht == ErrorHandlingType.Future) {
        return Future.error(e);
      }
    }
  }

  Future<dynamic> increaseWallet(int price) {
    try {
      return http.post(BANK,
          body: {'amount': price.toString()},
          headers: {'x-auth-token': _token}).then((res) async {
        if (res.statusCode > 200) {
          throw (json.decode(res.body) as Map<dynamic, dynamic>)['err'];
        }
        var body = json.decode(res.body) as Map<dynamic, dynamic>;
        if (await ul.canLaunch(body['url'])) await ul.launch(body['url']);
        return "ok";
      }).catchError((e) => throw e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<dynamic> getBuyTypes(
      double _regularCount, double _premiumCount) async {
    try {
      var body = {
        'amount': _regularCount != 0
            ? _regularCount.toString()
            : _premiumCount.toString(),
        'type': _premiumCount != 0 ? "1" : "0",
        'x-auth-token': _token,
      };
      return await http.get(PAYTYPES, headers: body).then((res) {
        if (res.statusCode > 200) {
          throw (json.decode(res.body) as Map<dynamic, dynamic>)['err'];
        }
        return json.decode(res.body) as List<dynamic>;
      }).catchError((err) => err);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<dynamic> buy(BuyType bt, double amount, int type) async {
    //1 kif , 2 tarkib , 3 bank,
    try {
      return await http.post(BUY, body: {
        'amount': amount.toString(),
        'type': bt == BuyType.Premium ? "1" : "0",
        'status': type.toString(),
      }, headers: {
        'x-auth-token': _token
      }).then((res) async {
        if (res.statusCode > 200) {
          throw (json.decode(res.body) as Map<dynamic, dynamic>)['err'];
        }
        var body = json.decode(res.body) as Map<dynamic, dynamic>;
        if (type == 3 || type == 2) {
          if (await ul.canLaunch(body['url'])) {
            await ul.launch(body['url']);
            return "Wait For Redirect To Bank Gateway";
          }
        }
        return "Sucess!\nActivation code: ${body['activationcode']}\nVoucher Code: ${body['code']}";
      }).catchError((e) => throw e);
    } catch (e) {
      return Future.error(e);
    }
  }

  //double error
  Future<dynamic> getCartsByNum(String amount) async {
    await updateUserInfo();
    List<Map<String, Object>> retval = [];
    if (int.parse(amount) <= 15000000) {
      _userInfo['cardnumbers'].forEach((e) {
        retval.add({
          'display': e['cardnumber'],
          'value': [e['sheba'], e['cardnumber']],
        });
      });
      return retval;
    }
    _userInfo['cardnumbers'].forEach((e) {
      if (e['sheba'] == "") return;
      retval.add({
        'display': e['cardnumber'],
        'value': [e['sheba'], e['cardnumber']],
      });
    });
    return retval;
  }

  Future<dynamic> redeemMoney(String amount, dynamic cart) async {
    return await http.post(REEDOM, headers: {
      'x-auth-token': _token
    }, body: {
      'amount': amount,
      'cardnumber': cart[1],
      'sheba': cart[0]
    }).then((res) {
      if (res.statusCode > 200) throw CommonUtils.extractErrorMessage(res);
      return "درخواست ثبت شد!";
    });
  }

  Future<dynamic> getPrices() async {
    try {
      return await http.get(PRICES).then((res) {
        if (res.statusCode > 200) {
          throw (json.decode(res.body) as Map<dynamic, dynamic>)['err'];
        }
        return ((json.decode(res.body) as Map<dynamic, dynamic>)['data']
            as Map<dynamic, dynamic>);
      }).catchError((e) => throw e);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<dynamic> sell(
      SellType sellType, String activationCode, String voucherCode) async {
    try {
      await http.post(SELL, headers: {
        'x-auth-token': _token
      }, body: {
        'type': sellType == SellType.Premium ? "1" : "0",
        'activationcode':
            activationCode == null ? "" : activationCode.toString(),
        'voucher': voucherCode,
      }).then((res) {
        if (res.statusCode > 200) {
          throw (json.decode(res.body) as Map<dynamic, dynamic>)['err'];
        }
        return "Sold!";
      }).catchError((err) {
        throw err;
      });
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<dynamic> _verify(
      String url, dynamic data, VerificationState state) async {
    return await DIO.Dio()
        .post(url,
            data: data, options: DIO.Options(headers: {'x-auth-token': _token}))
        .then((res) {
      return null;
    }).catchError((err) {
      return CommonUtils.extractErrorMessage(err.response);
    });
  }

  Future<dynamic> varifyUser(List<File> _files, List<String> _numbers,
      ErrorHandlingType eht, VerificationState state) async {
    dynamic error;
    if (_files[0].path != "") {
      error = await _verify(USER_VERIFY_FILE[0],
          _createVerificationData(_files[0], _numbers, state), state);
      if (error != null) {
        print('card');
        return error;
      }
    }

    if (_files[1].path != "") {
      error = await _verify(USER_VERIFY_FILE[1],
          _createVerificationData(_files[0], _numbers, state), state);
      if (error != null) {
        print('code');
        return error;
      }
    }

    if (_files[2].path != "") {
      error = await _verify(USER_VERIFY_FILE[2],
          _createVerificationData(_files[0], _numbers, state), state);
      if (error != null) {
        print('selfi');
        return error;
      }
    }
    notifyVerififcation();
    return "ثبت شد!";
  }

  dynamic _createVerificationData(
      File file, List<String> _numbers, VerificationState state) {
    return DIO.FormData.fromMap({
      'file': DIO.MultipartFile.fromFileSync(file.path,
          contentType: parser.MediaType.parse('image/jpeg')),
      'sheba': _numbers[1],
      'cardnumber': _numbers[0],
      'nationalcode': _numbers[2],
      'state': state.toString().split("VerificationState.")[1]
    });
  }

  Future<dynamic> getBillList() async {
    try {
      return await http
          .get(TRANSACTION, headers: {'x-auth-token': _token}).then((res) {
        if (res.statusCode > 200) {
          throw (json.decode(res.body) as Map<dynamic, dynamic>)['err'];
        }
        var body = json.decode(res.body) as Map<dynamic, dynamic>;
        var transaction = body['bill'] as List<dynamic>;

        List<dynamic> items = [];
        transaction.forEach((item) {
          items.add(item as Map<dynamic, dynamic>);
        });
        return items;
      });
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<dynamic> getWalletList() async {
    try {
      return await http
          .get(TRANSACTION, headers: {'x-auth-token': _token}).then((res) {
        if (res.statusCode > 200) {
          throw (json.decode(res.body) as Map<dynamic, dynamic>)['err'];
        }
        var body = json.decode(res.body) as Map<dynamic, dynamic>;
        var transaction = body['wallet'] as List<dynamic>;

        List<dynamic> items = [];
        transaction.forEach((item) {
          items.add(item as Map<dynamic, dynamic>);
        });
        return items;
      });
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<dynamic> editName(String first, String last) async {
    try {
      return await http.post(USEREDIT,
          headers: {'x-auth-token': _token},
          body: {'firstname': first, 'lastname': last}).then((res) async {
        if (res.statusCode > 200) {
          throw (json.decode(res.body) as Map<dynamic, dynamic>)['err'];
        }
        await updateUserInfo();
        return "موفقیت!";
      });
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<dynamic> getOrders() async {
    try {
      return await http
          .get(GETPERFECTORDERS, headers: {'x-auth-token': _token}).then((res) {
        if (res.statusCode > 200) {
          throw (json.decode(res.body) as Map<dynamic, dynamic>)['err'];
        }
        var retval = json.decode(res.body) as List<dynamic>;
        _orderCount = retval.length;
        return retval;
      }).catchError((err) {
        return err;
      });
    } catch (e) {
      return Future.error(e);
    }
  }

  void notifyVerififcation() async {
    await updateUserInfo();
  }
}
