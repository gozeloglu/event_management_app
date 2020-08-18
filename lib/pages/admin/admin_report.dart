import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'indicator.dart';

class AdminReport extends StatefulWidget {
  AdminReport({Key key, this.registeredUserCount, this.quota})
      : super(key: key);

  final int registeredUserCount;
  final int quota;

  AdminReportState createState() => AdminReportState();
}

class AdminReportState extends State<AdminReport> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Pie Chart"),
        centerTitle: true,
      ),
      body: Container(
        color: Color.fromRGBO(12, 12, 12, 12),
        child: Card(
          color: Color.fromRGBO(12, 12, 12, 12),
          child: Column(
            children: <Widget>[
              Expanded(
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections()),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Indicator(
                    color: Color(0xff0293ee),
                    text: 'Registered Participant',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Indicator(
                    color: Color(0xfff8b250),
                    text: 'Remaining',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
              const SizedBox(
                width: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 20;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: widget.registeredUserCount.toDouble(),
            title: 'Registered: ' + widget.registeredUserCount.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: (widget.quota - widget.registeredUserCount).toDouble(),
            title: "Remaining: " +
                (widget.quota - widget.registeredUserCount).toString(),
            showTitle: true,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}
