import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import '../model/currency_model.dart';

class CurrencyRepo {
  CurrencyRepo(this.apiKey);

  final String apiKey;

  Future<List<Currency>> getCurrencies() async {
    const String currenciesUrl = "https://api.currencyapi.com/v3/currencies";
    Response res = await get(Uri.parse(currenciesUrl), headers: {
      'apikey': apiKey,
    });
    final body = jsonDecode(res.body);
    return (body['data'] as Map<String, dynamic>)
        .values
        .map((e) => Currency.fromJson(e))
        .toList();
  }

  Future<double> getConversionRate(String from, String to) async {
    final Uri currenciesUrl = Uri.https("api.currencyapi.com", "/v3/latest", {
      'apikey': apiKey,
      'base_currency': from,
      'currencies': to,
    });

    Response res = await get(currenciesUrl);
    final body = jsonDecode(res.body);

    return body['data'][to]['value'];
  }
}
