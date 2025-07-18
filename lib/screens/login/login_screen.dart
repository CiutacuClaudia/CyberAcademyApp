import 'package:disertatie/screens/login/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import '../../common/widgets/toast.dart';
import '../../utils/storage_keys.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';
import '../../utils/routes.dart';
import '../../utils/dimensions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) async {
          if (state.status == LoginStateEnum.success) {
            final storage = const FlutterSecureStorage();
            final isAdminStr = await storage.read(key: StorageKeys.isAdmin);
            final isAdmin = (isAdminStr?.toLowerCase() == 'true');
            context.goNamed(
              isAdmin ? Routes.adminHomeScreen.name : Routes.homeScreen.name,
            );
            ToastService.showSuccessToast(message: loc.loginSuccessful);
          } else if (state.status == LoginStateEnum.failure) {
            ToastService.showErrorToast(message: loc.somethingWentWrongError);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(Dimensions.size_6),
              child: Card(
                color: colorScheme.primaryFixed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.size_4),
                ),
                elevation: Dimensions.size_2,
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.size_4),
                  child: BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state.status == LoginStateEnum.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return const LoginForm();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
