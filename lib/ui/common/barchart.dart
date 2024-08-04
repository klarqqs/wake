import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wake/ui/common/app_colors.dart';

class BarChartSample1 extends StatefulWidget {
  BarChartSample1({super.key});

  List<Color> get availableColors => const <Color>[
        Colors.purple,
        Colors.yellow,
        Colors.blue,
        Colors.orange,
        Colors.pink,
        Colors.red,
      ];

  final Color barBackgroundColor = Colors.white.withOpacity(0.3);
  final Color barColor = Colors.white;
  final Color touchedBarColor = Colors.green;

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;
  bool isPlaying = false;

  @override
  void initState() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        refreshState();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 0.0),
          height: MediaQuery.of(context).size.height * .25,
          child: BarChart(
            mainBarData(),
            swapAnimationDuration: animDuration,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 6,
    bool isHigest = false,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          width: width.w,
          borderRadius: BorderRadius.circular(100),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isHigest
                ? [
                    kcPrimaryColor,
                    kcPrimaryColor,
                  ]
                : [
                    Colors.grey.shade900.withOpacity(.1),
                    Colors.grey.shade900.withOpacity(.35),
                    Colors.grey.shade900.withOpacity(.5),
                  ],
          ),
          borderSide: isHigest
              ? const BorderSide(
                  color: kcPrimaryColor,
                  width: .55,
                )
              : BorderSide(
                  color: Colors.grey.shade700,
                  width: .1,
                ),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 14,
            color: Colors.transparent,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(12, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
              0,
              3,
              isTouched: i == touchedIndex,
            );
          case 1:
            return makeGroupData(
              1,
              6.5,
              isTouched: i == touchedIndex,
            );
          case 2:
            return makeGroupData(
              2,
              5,
              isTouched: i == touchedIndex,
            );
          case 3:
            return makeGroupData(
              3,
              5,
              isTouched: i == touchedIndex,
            );
          case 4:
            return makeGroupData(
              4,
              9,
              isTouched: i == touchedIndex,
            );
          case 5:
            return makeGroupData(
              5,
              7.5,
              isTouched: i == touchedIndex,
            );
          case 6:
            return makeGroupData(
              6,
              6.2,
              isTouched: i == touchedIndex,
            );

          case 7:
            return makeGroupData(
              7,
              10.9,
              isTouched: i == touchedIndex,
              isHigest: true,
            );

          case 8:
            return makeGroupData(
              8,
              10.1,
              isTouched: i == touchedIndex,
            );
          case 9:
            return makeGroupData(
              9,
              5,
              isTouched: i == touchedIndex,
            );
          case 10:
            return makeGroupData(
              10,
              7.8,
              isTouched: i == touchedIndex,
            );
          case 11:
            return makeGroupData(
              11,
              6.1,
              isTouched: i == touchedIndex,
            );
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => const Color(0xff111111),
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'Jan';
                break;
              case 1:
                weekDay = 'Feb';
                break;
              case 2:
                weekDay = 'Mar';
                break;
              case 3:
                weekDay = 'Apr';
                break;
              case 4:
                weekDay = 'May';
                break;
              case 5:
                weekDay = 'Jun';
                break;
              case 6:
                weekDay = 'Jul';
                break;
              case 7:
                weekDay = 'Aug';
                break;
              case 8:
                weekDay = 'Sep';
                break;
              case 9:
                weekDay = 'Oct';
                break;
              case 10:
                weekDay = 'Nov';
                break;
              case 11:
                weekDay = 'Dec';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY).toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: .15,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          // setState(() {
          //   if (!event.isInterestedForInteractions ||
          //       barTouchResponse == null ||
          //       barTouchResponse.spot == null) {
          //     touchedIndex = -1;
          //     return;
          //   }
          //   touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          // });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      // groupsSpace: 24.w,
      barGroups: showingGroups(),
      alignment: BarChartAlignment.spaceEvenly,
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: kcMediumGrey,
      fontSize: 12,
      fontWeight: FontWeight.w900,
      height: 0,
      overflow: TextOverflow.ellipsis,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Jan', style: style);
        break;
      case 1:
        text = const Text('Feb', style: style);
        break;
      case 2:
        text = const Text('Mar', style: style);
        break;
      case 3:
        text = const Text('Apr', style: style);
        break;
      case 4:
        text = const Text('May', style: style);
        break;
      case 5:
        text = const Text('Jun', style: style);
        break;
      case 6:
        text = const Text('Jul', style: style);
        break;
      case 7:
        text = const Text('Aug', style: style);
        break;
      case 8:
        text = const Text('Sep', style: style);
        break;
      case 9:
        text = const Text('Oct', style: style);
        break;
      case 10:
        text = const Text('Nov', style: style);
        break;
      case 11:
        text = const Text('Dec', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  // BarChartData randomData() {
  //   return BarChartData(
  //     barTouchData: BarTouchData(
  //       enabled: false,
  //     ),
  //     titlesData: FlTitlesData(
  //       show: true,
  //       bottomTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           getTitlesWidget: getTitles,
  //           reservedSize: 38,
  //         ),
  //       ),
  //       leftTitles: const AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: false,
  //         ),
  //       ),
  //       topTitles: const AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: false,
  //         ),
  //       ),
  //       rightTitles: const AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: false,
  //         ),
  //       ),
  //     ),
  //     borderData: FlBorderData(
  //       show: false,
  //     ),
  //     barGroups: List.generate(6, (i) {
  //       switch (i) {
  //         case 0:
  //           return makeGroupData(
  //             0,
  //             Random().nextInt(15).toDouble() + 6,
  //             barColor: widget.availableColors[
  //                 Random().nextInt(widget.availableColors.length)],
  //           );
  //         case 1:
  //           return makeGroupData(
  //             1,
  //             Random().nextInt(15).toDouble() + 6,
  //             barColor: widget.availableColors[
  //                 Random().nextInt(widget.availableColors.length)],
  //           );
  //         case 2:
  //           return makeGroupData(
  //             2,
  //             Random().nextInt(15).toDouble() + 6,
  //             barColor: widget.availableColors[
  //                 Random().nextInt(widget.availableColors.length)],
  //           );
  //         case 3:
  //           return makeGroupData(
  //             3,
  //             Random().nextInt(15).toDouble() + 6,
  //             barColor: widget.availableColors[
  //                 Random().nextInt(widget.availableColors.length)],
  //           );
  //         case 4:
  //           return makeGroupData(
  //             4,
  //             Random().nextInt(15).toDouble() + 6,
  //             barColor: widget.availableColors[
  //                 Random().nextInt(widget.availableColors.length)],
  //           );
  //         case 5:
  //           return makeGroupData(
  //             5,
  //             Random().nextInt(15).toDouble() + 6,
  //             barColor: widget.availableColors[
  //                 Random().nextInt(widget.availableColors.length)],
  //           );

  //         default:
  //           return throw Error();
  //       }
  //     }),
  //     gridData: const FlGridData(show: false),
  //   );
  // }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
  }
}
