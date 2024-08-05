// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:wake/ui/common/buttons/filled_mini_btn.dart';

import 'spending_history_viewmodel.dart';

class SpendingHistoryView extends StackedView<SpendingHistoryViewModel> {
  List<Map<String, dynamic>> processedData;
  SpendingHistoryView({
    Key? key,
    required this.processedData,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SpendingHistoryViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 15),
      body: SafeArea(
        child: _buildHome(context, viewModel),
      ),
    );
  }

  Widget _buildHome(BuildContext context, SpendingHistoryViewModel viewModel) {
    return Container(
      color: const Color.fromARGB(255, 15, 15, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => viewModel.navigationService.back(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 8.0,
                  ),
                  child: SvgPicture.asset(
                    "assets/svgs/back.svg",
                    // ignore: deprecated_member_use
                    color: Colors.white,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Spending History",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -.2,
                    height: 0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .04),
          _buildSpendingHistorySortItem(context, viewModel),
          // SizedBox(height: MediaQuery.of(context).size.height * .06),
          _buildSpendingHistory(context, viewModel),
        ],
      ),
    );
  }

  Widget _buildSpendingHistory(
      BuildContext context, SpendingHistoryViewModel viewModel) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0.h),
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
            top: MediaQuery.of(context).size.height * .008,
            bottom: MediaQuery.of(context).size.height * .008,
          ),
          physics: const BouncingScrollPhysics(),
          children: [
            ..._buildSpendingHistoryItems(context, viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildSpendingHistorySortItem(
      BuildContext context, SpendingHistoryViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 42.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MiniOptionTextBtn(
            text: 'Search',
            assetName: "assets/svgs/search-normal.svg",
            onPressed: () => {},
          ),
          const SizedBox(width: 18),
          MiniOptionTextBtn(
            text: 'Filter',
            assetName: "assets/svgs/filter.svg",
            onPressed: () => {},
          ),
          const SizedBox(width: 18),
          MiniOptionTextBtn(
            text: 'Sort',
            assetName: "assets/svgs/sort.svg",
            onPressed: () => {},
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSpendingHistoryItems(
      BuildContext context, SpendingHistoryViewModel viewModel) {
    return List.generate(
      processedData.length,
      (index) {
        if (processedData[index]['Debits'] == "nan") {
          return const SizedBox.shrink();
        }
        return _buildSpendingHistoryItem(context, viewModel, index);
      },
    ).where((widget) => widget is! SizedBox).toList();
  }

  Widget _buildSpendingHistoryItem(
      BuildContext context, SpendingHistoryViewModel viewModel, int index) {
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

  Widget _buildSpendingHistoryItemDetails(
      SpendingHistoryViewModel viewModel, int index) {
    return Text(
      processedData[index]['Details'],
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
      SpendingHistoryViewModel viewModel, int index) {
    final isCredit = processedData[index]['Debits'] == "nan";
    final amount = isCredit
        ? processedData[index]['Credits']
        : processedData[index]['Debits'];
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
          '${processedData[index]['Transaction Date']}',
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

  @override
  SpendingHistoryViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SpendingHistoryViewModel();
}
