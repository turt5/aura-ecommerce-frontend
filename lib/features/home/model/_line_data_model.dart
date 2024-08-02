import 'package:fl_chart/fl_chart.dart';

class LineDataModel {
  final spots = [
    FlSpot(1, 21.04),
    FlSpot(2, 23.04),
    FlSpot(3, 11.04),
    FlSpot(4, 51.04),
    FlSpot(5, 31.04),
    FlSpot(6, 41.04),
    FlSpot(7, 41.04),
    FlSpot(8, 21.04),
    FlSpot(9, 51.04),
    FlSpot(10, 121.04),
    FlSpot(11, 33),
    FlSpot(12, 20.04),
    FlSpot(13, 22.04),
    FlSpot(14, 121.04),
  ];

  final leftTitle = {
    0: '0',
    20: '2k',
    40: '4k',
    60: '6k',
    80: '8k',
    100: '10k',
    120: '12k',
  };

  final bottomTitle = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec',
  };
}
