import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/toast.dart';
import '../cubit/phishing_cubit.dart';
import '../cubit/phishing_state.dart';

class PhishingForm extends StatelessWidget {
  const PhishingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhishingCubit, PhishingState>(
      builder: (context, state) {
        if (state.status == PhishingStateEnum.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == PhishingStateEnum.failure) {
          return Center(child: Text(state.errorMessage ?? 'Error occurred'));
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
              'Subject: ${req.emailSubject}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Text('Email:', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 2,
              runSpacing: 2,
              children: List.generate(req.parts.length, (i) {
                if (state.selectedPartIndices.contains(i)) {
                  return const SizedBox.shrink();
                }
                final part = req.parts[i];
                return Draggable<int>(
                  data: i,
                  feedback: Material(
                    child: Container(
                      padding: const EdgeInsets.all(8),
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
            const SizedBox(height: 12),
            Text(
              'Drag phishing parts here:',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
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
                  ToastService.showErrorToast(
                    message: 'This part is not phishing',
                  );
                }
              },
              builder: (ctx, accepted, rejected) {
                return Container(
                  height: 100,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            state.selectedPartIndices.map((i) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
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

            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: isSubmitEnabled
                      ? () => context.read<PhishingCubit>().submit()
                      : null,
                  child: const Text('Submit'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: context.read<PhishingCubit>().skip,
                  child: const Text('Skip'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showReasonDialog(BuildContext context, int partIndex) {
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
              title: const Text('Why is this phishing?'),
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
                      Navigator.of(ctx).pop();
                    } else {
                      ToastService.showErrorToast(
                        message: 'Wrong reason – try again.',
                      );
                    }
                  },
                  child: const Text('Confirm'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildPart(String text, {TextStyle? style}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black),
      ),
      child: Text(text, style: style),
    );
  }
}
