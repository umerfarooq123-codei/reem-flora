import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:reem_flora/models/cart.dart';
import 'package:reem_flora/models/product_model.dart';

const credentials = r'''
{
  "type": "service_account",
  "project_id": "reem-flora",
  "private_key_id": "009d3c085af0e289eb8e536dd8e61cf72f986f32",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDHRo+GGixCaA8V\ny7zlu+5W2qiVkeSq6xduk7YB66r2YqJQ0wZQuGAhKZOnv93QFRhiYIP+07eClZp/\nZuAMF3Qe/7DbvVJzg9Jlk84o2nJifJR4Psxi9lihkpMVd7SMwHo1fN7lQ2b8H6JU\nWrTdpGabcJiGp/wf9VDS1m35poDAvoayzLEp8c/klreI3Q5UeRCA1+HsMIR6Mgt2\nemTQs1SZgpFq95ALj10s5UF8fibb+d9gf44RJJCduGMx14tHFOsh62hdViHnu+Yb\nBExDpC5QEsXsLte+QwseFoY5rsYS21DZKVTwmEvHlu0ED/s2F6Uc8Hhtox/+41Wz\n8kndxxXpAgMBAAECggEAAPgXfqB6Qg7iQrJszdVHUmaTufEFAqbqACRIdN0q/Ut1\nANt0iEplhWqy7di7xk3NSvCEya437//J0mjCJwLEp8BFaf+gHyRThkxfCLYgt/rL\nwQwEM/E0MF/ESurZ1K5nSK2soktczc1i+1QBRFZXY7yQddymxuyLPanqdwj/G92l\nih8Sp/ktUKp7QTgxVJI9Qo0eMc2nf84L8xhRJj5SykMk2DK3DfAyXNzA2wgpNZny\nVJPnAdEJ+pG7x0ezscR8u3lP7Xdd6yyFoexm+tXvEZOVDTIvoHsnQn0+il+ceWGH\nCW7XjrrkeDP/4hjsL/BrvLh5CPffcnFqEXbO1cG5xQKBgQDmLtrieeGmYEYsA0lF\nXfhQvlSgjP2kVyRMHr0SyjS01d/P/EwF6/x33mEdPPZUcynyKjmQ7eOAH5Qxegxq\nb/UrWmEeGzP0xd/6aKAkiAqrKZfu9EzUGgYWnY+ihd3PMWqQET6F1zqctWdET1Iz\nsDArBRUgJ3asjyU8nh2rnuyrFQKBgQDdoEZgutORg0zLG/7yvviePw54amQmrd3z\nwnX/tq0hY4sOGy5Qt5Ud/lQRW4lJwhlNWfayP7fWeusq1uhD+qC02MKihdl4WRMc\nNw4xy9BQtozc5x5wLuPU6iWz2zZ+Usl7NqvwESV1bhl5bPErzybGwQ+Mt+BtWJZX\nx9fwWYZkhQKBgDY/MpyPJsvEAqWavKjZZYz53g3cTGZvlwFNeTe1ach4Yv+sMOpw\nXBaP1QlD9bWfUnJc2yY5uhTW3GDwp35qFjh6W0ryFEOKYqesApm5afI+oizRbE3M\nOEUaKuCdddG/jqKXPcnjGFAYPFcP7op56lApKXpjcodmUNtBVDK/CH2lAoGAFRCH\nv+fh9gGpyeBGUiIulTPfFzjdfgOmheWku4JMYFEKxXN16nwYczpaGTA/E0CckQqM\n9RIzUfJq6a51cwieP7Iehb39FoA43cSp17fMe+9t4g0hin4ab4E1xit+uXD673gZ\nzX6Dte6aAz2EiqpswBVXegN8FEiIOZ2n+5M2v9UCgYAsgsQJfOi05i2aweSxaSAT\nh31m9dP2VmsUMGmvCOhpUb5kLFtN9JUqV2VWaLLGwI0p09vZZC8U5CxDsHjo+TFD\nTSNJgVFRhHFnRDs7j3rk7njzrMYqgVtFAU+B0ySqY1nYy2WnbkiTpGWYHkduvS1o\nfoGc4WGKdC9saQnwHZnICA==\n-----END PRIVATE KEY-----\n",
  "client_email": "reem-flora@reem-flora.iam.gserviceaccount.com",
  "client_id": "117733231217885294554",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/reem-flora%40reem-flora.iam.gserviceaccount.com"
}
''';
const spredSheetid = "1U7Gy2tXZ3XgVocjeSFdHANK4m00W6dforR_uJiefupg";
Worksheet? worksheet;

class ProductController extends GetxController {
  var productList = <ProductModel>[].obs;
  var cartList = <Cart>[].obs;
  var loading = true.obs;
  var isError = false.obs;
  var errorString = ''.obs;

  Future<void> getAllProducts() async {
    loading(true);
    try {
      var client = http.Client();
      var url =
          Uri.parse("https://49d6-171-50-214-224.ngrok.io/flowers?page=2");
      var response = await client.get(
        url,
        headers: {"Access-Control-Allow-Origin": "*"},
      );
      var json = response.body;
      var result = productModelFromJson(json);
      if (response.statusCode == 200) {
        for (var i = 0; i < result.length; i++) {
          productList.add(
            ProductModel.fromJson(
              result[i],
            ),
          );
          cartList.add(
            Cart.fromJson(
              result[i],
            ),
          );
        }
      } else {
        isError(true);
      }
      // final gSheet = GSheets(credentials);
      // final spreadSheet = await gSheet.spreadsheet(spredSheetid);
      // worksheet = spreadSheet.worksheetByTitle('products_export_1');
      // final products = await worksheet!.values.map.allRows();
      // debugPrint(productList.length.toString());
      loading(false);
    } on Exception catch (e) {
      isError(true);
      loading(false);
      errorString.value = e.toString();
      debugPrint(e.toString());
    }
  }

  @override
  void onInit() {
    getAllProducts();
    super.onInit();
  }
}
