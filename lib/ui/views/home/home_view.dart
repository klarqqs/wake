import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:wake/ui/common/barchart.dart';
import 'package:wake/ui/common/buttons/filled_mini_btn.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return _buildBodyContent(context, viewModel);
  }

  // Determine the main axis alignment based on the view model state
  MainAxisAlignment _determineMainAxisAlignment(HomeViewModel viewModel) {
    if (viewModel.filePath == null || viewModel.isLoading) {
      return MainAxisAlignment.center;
    } else {
      return MainAxisAlignment.start;
    }
  }

  // Build the main body content based on the view model state
  Widget _buildBodyContent(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.filePath == null) {
      return _buildUploadSection(viewModel);
    }
    if (viewModel.isLoading) {
      return _buildLoadingIndicator();
    }
    if (viewModel.apiCallError != null) {
      return _buildErrorText(viewModel.apiCallError!);
    }
    if (viewModel.processedData != null) {
      return _buildProcessedDataSection(context, viewModel);
    }

    return _buildLoadingIndicator();
  }

  // Build the upload section UI
  Widget _buildUploadSection(HomeViewModel viewModel) {
    return Scaffold(
      backgroundColor: const Color(0xff161616),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: _determineMainAxisAlignment(viewModel),
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    'Upload a PDF statement of account with up to 24 months of transaction history.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: viewModel.pickAndProcessFile,
                  child: const Text(
                    'Pick PDF File',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build the loading indicator UI
  Widget _buildLoadingIndicator() {
    return const Scaffold(
      backgroundColor: Color(0xff161616),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
              child: SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 6,
            ),
          )),
        ),
      ),
    );
  }

  // Build the error text UI
  Widget _buildErrorText(String error) {
    return Scaffold(
      backgroundColor: const Color(0xff161616),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: Text(
              error,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }

  // Build the processed data section UI
  Widget _buildProcessedDataSection(
      BuildContext context, HomeViewModel viewModel) {
    Widget getViewForIndex(int index) {
      switch (index) {
        case 0:
          return _buildHome(context, viewModel);
        case 1:
          return _buildInsight(context, viewModel);
        default:
          return _buildHome(context, viewModel);
      }
    }

    void onItemTap(int index) {
      viewModel.updateCurrentIndex(index);
    }

    return Scaffold(
      backgroundColor: const Color(0xff161616),
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> primaryAnimation,
                Animation<double> secondaryAnimation) =>
            FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
        child: getViewForIndex(viewModel.currentIndex),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          textTheme: GoogleFonts.bricolageGrotesqueTextTheme(
            Theme.of(context).textTheme,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xff161616),
          type: BottomNavigationBarType.fixed,
          currentIndex: viewModel.currentIndex,
          onTap: onItemTap,
          elevation: 16,
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade700,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2.5),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2.5),
              ),
              label: 'Insight',
            ),
          ],
        ),
      ),
    );
  }

  // Build the home tab UI
  Widget _buildHome(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
        backgroundColor: const Color(0xff161616),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .03),
                      _buildTotalSpendings(viewModel, context),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your spendings',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          letterSpacing: .2,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 7,
                          bottom: 7,
                          left: MediaQuery.of(context).size.height * .015,
                          right: MediaQuery.of(context).size.height * .011,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.grey.shade900,
                            width: .5,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Text(
                              "All time",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 11,
                                height: 0,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Padding(
                              padding: const EdgeInsets.only(top: 1.0),
                              child: Transform.rotate(
                                angle:
                                    3 * 3.1415926535897932 / 2, // 270 degrees
                                child: Icon(
                                  Icons.chevron_left,
                                  color: Colors.grey.shade500,
                                  size: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  BarChartSample1(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      _buildSpendingHistory(context, viewModel),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  // Build the insight tab UI
  Widget _buildInsight(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
        backgroundColor: const Color(0xff161616),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .03),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  // Build the total spendings section UI
  Widget _buildTotalSpendings(HomeViewModel viewModel, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "-₦${formatCurrency(viewModel.debitsBreakdown["Total"].toString())}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  // Build the spending history section UI
  Widget _buildSpendingHistory(BuildContext context, HomeViewModel viewModel) {
    return Container(
      height: 278,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: const Color(0xff202020),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.grey.shade600,
          width: .2,
        ),
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .016,
          horizontal: MediaQuery.of(context).size.height * .018,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: false,
        children: _buildSpendingHistoryItems(context, viewModel),
      ),
    );
  }

  // Build the spending history items
  List<Widget> _buildSpendingHistoryItems(
      BuildContext context, HomeViewModel viewModel) {
    List<Widget> items = [];

    items.add(_buildSpendingHistoryHeader());
    items.add(SizedBox(height: MediaQuery.of(context).size.height * .005));
    items.add(Divider(color: Colors.grey.shade600, thickness: .1));
    items.add(SizedBox(height: MediaQuery.of(context).size.height * .005));

    for (int i = 0; i < viewModel.processedData!.length; i++) {
      if (viewModel.processedData![i]['Debits'] == "nan") {
        continue;
      }
      items.add(_buildSpendingHistoryItem(context, viewModel, i));
    }

    return items;
  }

  // Build the spending history header UI
  Widget _buildSpendingHistoryHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Spending history",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                letterSpacing: -.02,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Compiled from your bank statement',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: .2,
              ),
            ),
          ],
        ),
        FilledMiniBtn(text: 'See all'),
      ],
    );
  }

  // Build a single spending history item UI
  Widget _buildSpendingHistoryItem(
      BuildContext context, HomeViewModel viewModel, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                _buildSpendingHistoryItemIcon(),
                const SizedBox(width: 16),
                _buildSpendingHistoryItemDetails(viewModel, index),
              ],
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * .1),
          _buildSpendingHistoryItemAmountAndDate(viewModel, index),
        ],
      ),
    );
  }

  // Build the icon for a spending history item
  Widget _buildSpendingHistoryItemIcon() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.035),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(.5),
          width: .1,
        ),
      ),
      height: 40,
      width: 40,
    );
  }

  // Build the details for a spending history item
  Widget _buildSpendingHistoryItemDetails(HomeViewModel viewModel, int index) {
    return Expanded(
      child: Text(
        viewModel.processedData![index]['Details'],
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.white.withOpacity(.85),
          overflow: TextOverflow.ellipsis,
          fontSize: 11.5,
          height: 1.6,
        ),
        maxLines: 2,
      ),
    );
  }

  // Build the amount and date for a spending history item
  Widget _buildSpendingHistoryItemAmountAndDate(
      HomeViewModel viewModel, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        viewModel.processedData![index]['Debits'] == "nan"
            ? Text(
                '+₦${viewModel.processedData![index]['Credits']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              )
            : Text(
                '-₦${viewModel.processedData![index]['Debits']}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 196, 59, 46),
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
        const SizedBox(height: 2),
        Text(
          '${viewModel.processedData![index]['Transaction Date']}',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: .15,
          ),
        ),
      ],
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    var recurringPayments =
        viewModel.checkRecurringPayments(viewModel.transactions);
    for (var payment in recurringPayments) {
      viewModel.recurringData.add(
          '${payment.narration}: ${payment.amount} [${payment.frequency}] - ${payment.occurrences} occurrences');
    }
    super.onViewModelReady(viewModel);
  }
}
