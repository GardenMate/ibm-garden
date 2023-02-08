import 'dart:convert';

import 'package:build_my_garden/service/base_url_service.dart';
import 'package:build_my_garden/service/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:http/http.dart' as http;

class BrainTreeService {
  Future<PaymentResponse> postPayment(
    String paymentMethodNonce,
    String amount,
    String currency,
  ) async {
    // POST request for payment
    // Get token for authentication
    String? token = await SecureStorage.getToken();

    var response =
        await http.post(Uri.parse("$baseUrl/api/braintree/payment/"), headers: {
      'Authorization': 'Token $token',
    }, body: {
      "paymentMethodNonce": paymentMethodNonce,
      "amount": amount,
      "currency": currency,
    });
    return PaymentResponse.fromJson(jsonDecode(response.body));
  }
}

class PaymentResponse {
  String result;
  String? message;

  PaymentResponse({required this.result, this.message});

  factory PaymentResponse.fromJson(mapOfBody) {
    return PaymentResponse(
      result: mapOfBody['result'],
      message: mapOfBody['message'],
    );
  }
}

void showNonce(
    BraintreePaymentMethodNonce nonce, PaymentResponse response, context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text('Payment Report'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Result: ${response.result}'),
          SizedBox(height: 16),
          Text('Message: ${response.message}'),
          SizedBox(height: 16),
          Text('Type label: ${nonce.typeLabel}'),
          SizedBox(height: 16),
          Text('Description: ${nonce.description}'),
        ],
      ),
    ),
  );
}
