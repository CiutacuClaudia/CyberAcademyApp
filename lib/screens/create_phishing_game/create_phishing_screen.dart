import 'package:disertatie/screens/create_phishing_game/widgets/create_phishing_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common/widgets/toast.dart';
import '../../utils/dimensions.dart';
import '../phishing/models/phishing_request.dart';
import 'cubit/create_phishing_cubit.dart';
import 'cubit/create_phishing_state.dart';

class CreatePhishingScreen extends StatelessWidget {
  const CreatePhishingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => CreatePhishingCubit()..loadReasons(),
      child: BlocListener<CreatePhishingCubit, CreatePhishingState>(
        listener: (ctx, state) {
          if (state.status == CreatePhishingStatus.success &&
              state.justSubmitted) {
            ToastService.showSuccessToast(message: loc.savedSuccessfully);
          }
          if (state.status == CreatePhishingStatus.failure &&
              state.errorMessage != null) {
            ToastService.showErrorToast(message: state.errorMessage!);
          }
        },
        child: Scaffold(
          appBar: AppBar(title: Text(loc.buildPhishingExercise)),
          body: Padding(
            padding: const EdgeInsets.all(Dimensions.size_3),
            child: BlocBuilder<CreatePhishingCubit, CreatePhishingState>(
              builder: (ctx, state) {
                if (state.status == CreatePhishingStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: loc.emailSubject),
                      onChanged: ctx.read<CreatePhishingCubit>().updateSubject,
                    ),
                    const SizedBox(height: Dimensions.size_3),

                    Expanded(
                      child: ReorderableListView(
                        onReorder: ctx.read<CreatePhishingCubit>().reorderPart,
                        children: [
                          for (var i = 0; i < state.parts.length; i++)
                            _PartRow(index: i, key: ValueKey(i)),
                        ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        icon: const Icon(Icons.add),
                        label: Text(loc.addPart),
                        onPressed: ctx.read<CreatePhishingCubit>().addEmptyPart,
                      ),
                    ),
                    const SizedBox(height: Dimensions.size_2),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed:
                              state.canPreview
                                  ? () => _showPreviewDialog(context, state)
                                  : null,
                          child: Text(loc.preview),
                        ),
                        ElevatedButton(
                          onPressed:
                              state.canSubmit
                                  ? () =>
                                      ctx.read<CreatePhishingCubit>().submit()
                                  : null,
                          child: Text(loc.savePublish),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.size_3),

                    ExpansionTile(
                      title: Text(loc.hintsAndBestPractices),
                      children: [
                        ListTile(
                          title: Text('• ${loc.useAtLeastThreePhishingParts}'),
                        ),
                        ListTile(title: Text('• ${loc.varyToneAndUrgency}')),
                        ListTile(title: Text('• ${loc.keepTextsConcise}')),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showPreviewDialog(BuildContext context, CreatePhishingState state) {
    final parts =
        state.parts.map((p) {
          final desc =
              p.isPhishing
                  ? state.reasons
                      .firstWhere((r) => r.id == p.reasonId)
                      .description
                  : '';
          return PhishingPart(
            text: p.text,
            phishing: p.isPhishing,
            reason: desc,
          );
        }).toList();

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(AppLocalizations.of(ctx)!.preview),
            content: SizedBox(
              width: double.maxFinite,
              height: 400,
              child: PhishingPreview(subject: state.subject, parts: parts),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(AppLocalizations.of(ctx)!.cancel),
              ),
            ],
          ),
    );
  }
}

class _PartRow extends StatelessWidget {
  final int index;

  const _PartRow({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreatePhishingCubit>();
    final state = context.watch<CreatePhishingCubit>().state;
    final part = state.parts[index];
    final loc = AppLocalizations.of(context)!;

    return Card(
      key: ValueKey(index),
      margin: const EdgeInsets.symmetric(vertical: Dimensions.size_1),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.size_2),
        child: Row(
          children: [
            const Icon(Icons.drag_handle),
            const SizedBox(width: Dimensions.size_2),
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: loc.partText),
                onChanged: (v) => cubit.updatePartText(index, v),
              ),
            ),
            const SizedBox(width: Dimensions.size_2),
            Column(
              children: [
                Checkbox(
                  value: part.isPhishing,
                  onChanged: (_) {
                    if (!part.isPhishing) {
                      cubit.showReasonDialog(context, index);
                    } else {
                      cubit.togglePartPhishing(index);
                    }
                  },
                ),
                Text(loc.phishing),
              ],
            ),
            const SizedBox(width: Dimensions.size_2),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => cubit.removePart(index),
            ),
          ],
        ),
      ),
    );
  }
}
