import 'api_service.dart';
import '../../features/checkout/data/model/customers_input/customers_input.dart';
import '../../features/checkout/data/model/init_payment_sheet_input_model/init_payment_sheet_input_model.dart';
import '../../features/checkout/data/model/payment_intent_input_model/payment_intent_input_model.dart';
import '../../features/checkout/data/model/payment_intent_model/payment_intent_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../features/checkout/data/model/customer_model/customer_model.dart';
import '../../features/checkout/data/model/ephemeral_keys_input_model/ephemeral_keys_input_model.dart';
import '../../features/checkout/data/model/ephemeral_keys_model/ephemeral_keys_model.dart';

class StripeService {
  final ApiService _apiService;

  StripeService({required ApiService apiService}) : _apiService = apiService;

  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    final secretKey = dotenv.env['SECRET_KEY'] ?? "";
    final response = await _apiService.post(
      body: paymentIntentInputModel.toJson(),
      url: "https://api.stripe.com/v1/payment_intents",
      token: secretKey,
      contentType: Headers.formUrlEncodedContentType,
    );
    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);

    return paymentIntentModel;
  }

  Future<CustomerModel> createCustomers(
      CustomerInputModel customerInputModel) async {
    final secretKey = dotenv.env['SECRET_KEY'] ?? "";
    final response = await _apiService.post(
      body: customerInputModel.toJson(),
      url: "https://api.stripe.com/v1/customers",
      token: secretKey,
      contentType: Headers.formUrlEncodedContentType,
    );
    var customerModel = CustomerModel.fromJson(response.data);

    return customerModel;
  }

  Future<EphemeralKeysModel> createEphemeralKeys(
      EphemeralKeysInputModel ephemeralKeysInputModel) async {
    final secretKey = dotenv.env['SECRET_KEY'] ?? "";
    final response = await _apiService.post(
        body: ephemeralKeysInputModel.toJson(),
        url: "https://api.stripe.com/v1/ephemeral_keys",
        token: secretKey,
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          "Stripe-Version": "2023-10-16",
        });
    var ephemeralKeysModel = EphemeralKeysModel.fromJson(response.data);

    return ephemeralKeysModel;
  }

  Future initPaymentSheet({
    required InitPaymentSheetInputModel initPaymentSheetInputModel,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret:
            initPaymentSheetInputModel.paymentIntentClientSecret,
        customerEphemeralKeySecret: initPaymentSheetInputModel.ephemeralKeys,
        customerId: initPaymentSheetInputModel.customerId,
        merchantDisplayName: "Mohammed",
      ),
    );
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment(PaymentIntentInputModel paymentIntentInputModel) async {
    PaymentIntentModel paymentIntentModel =
        await createPaymentIntent(paymentIntentInputModel);

    EphemeralKeysModel? ephemeralKeysModel;

    if (paymentIntentInputModel.customerId != null) {
      ephemeralKeysModel = await createEphemeralKeys(EphemeralKeysInputModel(
          customer: paymentIntentInputModel.customerId!));
    }

    await initPaymentSheet(
      initPaymentSheetInputModel: InitPaymentSheetInputModel(
        paymentIntentClientSecret: paymentIntentModel.clientSecret!,
        ephemeralKeys: ephemeralKeysModel?.secret,
        customerId: paymentIntentInputModel.customerId,
      ),
    );

    await displayPaymentSheet();
  }
}
