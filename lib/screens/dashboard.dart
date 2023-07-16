import 'package:flutter/material.dart';
import '../obj/ui.dart';
import '../global.dart';
import 'package:fl_chart/fl_chart.dart';

class DashBoard extends StatefulWidget {
  UIComponents ui;
  DashBoard({super.key, required this.ui});

  @override
  State<DashBoard> createState() => _DashBoardState(ui);
}

class _DashBoardState extends State<DashBoard> {
  List<BarChartGroupData> _chartGroups() {
    return [
      BarChartGroupData(x: 0, barRods: [
        BarChartRodData(
          toY: 100,
          width: 20,
        )
      ]),
      BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 120, width: 20)]),
      BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 80, width: 20)]),
      BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 150, width: 20)]),
      BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 86, width: 20)]),
      BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 102, width: 20)]),
      BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 132, width: 20)])
    ];
  }

  UIComponents ui = UIComponents();
  _DashBoardState(this.ui);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 30),
            alignment: Alignment.centerLeft,
            child: Text('Power Consumption ',
                style: TextStyle(
                  color: ui.textcolor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            child: Text('${userdetails.homes[0].totalconsumption} kWh',
                style: TextStyle(
                  color: ui.yellow,
                  fontSize: 66,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 30),
            alignment: Alignment.centerLeft,
            child: Text('This Week',
                style: TextStyle(
                  color: ui.textcolor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
            height: 300,
            child: //create a barchart using the fl_chart package
                BarChart(
              BarChartData(
                maxY: 200,
                minY: 0,
                barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: ui.primarySwatch,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                              rod.toY.toString() + ' kWh',
                              TextStyle(
                                color: ui.textcolor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ));
                        })),
                barGroups: _chartGroups(),
                borderData: FlBorderData(
                    border: Border(
                        bottom: BorderSide(color: ui.textcolor, width: 2),
                        left: BorderSide(color: ui.textcolor, width: 2))),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(sideTitles: _bottomTitles),
                  leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                    showTitles: true,
                    interval: 50,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Text(value.toInt().toString(),
                          style: TextStyle(
                            color: ui.textcolor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ));
                    },
                  )),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 0:
              text = 'Sun';
              break;
            case 1:
              text = 'Mon';
              break;
            case 2:
              text = 'Tue';
              break;
            case 3:
              text = 'Wed';
              break;
            case 4:
              text = 'Thu';
              break;
            case 5:
              text = 'Fri';
              break;
            case 6:
              text = 'Sat';
              break;
          }

          return Text(
            text,
            style: TextStyle(
              color: ui.textcolor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      );
}
