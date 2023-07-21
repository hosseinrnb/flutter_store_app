import 'package:flutter_store_app/util/extensions/string_extension.dart';
import 'package:flutter_store_app/util/url_handler.dart';
import 'package:uni_links/uni_links.dart';
import 'package:zarinpal/zarinpal.dart';

abstract class PaymentHandler {
  Future<void> initPaymentRequest();
  Future<void> sendPaymentRequest();
  Future<void> verifyPaymentRequest();
}

class ZarinpalPaymentHandler extends PaymentHandler {
  ZarinpalPaymentHandler(this.urlHandler);
  PaymentRequest paymentRequest = PaymentRequest();
  UrlHandler urlHandler;
  String? status;
  String? authority;

  @override
  Future<void> initPaymentRequest() async {
    paymentRequest.setIsSandBox(true);
    paymentRequest.setAmount(1000);
    paymentRequest.setDescription('this is a test');
    paymentRequest.setMerchantID('d645fba8-1b29-11ea-be59-000c295eb8fc');
    paymentRequest.setCallbackURL('expertflutter://shop');
    linkStream.listen((deeplink) {
      if (deeplink!.toLowerCase().contains('authority')) {
        authority = deeplink.extractValueFromQuery('Authority');
        status = deeplink.extractValueFromQuery('Status');
        verifyPaymentRequest();
      }
    });
  }

  @override
  Future<void> sendPaymentRequest() async {
    ZarinPal().startPayment(paymentRequest, (status, paymentGatewayUri) {
      if (status == 100) {
        urlHandler.openUrl(paymentGatewayUri!);
      }
    });
  }

  @override
  Future<void> verifyPaymentRequest() async {
    ZarinPal().verificationPayment(status!, authority!, paymentRequest,
        (isPaymentSuccess, refID, paymentRequest) {
      if (isPaymentSuccess) {
        print(refID);
      } else {
        print('error');
      }
    });
  }
}
