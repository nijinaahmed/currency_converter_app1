import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../model/conversion_history_model.dart';
import '../model/currency_model.dart';
import '../repositories/currency_repo.dart';

class CurrencyController extends GetxController {
  final CurrencyRepo _currencyRepo = CurrencyRepo(apiKey);
  final amountController = TextEditingController().obs;
  final RxDouble convertedAmount = (0.0).obs;
  final RxDouble conversionRate = (0.0).obs;

  final RxnString toCurrency = RxnString();
  final RxnString fromCurrency = RxnString();

  final RxList<Currency> currencies = <Currency>[].obs;
  final RxBool isLoading = true.obs;

  final RxList<ConversionHistory> history = <ConversionHistory>[].obs;

  getCurrencies() async {
    try {
      final result = await _currencyRepo.getCurrencies();
      currencies(result);

      fromCurrency(result.first.code);
      toCurrency(result.last.code);
      isLoading(false);
      //print('notempty');
      //  } else {
      //   print('empty');

      // }
    } catch (e) {
      print(e.toString());
    }
  }

  changeFromCurrency(String currency) {
    conversionRate(0);
    fromCurrency(currency);
  }

  changeToCurrency(String currency) {
    conversionRate(0);
    toCurrency(currency);
  }

  calculate() async {
    try {
      final rate = await _currencyRepo.getConversionRate(
        fromCurrency.string,
        toCurrency.string,
      );
      conversionRate(rate);
      final amount = double.tryParse(amountController.value.text) ?? 0;
      final result = amount * rate;
      convertedAmount(result);
      if (history.length == maxHistory) {
        history.removeAt(0);
      }
      history.add(
        ConversionHistory(
          from: fromCurrency.string,
          to: toCurrency.string,
          createdAt: DateTime.now(),
          exchangeRate: rate,
          amount: amount,
          convertedAmount: result,
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
