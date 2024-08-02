// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
//
// class ProductSalesChart extends StatelessWidget {
//   const ProductSalesChart({super.key, required this.theme});
//
//   final ColorScheme theme;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: theme.primary,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       height: 200, // Adjusted for better visibility
//       child: Padding(
//         padding: const EdgeInsets.only(right: 15,top: 15), // Added padding around the chart
//         child: LineChart(
//           LineChartData(
//             gridData: FlGridData(
//               show: true,
//               drawVerticalLine: true,
//               horizontalInterval: 20,
//               verticalInterval: 20,
//               getDrawingHorizontalLine: (value) {
//                 return FlLine(
//                   color: theme.onPrimary.withOpacity(0.3),
//                   strokeWidth: 1,
//                 );
//               },
//               getDrawingVerticalLine: (value) {
//                 return FlLine(
//                   color: theme.onPrimary.withOpacity(0.3),
//                   strokeWidth: 1,
//                 );
//               },
//             ),
//             titlesData: FlTitlesData(
//               show: true,
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 50, // Increased reserved size
//                   interval: 1,
//                   getTitlesWidget: (value, meta) {
//                     final title = _bottomTitleWidgets(value);
//                     return SideTitleWidget(
//                       axisSide: meta.axisSide,
//                       child: RotatedBox(
//                         quarterTurns: 1, // Rotate titles for better fit
//                         child: title,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               leftTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   interval: 20,
//                   reservedSize: 50,
//                   getTitlesWidget: (value, meta) {
//                     final title = _leftTitleWidgets(value);
//                     return SideTitleWidget(
//                       axisSide: meta.axisSide,
//                       child: title,
//                     );
//                   },
//                 ),
//               ),
//               topTitles: AxisTitles(
//                 sideTitles: SideTitles(showTitles: false),
//               ),
//               rightTitles: AxisTitles(
//                 sideTitles: SideTitles(showTitles: false),
//               ),
//             ),
//             borderData: FlBorderData(
//               show: true,
//               border: Border.all(
//                 color: theme.onPrimary,
//                 width: 1,
//               ),
//             ),
//             minX: 1,
//             maxX: 12, // Set to cover January to December
//             minY: 0,
//             maxY: 140,
//             lineBarsData: [
//               LineChartBarData(
//                 spots: _getSalesData(),
//                 isCurved: true,
//                 color: theme.secondary,
//                 barWidth: 4,
//                 isStrokeCapRound: true,
//                 dotData: FlDotData(show: false),
//                 belowBarData: BarAreaData(
//                   show: true,
//                   color: theme.secondary.withOpacity(0.3),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _bottomTitleWidgets(double value) {
//     final titles = {
//       1: 'Jan',
//       2: 'Feb',
//       3: 'Mar',
//       4: 'Apr',
//       5: 'May',
//       6: 'Jun',
//       7: 'Jul',
//       8: 'Aug',
//       9: 'Sep',
//       10: 'Oct',
//       11: 'Nov',
//       12: 'Dec',
//     };
//     return Text(
//       titles[value.toInt()] ?? '',
//       style: TextStyle(
//         color: theme.onPrimary,
//         fontWeight: FontWeight.normal,
//         fontSize: 10, // Adjust font size as needed
//       ),
//     );
//   }
//
//   Widget _leftTitleWidgets(double value) {
//     final titles = {
//       0: '0',
//       20: '2k',
//       40: '4k',
//       60: '6k',
//       80: '8k',
//       100: '10k',
//       120: '12k',
//     };
//     return Text(
//       titles[value.toInt()] ?? '',
//       style: TextStyle(
//         color: theme.onPrimary,
//         fontWeight: FontWeight.normal,
//         fontSize: 10,
//       ),
//     );
//   }
//
//   List<FlSpot> _getSalesData() {
//     return [
//       FlSpot(1, 21.04),
//       FlSpot(2, 23.04),
//       FlSpot(3, 11.04),
//       FlSpot(4, 51.04),
//       FlSpot(5, 31.04),
//       FlSpot(6, 41.04),
//       FlSpot(7, 41.04),
//       FlSpot(8, 21.04),
//       FlSpot(9, 51.04),
//       FlSpot(10, 121.04),
//       FlSpot(11, 33),
//       FlSpot(12, 20.04),
//     ];
//   }
// }
