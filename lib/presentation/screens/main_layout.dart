import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MainLayout extends StatefulWidget {
  // Nhận child từ ShellRoute
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final double _drawerWidth = 275.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleDrawer() {
    _controller.isCompleted ? _controller.reverse() : _controller.forward();
  }

  // Lấy index hiện tại dựa trên route
  int _calculateSelectedIndex(BuildContext context) {
    final GoRouterState route = GoRouterState.of(context);
    final String location = route.uri.toString();
    if (location == '/') return 0;
    if (location.startsWith('/clinic')) return 1; 
    if (location.startsWith('/settings')) return 2;
    return 0;
  }

  // Điều hướng khi item được chọn
  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/clinic');
        break;
      case 2:
        context.go('/settings');
        break;
    }
    // Đóng drawer sau khi điều hướng
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Stack(
        children: <Widget>[
          _buildDrawer(context),
          _buildAnimatedMainContent(context),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final int selectedIndex = _calculateSelectedIndex(context);

    const List<Map<String, dynamic>> destinations = [
      {'icon': Icons.dashboard_outlined, 'selectedIcon': Icons.dashboard, 'label': 'Tổng quan'},
      {'icon': Icons.local_hospital_outlined, 'selectedIcon': Icons.local_hospital, 'label': 'Phòng khám'},
      {'icon': Icons.settings_outlined, 'selectedIcon': Icons.settings, 'label': 'Cài đặt'},
    ];

    return SafeArea(
      child: Container(
        width: _drawerWidth,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 24.0, top: 16.0),
              child: Text(
                'Animal Health',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            for (int i = 0; i < destinations.length; i++)
              ListTile(
                leading: Icon(
                  selectedIndex == i
                      ? destinations[i]['selectedIcon']
                      : destinations[i]['icon'],
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                title: Text(
                  destinations[i]['label'],
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                selected: selectedIndex == i,
                onTap: () => _onItemTapped(i, context),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                selectedTileColor: Theme.of(context).colorScheme.primary.withAlpha(50),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedMainContent(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final slideAmount = _drawerWidth * _controller.value;
        final scaleAmount = 1 - (_controller.value * 0.25);
        final angle = _controller.value * -math.pi / 12;
        final cornerRadius = 32.0 * _controller.value;

        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..translate(slideAmount, 0.0, 0.0)
            ..scale(scaleAmount, scaleAmount)
            ..rotateY(angle),
          alignment: Alignment.centerLeft,
          child: Material(
            elevation: 8.0,
            borderRadius: BorderRadius.circular(cornerRadius),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(cornerRadius),
              child: child, // Hiển thị child từ ShellRoute
            ),
          ),
        );
      },
      // Bọc child của MainLayout vào đây
      child: GestureDetector(
         onTap: () {
          if (_controller.isCompleted) {
            _toggleDrawer();
          }
        },
        onHorizontalDragUpdate: (details) {
          _controller.value += details.primaryDelta! / _drawerWidth;
        },
        onHorizontalDragEnd: (details) {
          if (_controller.value >= 0.5 || details.primaryVelocity! > 300) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        },
        // Thay thế Scaffold tĩnh bằng widget.child
        child: widget.child,
      ),
    );
  }
}
