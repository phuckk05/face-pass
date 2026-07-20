import 'package:facepass/core/constants/app_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/attendance.dart';

class LateAttendanceChart extends StatefulWidget {
  final List<Attendance> attendances;

  const LateAttendanceChart({
    super.key,
    required this.attendances,
  });

  @override
  State<LateAttendanceChart> createState() => _LateAttendanceChartState();
}

class _LateAttendanceChartState extends State<LateAttendanceChart> {
  bool _isShowingAll = false;

  late Map<DateTime, int> _counts;
  late List<DateTime> _dateRange;
  late int _maxY;

  @override
  void initState() {
    super.initState();
    _processChartData();
  }

  @override
  void didUpdateWidget(covariant LateAttendanceChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.attendances != widget.attendances) {
      _processChartData();
    }
  }

  /// Xử lý và chuẩn bị dữ liệu biểu đồ.
  void _processChartData() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    _counts = <DateTime, int>{};

    for (var a in widget.attendances) {
      final d = DateTime(a.checkedAt.year, a.checkedAt.month, a.checkedAt.day);
      _counts[d] = (_counts[d] ?? 0) + 1;
    }

    if (_isShowingAll) {
      _dateRange = _counts.keys.toList()..sort((a, b) => a.compareTo(b));
    } else {
      _dateRange = List.generate(7, (index) {
        final d = today.subtract(Duration(days: 6 - index));
        _counts.putIfAbsent(d, () => 0);
        return d;
      });
    }

    _maxY = 0;
    for (var date in _dateRange) {
      if ((_counts[date] ?? 0) > _maxY) _maxY = _counts[date]!;
    }
    _maxY = _maxY < 5 ? 5 : _maxY + 2;
  }

  void _toggleViewMode() {
    setState(() {
      _isShowingAll = !_isShowingAll;
      _processChartData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildChartContainer(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final title = _isShowingAll
        ? 'Thống kê đi trễ (Tất cả)'
        : 'Thống kê đi trễ (7 ngày qua)';

    final buttonText = _isShowingAll ? '7 ngày qua' : 'Xem tất cả';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.body.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: _toggleViewMode,
          child: Text(
            buttonText,
            style: AppStyles.body.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChartContainer(BuildContext context) {
    double chartWidth = MediaQuery.of(context).size.width - 64;

    if (_isShowingAll) {
      final requiredWidth = _dateRange.length * 45.0;
      if (requiredWidth > chartWidth) {
        chartWidth = requiredWidth;
      }
    }

    return SizedBox(
      height: 200,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: chartWidth,
          child: BarChart(_createChartData()),
        ),
      ),
    );
  }

  BarChartData _createChartData() {
    const double barWidth = 16.0;

    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: _maxY.toDouble(),
      barTouchData: BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.black87,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              '${rod.toY.toInt()} người',
              const TextStyle(color: Colors.white),
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: _bottomTitlesWidget,
            reservedSize: 30,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: _leftTitlesWidget,
            reservedSize: 30,
            interval: _maxY > 10 ? (_maxY / 5).ceilToDouble() : 1,
          ),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: _maxY > 10 ? (_maxY / 5).ceilToDouble() : 1,
        getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.grey.withOpacity(0.2),
          strokeWidth: 1,
        ),
      ),
      borderData: FlBorderData(show: false),
      barGroups: _createBarGroups(barWidth),
    );
  }

  Widget _bottomTitlesWidget(double value, TitleMeta meta) {
    final index = value.toInt();
    if (index >= 0 && index < _dateRange.length) {
      final date = _dateRange[index];
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          '${date.day}/${date.month}',
          style: AppStyles.bodySmall.copyWith(fontSize: 10),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _leftTitlesWidget(double value, TitleMeta meta) {
    if (value == value.toInt()) {
      return Text(
        value.toInt().toString(),
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  List<BarChartGroupData> _createBarGroups(double barWidth) {
    return _dateRange.asMap().entries.map((entry) {
      final index = entry.key;
      final date = entry.value;
      final count = _counts[date] ?? 0;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: count.toDouble(),
            color: AppColors.primary,
            width: barWidth,
            borderRadius: BorderRadius.circular(4),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: _maxY.toDouble(),
              color: AppColors.primary.withOpacity(0.1),
            ),
          ),
        ],
      );
    }).toList();
  }
}
