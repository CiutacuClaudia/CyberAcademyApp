import 'package:disertatie/screens/learning/learning_phishing/widgets/learning_phishing_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/widgets/custom_button_widget.dart';
import '../../../utils/dimensions.dart';
import 'cubit/learning_phishing_cubit.dart';
import 'cubit/learning_phishing_state.dart';
import 'models/learning_phishing_request.dart';

class LearningPhishingScreen extends StatelessWidget {
  const LearningPhishingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LearningPhishingCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Phishing')),
        body: BlocBuilder<LearningPhishingCubit, LearningPhishingState>(
          builder: (context, state) {
            switch (state.status) {
              case LearningPhishingStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case LearningPhishingStatus.failure:
                return Center(
                  child: Text(state.errorMessage ?? 'Error loading cards'),
                );

              case LearningPhishingStatus.success:
                final state = context.watch<LearningPhishingCubit>().state;
                final idx = state.currentIndex;
                if (idx < state.cards.length) {
                  final card = state.cards[idx];
                  return _buildCardView(context, card, () {
                    context.read<LearningPhishingCubit>().nextCard();
                  });
                } else {
                  return _buildCongrats();
                }
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _buildCardView(
    BuildContext context,
    PhishingCard card,
    VoidCallback onNext,
  ) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.size_4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlipCardWidget(
              key: ValueKey(card.id),
              frontText: card.frontText,
              backText: card.backText,
            ),
            const SizedBox(height: Dimensions.size_16),
            CustomButtonWidget(label: "Next", onPressed: onNext),
          ],
        ),
      ),
    );
  }

  Widget _buildCongrats() {
    return Center(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            '🎉 Congratulations!\nYou’ve completed the Phishing module.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
