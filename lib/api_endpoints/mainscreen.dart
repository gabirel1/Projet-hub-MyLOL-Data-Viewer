import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_op_gg/utils/api_utils.dart';

class MainScreenAPI {
  MaterialColor colorEUW = Colors.red;
  MaterialColor colorNA = Colors.red;
  MaterialColor colorEUNE = Colors.red;
  MaterialColor colorKR = Colors.red;

  MainScreenAPI();

  fetch() async {
    try {
      var response = await getAPI("status/v3/shard-data", server: "euw1");
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        if (body['services'][0]['status'] == "online") {
          colorEUW = Colors.green;
        } else {
          colorEUW = Colors.red;
        }
      }
      var response2 = await getAPI("status/v3/shard-data", server: "na1");
      if (response2.statusCode == 200) {
        var body = json.decode(response2.body);
        if (body['services'][0]['status'] == "online") {
          colorNA = Colors.green;
        } else {
          colorNA = Colors.red;
        }
      }
      var response3 = await getAPI("status/v3/shard-data", server: "eun1");
      if (response3.statusCode == 200) {
        var body = json.decode(response3.body);
        if (body['services'][0]['status'] == "online") {
          colorEUNE = Colors.green;
        } else {
          colorEUNE = Colors.red;
        }
      }
      var response4 = await getAPI("status/v3/shard-data", server: "kr");
      if (response4.statusCode == 200) {
        var body = json.decode(response4.body);
        if (body['services'][0]['status'] == "online") {
          colorKR = Colors.green;
        } else {
          colorKR = Colors.red;
        }
      }
    } catch (e) {
      print("error $e");
    }
  }

  MaterialColor getColorEUW() {
    return colorEUW;
  }

  MaterialColor getColorNA() {
    return colorNA;
  }

  MaterialColor getColorEUNE() {
    return colorEUNE;
  }

  MaterialColor getColorKR() {
    return colorKR;
  }
}
