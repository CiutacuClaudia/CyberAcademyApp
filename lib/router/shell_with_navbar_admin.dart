import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdminShellWithNavbar extends StatefulWidget {
  const AdminShellWithNavbar({
    super.key,
    required this.navigationShell,
    required this.children,
  });

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  State<AdminShellWithNavbar> createState() => _AdminShellWithNavbarState();
}

class _AdminShellWithNavbarState extends State<AdminShellWithNavbar> {
  late TabController _tabController;

  @override
  void didUpdateWidget(covariant AdminShellWithNavbar old) {
    super.didUpdateWidget(old);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _tabController.index = widget.navigationShell.currentIndex;
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
            _tabController = DefaultTabController.of(context);
            return TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: widget.children,
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.add_circle_outline_outlined),
              label: loc.homeTitle,
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
