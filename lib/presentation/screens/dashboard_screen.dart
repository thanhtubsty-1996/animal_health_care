import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildNextAppointmentCard(context),
            const SizedBox(height: 16),
            _buildMetricsGrid(context),
            const SizedBox(height: 16),
            _buildChartCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildNextAppointmentCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 6.0,
      shadowColor: colorScheme.primary.withAlpha((255 * 0.2).round()),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.alarm, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  'LỊCH HẸN TIẾP THEO',
                  style: GoogleFonts.poppins(
                    color: Colors.white.withAlpha((255 * 0.9).round()),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Kiểm tra sức khỏe cho Chó Vàng',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '10:00 AM - Hôm nay',
              style: GoogleFonts.openSans(
                color: Colors.white.withAlpha((255 * 0.8).round()),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white.withAlpha((255 * 0.5).round())),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Chi tiết'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsGrid(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _MetricCard(
            label: 'Thú cưng',
            value: '12',
            icon: Icons.pets_outlined,
            color: Colors.orange,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _MetricCard(
            label: 'Báo cáo mới',
            value: '3',
            icon: Icons.article_outlined,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildChartCard(BuildContext context) {
    return Card(
      elevation: 2.0,
      shadowColor: Colors.black.withAlpha((255 * 0.05).round()),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lịch hẹn 7 ngày tới',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
            const SizedBox(height: 24),
            const _SimpleBarChart(),
          ],
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shadowColor: Colors.black.withAlpha((255 * 0.05).round()),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 12),
            Text(
              label,
              style: GoogleFonts.openSans(
                fontSize: 14, 
                color: Theme.of(context).textTheme.bodyMedium?.color?.withAlpha((255 * 0.7).round()),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 28, 
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SimpleBarChart extends StatelessWidget {
  const _SimpleBarChart();

  final List<double> weeklyData = const [10, 15, 30, 25, 40, 20, 35];
  final List<String> days = const ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];

  @override
  Widget build(BuildContext context) {
    final maxVal = weeklyData.reduce(math.max);
    final primaryColor = Theme.of(context).colorScheme.primary;

    return SizedBox(
      height: 120.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch, // Cho phép các cột con co giãn đầy đủ
        children: List.generate(weeklyData.length, (index) {
          final relativeHeight = weeklyData[index] / maxVal;

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: relativeHeight, // Chiều cao là tỷ lệ phần trăm của không gian có sẵn
                    child: Container(
                      width: 20,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha((255 * (0.5 + (relativeHeight / 2))).round()),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                days[index],
                style: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          );
        }),
      ),
    );
  }
}
