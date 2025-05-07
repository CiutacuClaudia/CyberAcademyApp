import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShellWithNavbar extends StatefulWidget {
  const ShellWithNavbar({
    required this.navigationShell,
    required this.children,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  State<ShellWithNavbar> createState() => _ShellWithNavbarState();
}

class _ShellWithNavbarState extends State<ShellWithNavbar> {
  late TabController tabController;

  @override
  void didUpdateWidget(ShellWithNavbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        tabController.index = widget.navigationShell.currentIndex;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: widget.children.length,
      initialIndex: widget.navigationShell.currentIndex,
      child: Scaffold(
        extendBody: true,
        body: Builder(
          builder: (BuildContext context) {
            tabController = DefaultTabController.of(context);
            return TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: widget.children,
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: loc.homeTitle,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.school),
              label: loc.learningTitle,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: loc.settingsTitle,
            ),
          ],
          currentIndex: widget.navigationShell.currentIndex,
          onTap: (int index) => _onTap(context, index),
          backgroundColor: colorScheme.surfaceContainer,
          selectedItemColor: colorScheme.primary,
          unselectedItemColor: colorScheme.onSurfaceVariant,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
