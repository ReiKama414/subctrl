import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:subctrl/app/theme/tokens.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/data/models/finance_models.dart';
import 'package:subctrl/l10n/app_localizations.dart';

class PriceLineChart extends StatelessWidget {
  const PriceLineChart({
    super.key,
    required this.points,
    required this.range,
    required this.onRange,
  });

  final List<ChartPoint> points;
  final ChartRange range;
  final ValueChanged<ChartRange> onRange;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final chart = context.chartTheme;
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (final r in ChartRange.values)
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: ChoiceChip(
                  label: Text(l10n.chartRangeLabel(r)),
                  selected: range == r,
                  onSelected: (_) => onRange(r),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (points.length < 2)
          Text(l10n.chartNoHistory, style: AppTypography.body(c.textMuted))
        else
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                minY: 0,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: c.chartGrid.withValues(alpha: chart.gridOpacity),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (v, _) => Text(
                        v.toStringAsFixed(0),
                        style: AppTypography.mono.copyWith(fontSize: 10, color: c.textMuted),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, meta) {
                        if (v.toInt() < 0 || v.toInt() >= points.length) return const SizedBox.shrink();
                        return Text(
                          DateFormat('MM/yy').format(points[v.toInt()].date),
                          style: AppTypography.mono.copyWith(fontSize: 10, color: c.textMuted),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => c.surfaceHigh,
                    getTooltipItems: (spots) => spots
                        .map(
                          (s) => LineTooltipItem(
                            s.barIndex == 0
                                ? 'Official ${s.y.toStringAsFixed(2)}'
                                : 'Actual ${s.y.toStringAsFixed(2)}',
                            AppTypography.body(c.textPrimary).copyWith(fontSize: 12),
                          ),
                        )
                        .toList(),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      for (var i = 0; i < points.length; i++) FlSpot(i.toDouble(), points[i].official),
                    ],
                    isCurved: false,
                    color: c.chartSecondary,
                    barWidth: chart.strokeWidth,
                    dotData: FlDotData(show: true, getDotPainter: (a, b, c2, i) {
                      return FlDotCirclePainter(radius: chart.dotRadius, color: c.chartSecondary);
                    }),
                  ),
                  LineChartBarData(
                    spots: [
                      for (var i = 0; i < points.length; i++) FlSpot(i.toDouble(), points[i].actual),
                    ],
                    isCurved: false,
                    color: c.chartPrimary,
                    barWidth: chart.strokeWidth,
                    dotData: FlDotData(show: true, getDotPainter: (a, b, c2, i) {
                      return FlDotCirclePainter(radius: chart.dotRadius, color: c.chartPrimary);
                    }),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 8),
        Text(l10n.chartLegend, style: AppTypography.label(c.textMuted)),
      ],
    );
  }
}
