import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
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
    double width = 56.2,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          width: width,
          borderRadius: BorderRadius.circular(0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isTouched
                ? [
                    kcPrimaryColor,
                    kcPrimaryColor,
                    kcPrimaryColor,
                  ]
                : [
                    Colors.grey.shade900.withOpacity(.1),
                    Colors.grey.shade900.withOpacity(.35),
                    Colors.grey.shade900.withOpacity(.5),
                  ],
          ),
          borderSide: isTouched
              ? BorderSide(color: Colors.grey.shade600, width: .1)
              : BorderSide(color: Colors.grey.shade600, width: .1),
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

  List<BarChartGroupData> showingGroups() => List.generate(6, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 5, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 5, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 9, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
          // case 6:
          //   return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => const Color(0xff131313),
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
              // case 6:
              //   weekDay = 'Sunday';
              //   break;
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
                  text: (rod.toY - 1).toString(),
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
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
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
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
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
}
