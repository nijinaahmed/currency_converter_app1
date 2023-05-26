import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/conversion_history_model.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ConversionHistory item;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('hh:mm a, dd-MMM-yyyy');

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item.amount.toStringAsFixed(2)} ${item.from} to ${item.to}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Text(
                "At ${dateFormat.format(item.createdAt)}",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
          Expanded(
            child: Text(
              '${item.convertedAmount.toStringAsFixed(2)} ${item.to}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.green, fontSize: 20),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
