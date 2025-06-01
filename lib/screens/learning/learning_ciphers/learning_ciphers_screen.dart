import 'package:disertatie/screens/learning/learning_ciphers/widgets/learning_ciphers_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../common/widgets/custom_book_button.dart';
import '../../../utils/dimensions.dart';
import 'cubit/learning_ciphers_cubit.dart';
import 'cubit/learning_ciphers_state.dart';
import 'models/learning_ciphers_request.dart';

class LearningCiphersScreen extends StatelessWidget {
  const LearningCiphersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => LearningCiphersCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text(loc.ciphers)),
        body: BlocBuilder<LearningCiphersCubit, LearningCiphersState>(
          builder: (context, state) {
            switch (state.status) {
              case LearningCiphersStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case LearningCiphersStatus.success:
                final cipherTypes =
                    state.data.isNotEmpty
                        ? state.data.first.subtitles
                        : <CipherType>[];
                return ListView.builder(
                  padding: const EdgeInsets.all(Dimensions.size_4),
                  itemCount: cipherTypes.length,
                  itemBuilder: (context, i) {
                    final t = cipherTypes[i];
                    return CustomBookButton(
                      label: t.title,
                      onPressed:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) =>
                                      LearningCipherDetailScreen(cipherType: t),
                            ),
                          ),
                    );
                  },
                );
              case LearningCiphersStatus.failure:
                return Center(
                  child: Text(state.errorMessage ?? loc.errorLoadingLessons),
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
