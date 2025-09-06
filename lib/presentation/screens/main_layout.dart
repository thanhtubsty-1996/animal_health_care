import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout>
    with TickerProviderStateMixin { // Changed to TickerProviderStateMixin
  late final AnimationController _drawerController;
  late final AnimationController _hintController;

  final double _drawerWidth = 275.0;

  @override
  void initState() {
    super.initState();
    _drawerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _hintController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _drawerController.addListener(() {
      if (_drawerController.isCompleted || _drawerController.value > 0.1) {
        _hintController.stop();
      } else if (_drawerController.isDismissed) {
        _hintController.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _drawerController.dispose();
    _hintController.dispose();
    super.dispose();
  }

  void _toggleDrawer() {
    _drawerController.isCompleted
        ? _drawerController.reverse()
        : _drawerController.forward();
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location == '/') return 0;
    if (location.startsWith('/clinic')) return 1;
    if (location.startsWith('/settings')) return 2;
    return 0;
  }

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
    _drawerController.reverse();
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
      animation: _drawerController,
      builder: (context, child) {
        final slideAmount = _drawerWidth * _drawerController.value;
        final scaleAmount = 1 - (_drawerController.value * 0.25);
        final angle = _drawerController.value * -math.pi / 12;
        final cornerRadius = 32.0 * _drawerController.value;

        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..setEntry(0, 3, slideAmount)
          ..scale(scaleAmount, scaleAmount)
          ..rotateY(angle);

        return Transform(
          transform: transform,
          alignment: Alignment.centerLeft,
          child: Material(
            elevation: 8.0,
            borderRadius: BorderRadius.circular(cornerRadius),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(cornerRadius),
              child: Stack(
                children: [
                  child!,
                  _buildDragHint(),
                ],
              ),
            ),
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          if (_drawerController.isCompleted) {
            _toggleDrawer();
          }
        },
        onHorizontalDragUpdate: (details) {
          _drawerController.value += details.primaryDelta! / _drawerWidth;
        },
        onHorizontalDragEnd: (details) {
          if (_drawerController.value >= 0.5 || details.primaryVelocity! > 300) {
            _drawerController.forward();
          } else {
            _drawerController.reverse();
          }
        },
        child: widget.child,
      ),
    );
  }
  
  Widget _buildDragHint() {
    return AnimatedBuilder(
      animation: Listenable.merge([_drawerController, _hintController]),
      builder: (context, child) {
        // Opacity fades out the hint as the drawer opens.
        final double hintOpacity = (1.0 - (_drawerController.value * 5.0)).clamp(0.0, 1.0);
        // The hint animation itself (subtle slide).
        final double hintPosition = _hintController.value * -8.0;

        if (hintOpacity == 0) return const SizedBox.shrink();

        return Positioned(
          top: 0,
          bottom: 0,
          left: hintPosition + 8,
          child: Center(
            child: Opacity(
              opacity: hintOpacity,
              child: Container(
                 decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
                ),
                width: 20,
                height: 60,
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
