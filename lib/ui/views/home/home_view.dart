import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:wake/app/app.router.dart';
import 'package:wake/ui/common/buttons/filled_mini_btn.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 15),
      body: SafeArea(
        child: _buildBodyContent(context, viewModel),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context, viewModel),
    );
  }

  Widget _buildBodyContent(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.filePath == null) {
      return _buildUploadSection(viewModel);
    }
    if (viewModel.isLoading) {
      return _buildLoadingIndicator();
    }
    if (viewModel.apiCallError != null) {
      return _buildErrorText(viewModel, viewModel.apiCallError!);
    }
    if (viewModel.processedData != null) {
      return _buildProcessedDataSection(context, viewModel);
    }
    return _buildLoadingIndicator();
  }

  Widget _buildUploadSection(
    HomeViewModel viewModel, {
    String text = "Get insights on your spending",
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: text != "Get insights on your spending" ||
                      text != "No subscription found"
                  ? Colors.red
                  : Colors.white.withOpacity(.9),
              fontWeight: FontWeight.w900,
              fontSize: 18,
              letterSpacing: -.1,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Upload a PDF statement of account with up to 24 months of transaction history.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(.6),
              fontSize: 14,
              letterSpacing: -.1,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FilledMiniBtn2(
                text: "Upload bank statement",
                onPressed: viewModel.pickAndProcessFile,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 6),
      ),
    );
  }

  Widget _buildErrorText(HomeViewModel viewModel, String error) {
    return _buildUploadSection(viewModel, text: error);
  }

  Widget _buildProcessedDataSection(
      BuildContext context, HomeViewModel viewModel) {
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation, secondaryAnimation) =>
          FadeThroughTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      ),
      child: viewModel.currentIndex == 0
          ? _buildHome(context, viewModel)
          : _buildInsight(context, viewModel),
    );
  }

  Widget _buildHome(BuildContext context, HomeViewModel viewModel) {
    return Container(
      color: const Color.fromARGB(255, 15, 15, 15),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Bank statement",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                // letterSpacing: -.2,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .04),
            _buildSpendingsHeader(),
            SizedBox(height: 4.h),
            _buildTotalSpendings(viewModel),
            SizedBox(height: MediaQuery.of(context).size.height * .06),
            _buildSpendingHistory(context, viewModel),
            // BarChartSample1(),
            const SizedBox(height: 180),
          ],
        ),
      ),
    );
  }

  Widget _buildInsight(BuildContext context, HomeViewModel viewModel) {
    return Container(
      color: const Color.fromARGB(255, 15, 15, 15),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "Subscriptions",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  // letterSpacing: -.2,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .3),
            _buildUploadSection(viewModel, text: "No subscription found"),
            const SizedBox(height: 400),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalSpendings(HomeViewModel viewModel) {
    return Text(
      "-₦${formatCurrency(viewModel.debitsBreakdown["Total"].toString())}",
      style: const TextStyle(
        color: Color.fromARGB(255, 196, 59, 46),
        fontSize: 32,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _buildSpendingsHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Your spending',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: .2,
          ),
        ),
      ],
    );
  }

  Widget _buildSpendingHistory(BuildContext context, HomeViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey.shade900.withOpacity(.35),
            Colors.grey.shade900.withOpacity(.5),
            Colors.grey.shade900.withOpacity(.65),
          ],
        ),
        border: Border.all(color: Colors.grey.shade600, width: .2),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.height * .024,
          right: MediaQuery.of(context).size.height * .024,
          top: MediaQuery.of(context).size.height * .024,
          bottom: MediaQuery.of(context).size.height * .008,
        ),
        physics: const BouncingScrollPhysics(),
        children: [
          _buildSpendingHistoryHeader(context, viewModel),
          SizedBox(height: 4.h),
          const Divider(color: Colors.grey, thickness: .1),
          ..._buildSpendingHistoryItems(context, viewModel),
        ],
      ),
    );
  }

  Widget _buildSpendingHistoryHeader(
      BuildContext context, HomeViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Spending history",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                letterSpacing: -.2,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Compiled from your bank statement',
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: .2,
              ),
            ),
          ],
        ),
        TextMiniBtn(
          text: 'See all',
          onPressed: () => viewModel.navigationService
              .navigateToSpendingHistoryView(
                  processedData: viewModel.processedData!),
        ),
      ],
    );
  }

  List<Widget> _buildSpendingHistoryItems(
      BuildContext context, HomeViewModel viewModel) {
    return List.generate(
      7,
      (index) {
        if (viewModel.processedData![index]['Debits'] == "nan") {
          return const SizedBox.shrink();
        }
        return _buildSpendingHistoryItem(context, viewModel, index);
      },
    ).where((widget) => widget is! SizedBox).toList();
  }

  Widget _buildSpendingHistoryItem(
      BuildContext context, HomeViewModel viewModel, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSpendingHistoryItemIcon(),
          const SizedBox(width: 16),
          Expanded(child: _buildSpendingHistoryItemDetails(viewModel, index)),
          SizedBox(width: MediaQuery.of(context).size.width * .1),
          _buildSpendingHistoryItemAmountAndDate(viewModel, index),
        ],
      ),
    );
  }

  Widget _buildSpendingHistoryItemIcon() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.035),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(.5), width: .1),
      ),
    );
  }

  Widget _buildSpendingHistoryItemDetails(HomeViewModel viewModel, int index) {
    return Text(
      viewModel.processedData![index]['Details'],
      style: TextStyle(
        fontWeight: FontWeight.w900,
        color: Colors.white.withOpacity(.9),
        overflow: TextOverflow.ellipsis,
        fontSize: 11.5,
        height: 1.6,
      ),
      maxLines: 2,
    );
  }

  Widget _buildSpendingHistoryItemAmountAndDate(
      HomeViewModel viewModel, int index) {
    final isCredit = viewModel.processedData![index]['Debits'] == "nan";
    final amount = isCredit
        ? viewModel.processedData![index]['Credits']
        : viewModel.processedData![index]['Debits'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${isCredit ? '+' : '-'}₦$amount',
          style: TextStyle(
            color: isCredit
                ? Colors.white
                : const Color.fromARGB(255, 196, 59, 46),
            fontSize: 12,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '${viewModel.processedData![index]['Transaction Date']}',
          style: TextStyle(
            color: Colors.grey.shade300,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: .15,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(
      BuildContext context, HomeViewModel viewModel) {
    return Theme(
      data: ThemeData(
        textTheme: GoogleFonts.mynerveTextTheme(Theme.of(context).textTheme),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 15),
        currentIndex: viewModel.currentIndex,
        onTap: viewModel.updateCurrentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade700,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(icon: SizedBox(), label: 'Home'),
          BottomNavigationBarItem(icon: SizedBox(), label: 'Insight'),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.checkRecurringPayments(viewModel.transactions).forEach((payment) {
      viewModel.recurringData.add(
        '${payment.narration}: ${payment.amount} [${payment.frequency}] - ${payment.occurrences} occurrences',
      );
    });
    super.onViewModelReady(viewModel);
  }
}
