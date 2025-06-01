import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import '../../common/widgets/custom_button_widget.dart';
import '../../utils/dimensions.dart';
import 'cubit/settings_cubit.dart';
import 'cubit/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit()..loadUser(),
      child: _SettingsView(),
    );
  }
}

class _SettingsView extends StatefulWidget {
  @override
  State<_SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<_SettingsView> {
  final _storage = const FlutterSecureStorage();

  void _logout() async {
    await _storage.deleteAll();
    if (!mounted) return;
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (ctx, state) {
          switch (state.status) {
            case SettingsStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case SettingsStatus.failure:
              return Center(child: Text(state.errorMessage!));
            case SettingsStatus.success:
              final user = state.user!;
              return Padding(
                padding: const EdgeInsets.all(Dimensions.size_4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (user.isAdmin)
                      Column(
                        children: [
                          Text(
                            loc.userCodeLabel,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: Dimensions.size_2),
                          SelectableText(
                            user.userCode,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: Dimensions.size_6),
                        ],
                      ),
                    CustomButtonWidget(onPressed: _logout, label: loc.logOut),
                  ],
                ),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
