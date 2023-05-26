import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/currency_controller.dart';
import '../model/currency_model.dart';
import 'components/history_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.put(CurrencyController());

  @override
  void initState() {
    controller.getCurrencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        backgroundColor: Colors.green,
      ),
      body: Obx(
        () {
          if (controller.isLoading.isTrue) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          return Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Convert",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(children: [
                      TextFormField(
                        key: const ValueKey('amount'),
                        controller: controller.amountController.value,
                        decoration:
                            const InputDecoration(hintText: 'Enter Amount'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DropdownButton<String>(
                            value: controller.fromCurrency.value,
                            items: controller.currencies
                                .map<DropdownMenuItem<String>>(
                                    (Currency value) {
                              return DropdownMenuItem<String>(
                                value: value.code,
                                child: Text(
                                  value.code,
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) =>
                                controller.changeFromCurrency(newValue ?? ''),
                          ),
                          const Icon(Icons.currency_exchange_rounded),
                          DropdownButton<String>(
                            value: controller.toCurrency.value,
                            items: controller.currencies
                                .map<DropdownMenuItem<String>>(
                                    (Currency value) {
                              return DropdownMenuItem<String>(
                                value: value.code,
                                child: Text(
                                  value.code,
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) =>
                                controller.changeToCurrency(newValue ?? ''),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          controller.calculate();
                        },
                        child: Text('Calculate'),
                      ),
                      if (controller.conversionRate.value != 0)
                        Text(
                          "Converted Currency: ${controller.convertedAmount.value}",
                        ),
                    ]),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Divider(),
                  ),
                  if (controller.history.isNotEmpty)
                    Text(
                      "History",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  const SizedBox(height: 20),
                  ...controller.history.reversed
                      .map((e) => HistoryItem(item: e)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
