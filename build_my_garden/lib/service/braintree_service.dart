import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';

void showNonce(BraintreePaymentMethodNonce nonce, context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text('Payment method nonce:'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Nonce: ${nonce.nonce}'),
          SizedBox(height: 16),
          Text('Type label: ${nonce.typeLabel}'),
          SizedBox(height: 16),
          Text('Description: ${nonce.description}'),
        ],
      ),
    ),
  );
}
