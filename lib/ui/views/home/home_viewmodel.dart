import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'dart:math' as math;

import 'package:stacked_services/stacked_services.dart';
import 'package:wake/app/app.locator.dart';

class HomeViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  List<String> recurringData = [];
  Map<String, double> debitsBreakdown = {};

  int currentIndex = 0;

  void updateCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  getLoginDetails() async {
    notifyListeners();
  }

  // Calculate Debits

  Map<String, double> calculateDebits() {
    if (processedData == null || processedData!.isEmpty) {
      return {'Total': 0.0};
    }

    double totalDebits = 0.0;
    Map<String, double> monthlyDebits = {};

    for (var transaction in processedData!) {
      // Parse the debit amount
      double debit =
          double.tryParse(transaction['Debits'].replaceAll(',', '')) ?? 0.0;

      // Add to total debits
      totalDebits += debit;

      // Parse the transaction date
      DateTime? transactionDate =
          DateFormat('dd/MM/yyyy').tryParse(transaction['Transaction Date']);
      if (transactionDate != null) {
        // Create a key for the month (e.g., "2023-07" for July 2023)
        String monthKey = DateFormat('yyyy-MM').format(transactionDate);

        // Add to monthly debits
        monthlyDebits[monthKey] = (monthlyDebits[monthKey] ?? 0.0) + debit;
      }
    }

    // Add total to the result
    Map<String, double> result = {'Total': totalDebits};

    // Add monthly totals to the result
    result.addAll(monthlyDebits);

    return result;
  }

  // API call

  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:5000',
  ));

  String? filePath;
  List<Map<String, dynamic>>? processedData;
  bool isLoading = false;
  String? apiCallError;

  Future<void> pickAndProcessFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        filePath = result.files.single.path;
        notifyListeners();

        await sendFileToApi();
      }
    } catch (e) {
      _handleError("Error picking file", e);
    }
  }

  Future<void> sendFileToApi() async {
    if (filePath == null) return;

    _setLoading(true);

    try {
      final response = await _uploadFile();
      _handleResponse(response);
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      _handleError("Error sending file to API", e);
    } finally {
      _setLoading(false);
    }
  }

  Future<Response> _uploadFile() async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePath!, filename: "document.pdf"),
    });

    return await _dio.post('/process/', data: formData);
  }

  void _handleResponse(Response response) {
    if (response.statusCode == 200) {
      _parseSuccessResponse(response.data);
    } else {
      _handleError("Error processing file", response.data);
    }
  }

  void _parseSuccessResponse(dynamic responseData) {
    try {
      processedData = List<Map<String, dynamic>>.from(responseData);
      notifyListeners();
      apiCallError = null;

      // Calculate debits after processing the response
      debitsBreakdown = calculateDebits();
      notifyListeners();
    } catch (e) {
      _handleError("Error parsing API response", e);
    }
  }

  void _handleDioError(DioException e) {
    if (e.response != null) {
      _handleError(
          "API Error", "${e.response?.statusCode}: ${e.response?.data}");
    } else {
      _handleError("Network Error", e.message);
    }
  }

  void _handleError(String message, dynamic error) {
    this.apiCallError = "$message: $error";
    processedData = null;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  // Recurring Payments

  List<RecurringPayment> checkRecurringPayments(
      List<Transaction> transactions) {
    Map<String, List<Transaction>> groupedTransactions = {};
    List<RecurringPayment> recurringPayments = [];

    // Group transactions by narration
    for (var transaction in transactions) {
      if (!groupedTransactions.containsKey(transaction.narration)) {
        groupedTransactions[transaction.narration] = [];
      }
      groupedTransactions[transaction.narration]!.add(transaction);
    }

    for (var entry in groupedTransactions.entries) {
      var narration = entry.key;
      var transactionList = entry.value;

      if (transactionList.length < 2) continue;

      // Sort transactions by date
      transactionList.sort((a, b) => a.postDate.compareTo(b.postDate));

      var frequency = _determineFrequency(transactionList);

      // Check if narration contains specific frequency types
      if (frequency == 'One-time' && _containsFrequencyType(narration)) {
        frequency = _extractFrequencyType(narration);
      }

      if (frequency != 'One-time') {
        recurringPayments.add(RecurringPayment(
          narration: narration,
          amount: transactionList.last.amount,
          frequency: frequency,
          occurrences: transactionList.length,
        ));
      }
    }

    return recurringPayments;
  }

  String _determineFrequency(List<Transaction> transactions) {
    if (transactions.length < 2) return 'One-time';

    List<int> daysBetweenTransactions = [];
    for (int i = 1; i < transactions.length; i++) {
      daysBetweenTransactions.add(transactions[i]
          .postDate
          .difference(transactions[i - 1].postDate)
          .inDays);
    }

    // Calculate the average and standard deviation of days between transactions
    double avgDays = daysBetweenTransactions.reduce((a, b) => a + b) /
        daysBetweenTransactions.length;
    double stdDev = _calculateStandardDeviation(daysBetweenTransactions);

    if (_isApproximately(avgDays, 30, stdDev)) {
      return 'Monthly';
    } else if (_isApproximately(avgDays, 90, stdDev)) {
      return 'Quarterly';
    } else if (_isApproximately(avgDays, 365, stdDev)) {
      return 'Annual';
    } else {
      return 'Irregular';
    }
  }

  bool _isApproximately(double value, double target, double tolerance) {
    return (value - target).abs() <= tolerance;
  }

  double _calculateStandardDeviation(List<int> values) {
    double mean = values.reduce((a, b) => a + b) / values.length;
    double sumSquaredDiff = values
        .map((x) => math.pow(x - mean, 2).toDouble())
        .reduce((a, b) => a + b);
    return math.sqrt(sumSquaredDiff / values.length);
  }

  bool _containsFrequencyType(String narration) {
    List<String> frequencyTypes = ['Monthly', 'Quarterly', 'Annual'];
    return frequencyTypes.any((type) => narration.contains(type));
  }

  String _extractFrequencyType(String narration) {
    List<String> frequencyTypes = ['Monthly', 'Quarterly', 'Annual'];
    return frequencyTypes.firstWhere((type) => narration.contains(type),
        orElse: () => 'One-time');
  }

  //

  var transactions = [
    // Salary Credits: 13 occurrences
    for (var i = 0; i < 13; i++)
      Transaction(
        postDate: DateTime(2020, 1, 1).add(Duration(days: 30 * i)),
        valueDate: DateTime(2020, 1, 1).add(Duration(days: 30 * i)),
        narration: 'Salary Credit',
        refNumber: '9876543${i + 0}',
        amount: 5000.00,
        balance: 5000.00 * (i + 1),
      ),

    // Netflix Subscriptions: 13 occurrences
    for (var i = 0; i < 13; i++)
      Transaction(
        postDate: DateTime(2020, 1, 5).add(Duration(days: 30 * i)),
        valueDate: DateTime(2020, 1, 5).add(Duration(days: 30 * i)),
        narration: 'Netflix Subscription',
        refNumber: '1234567${i + 6}',
        amount: 15.99,
        balance: 5000.00 * (i + 1) - 15.99 * (i + 1),
      ),

    // SMS Alert Fees: 13 occurrences
    for (var i = 0; i < 13; i++)
      Transaction(
        postDate: DateTime(2020, 1, 27).add(Duration(days: 30 * i)),
        valueDate: DateTime(2020, 1, 24).add(Duration(days: 30 * i)),
        narration: 'SMS Alert Fee',
        refNumber: '3477911${i + 6}',
        amount: 4.00,
        balance: 5000.00 * (i + 1) - 15.99 * (i + 1) - 4.00 * (i + 1),
      ),

    // Quarterly Gym Membership: 4 occurrences
    for (var i = 0; i < 4; i++)
      Transaction(
        postDate: DateTime(2020, 3, 15).add(Duration(days: 90 * i)),
        valueDate: DateTime(2020, 3, 15).add(Duration(days: 90 * i)),
        narration: 'Quarterly Gym Membership',
        refNumber: '2222222${i + 2}',
        amount: 150.00,
        balance: 5000.00 * (i * 3 + 3) -
            15.99 * (i * 3 + 3) -
            4.00 * (i * 3 + 3) -
            150.00 * (i + 1),
      ),

    // Annual Insurance Premium: 1 occurrence
    Transaction(
      postDate: DateTime(2020, 8, 15),
      valueDate: DateTime(2020, 8, 15),
      narration: 'Annual Insurance Premium',
      refNumber: '55555555',
      amount: 500.00,
      balance: 5000.00 * 8 - 15.99 * 8 - 4.00 * 8 - 150.00 * 2 - 500.00,
    ),
  ];
}

class Transaction {
  final DateTime postDate;
  final DateTime valueDate;
  final String narration;
  final String refNumber;
  final double amount;
  final double balance;

  Transaction({
    required this.postDate,
    required this.valueDate,
    required this.narration,
    required this.refNumber,
    required this.amount,
    required this.balance,
  });
}

class RecurringPayment {
  final String narration;
  final double amount;
  final String frequency;
  final int occurrences;

  RecurringPayment({
    required this.narration,
    required this.amount,
    required this.frequency,
    required this.occurrences,
  });
}

String formatCurrency(amountString) {
  double amount = double.parse(amountString);

  // Format the amount as currency
  final NumberFormat currencyFormat = NumberFormat.currency(symbol: "\$");
  String formattedAmount = currencyFormat.format(amount);
  return formattedAmount.replaceAll("\$", "");
}
