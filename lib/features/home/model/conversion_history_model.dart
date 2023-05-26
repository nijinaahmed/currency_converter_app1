class ConversionHistory {
  final String from;
  final String to;
  final DateTime createdAt;
  final double exchangeRate;
  final double amount;
  final double convertedAmount;

  ConversionHistory({
    required this.from,
    required this.to,
    required this.createdAt,
    required this.exchangeRate,
    required this.amount,
    required this.convertedAmount,
  });
}
