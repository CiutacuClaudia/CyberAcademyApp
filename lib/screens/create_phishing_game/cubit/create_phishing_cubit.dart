import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../network/config/api_result.dart';
import '../../phishing/cubit/phishing_state.dart';
import '../../phishing/models/phishing_reason_request.dart';
import '../../phishing/models/phishing_request.dart';
import '../../phishing/repository/phishing_repository.dart';
import '../model/create_phishing_part.dart';
import '../model/create_phishing_request.dart';
import '../repository/create_phishing_repository.dart';
import 'create_phishing_state.dart';

class CreatePhishingCubit extends Cubit<CreatePhishingState> {
  final PhishingRepository _userRepo;
  final CreatePhishingRepository _repo;

  CreatePhishingCubit({
    PhishingRepository? userRepo,
    CreatePhishingRepository? repo,
  }) : _userRepo = userRepo ?? PhishingRepository(),
       _repo = repo ?? CreatePhishingRepository(),
       super(const CreatePhishingState(status: CreatePhishingStatus.initial));

  Future<void> loadReasons() async {
    emit(state.copyWith(status: CreatePhishingStatus.loading));
    final res = await _userRepo.getPhishingReasons();
    if (res is ApiFailure) {
      final failure = res as ApiFailure;
      emit(
        state.copyWith(
          status: CreatePhishingStatus.failure,
          errorMessage: failure.message,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: CreatePhishingStatus.success,
          reasons: (res as ApiSuccess<List<PhishingReasonRequest>>).data,
        ),
      );
    }
  }

  void updateSubject(String v) => emit(state.copyWith(subject: v.trim()));

  void addEmptyPart() {
    final parts = [...state.parts, const CreatePhishingPart()];
    emit(state.copyWith(parts: parts));
  }

  void removePart(int i) {
    final parts = [...state.parts]..removeAt(i);
    emit(state.copyWith(parts: parts));
  }

  void reorderPart(int oldI, int newI) {
    final parts = [...state.parts];
    final item = parts.removeAt(oldI);
    parts.insert(newI > oldI ? newI - 1 : newI, item);
    emit(state.copyWith(parts: parts));
  }

  void updatePartText(int i, String t) {
    final parts = [...state.parts];
    parts[i] = parts[i].copyWith(text: t);
    emit(state.copyWith(parts: parts));
  }

  void togglePartPhishing(int i) {
    final parts = [...state.parts];
    parts[i] = parts[i].copyWith(
      isPhishing: !parts[i].isPhishing,
      reasonId: parts[i].isPhishing ? null : parts[i].reasonId,
    );
    emit(state.copyWith(parts: parts));
  }

  void updatePartReason(int i, int reasonId) {
    final parts = [...state.parts];
    parts[i] = parts[i].copyWith(reasonId: reasonId);
    emit(state.copyWith(parts: parts));
  }

  void showReasonDialog(BuildContext context, int partIndex) {
    final loc = AppLocalizations.of(context)!;
    final reasons = state.reasons;
    int? selected;

    showDialog(
      context: context,
      builder:
          (ctx) => StatefulBuilder(
            builder:
                (ctx, setState) => AlertDialog(
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
                              groupValue: selected,
                              onChanged: (v) => setState(() => selected = v),
                            );
                          }).toList(),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed:
                          selected == null
                              ? null
                              : () {
                                togglePartPhishing(partIndex);
                                updatePartReason(partIndex, selected!);
                                Navigator.of(ctx).pop();
                              },
                      child: Text(loc.confirm),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text(loc.cancel),
                    ),
                  ],
                ),
          ),
    );
  }

  Future<void> submit() async {
    if (!state.canSubmit) return;
    emit(state.copyWith(status: CreatePhishingStatus.loading));

    final req = CreatePhishingRequest(
      emailSubject: state.subject,
      parts: state.parts,
      reasons: state.reasons,
    );
    final res = await _repo.createPhishing(req);

    if (res is ApiFailure) {
      emit(
        state.copyWith(
          status: CreatePhishingStatus.failure,
          errorMessage: res.message,
          justSubmitted: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: CreatePhishingStatus.success,
          justSubmitted: true,
        ),
      );
    }
  }
}

class PreviewPhishingCubit extends Cubit<PhishingState> {
  PreviewPhishingCubit(PhishingRequest req, List<PhishingReasonRequest> reasons)
    : super(
        PhishingState(
          status: PhishingStateEnum.success,
          requests: [req],
          reasons: reasons,
          currentIndex: 0,
          selectedPartIndices: [],
        ),
      );
}
