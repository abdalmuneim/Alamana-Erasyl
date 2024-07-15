import 'package:alamanaelrasyl/core/app_const/api_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';

class PaymentServices {
  PaymentServices._init();
  static PaymentServices instance = PaymentServices._init();

  payPalRequest(BuildContext context) async {
    BraintreeDropInRequest request = BraintreeDropInRequest(
      tokenizationKey: APIKeys.braintreeTokenizationKey,
      collectDeviceData: true,
      cardEnabled: true,
      paypalRequest: BraintreePayPalRequest(
        amount: "3.0",
        displayName: "Abdelmonem Mahmoud",
      ),
    );
    BraintreeDropInResult? result = await BraintreeDropIn.start(request);
    if (result != null) {
      /* ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppString.successPay),
        ),
      ); */
    } else {
      /*  ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppString.failedPay),
        ),
      ); */
    }
  }
}
