import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/toast.dart';
import '../../../utils/dimensions.dart';
import '../cubit/phishing_cubit.dart';
import '../cubit/phishing_state.dart';

class PhishingForm extends StatelessWidget {
  const PhishingForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return BlocBuilder<PhishingCubit, PhishingState>(
      builder: (context, state) {
        if (state.status == PhishingStateEnum.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == PhishingStateEnum.failure) {
          return Center(child: Text(state.errorMessage ?? loc.anErrorOccurred));
        }
        final req = state.currentRequest!;
        final correctIndices = {
          for (int i = 0; i < req.parts.length; i++)
            if (req.parts[i].phishing) i,
        };
        final selected = state.selectedPartIndices.toSet();
        final isSubmitEnabled =
            selected.containsAll(correctIndices) &&
            correctIndices.containsAll(selected);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${loc.subject}: ${req.emailSubject}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: Dimensions.size_2),
            Text(loc.email, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: Dimensions.size_2),
            Wrap(
              spacing: Dimensions.size_0_5,
              runSpacing: Dimensions.size_0_5,
              children: List.generate(req.parts.length, (i) {
                if (state.selectedPartIndices.contains(i)) {
                  return const SizedBox.shrink();
                }
                final part = req.parts[i];
                return Draggable<int>(
                  data: i,
                  feedback: Material(
                    child: Container(
                      padding: const EdgeInsets.all(Dimensions.size_2),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Text(
                        part.text,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.4,
                    child: _buildPart(
                      part.text,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  child: _buildPart(
                    part.text,
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              }),
            ),
            const SizedBox(height: Dimensions.size_3),
            Text(
              loc.dragPhishingPartsHere,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: Dimensions.size_2),
            DragTarget<int>(
              onAccept: (index) {
                final part =
                    context
                        .read<PhishingCubit>()
                        .state
                        .currentRequest!
                        .parts[index];
                if (part.phishing) {
                  _showReasonDialog(context, index);
                } else {
                  ToastService.showErrorToast(message: loc.notPhishing);
                }
              },
              builder: (ctx, accepted, rejected) {
                return Container(
                  height: 100,
                  width: double.infinity,
                  padding: const EdgeInsets.all(Dimensions.size_2),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: Dimensions.size_0_5,
                    ),
                  ),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            state.selectedPartIndices.map((i) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.size_1,
                                ),
                                child: Chip(label: Text(req.parts[i].text)),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: Dimensions.size_3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed:
                      isSubmitEnabled
                          ? () => context.read<PhishingCubit>().submit()
                          : null,
                  child: Text(loc.submit),
                ),
                const SizedBox(width: Dimensions.size_2),
                ElevatedButton(
                  onPressed: context.read<PhishingCubit>().skip,
                  child: Text(loc.skip),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showReasonDialog(BuildContext context, int partIndex) {
    final loc = AppLocalizations.of(context)!;
    final state = context.read<PhishingCubit>().state;
    final reasons = state.reasons;
    final part = state.currentRequest!.parts[partIndex];

    int? selectedId;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            return AlertDialog(
              title: Text(loc.whyIsThisPhishing),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children:
                      reasons.map((r) {
                        return RadioListTile<int>(
                          title: Text(r.description),
                          value: r.id,
                          groupValue: selectedId,
                          onChanged: (val) => setState(() => selectedId = val),
                        );
                      }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (selectedId == null) return;
                    final chosen = reasons.firstWhere(
                      (r) => r.id == selectedId,
                    );
                    if (chosen.description == part.reason) {
                      context.read<PhishingCubit>().addPart(partIndex);
                      ctx.pop();
                    } else {
                      ToastService.showErrorToast(message: loc.wrongReason);
                    }
                  },
                  child: Text(loc.confirm),
                ),
                TextButton(onPressed: () => ctx.pop(), child: Text(loc.cancel)),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildPart(String text, {TextStyle? style}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.size_1,
        horizontal: Dimensions.size_2,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(Dimensions.size_1),
        border: Border.all(color: Colors.black),
      ),
      child: Text(text, style: style),
    );
  }
}
