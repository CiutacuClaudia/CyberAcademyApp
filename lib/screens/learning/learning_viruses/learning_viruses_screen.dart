import 'package:disertatie/screens/learning/learning_viruses/widgets/learning_viruses_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'cubit/learning_viruses_cubit.dart';
import 'cubit/learning_viruses_state.dart';
import 'models/learning_viruses_request.dart';

class LearningVirusesScreen extends StatelessWidget {
  const LearningVirusesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => LearningVirusesCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text(loc.viruses)),
        body: BlocBuilder<LearningVirusesCubit, LearningVirusesState>(
          builder: (context, state) {
            switch (state.status) {
              case LearningVirusesStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case LearningVirusesStatus.success:
                final virusesTypes =
                    state.data.isNotEmpty
                        ? state.data.first.subtitles
                        : <VirusesType>[];
                return ListView.builder(
                  itemCount: virusesTypes.length,
                  itemBuilder: (_, i) {
                    final t = virusesTypes[i];
                    return ListTile(
                      title: Text(t.title),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => LearningVirusesDetailScreen(
                                    virusesType: t,
                                  ),
                            ),
                          ),
                    );
                  },
                );
              case LearningVirusesStatus.failure:
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
