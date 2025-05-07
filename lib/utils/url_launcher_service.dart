import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/widgets/toast.dart';

class UrlLauncherService {
  /// Opens the given [url] using [launchUrl] with the specified [mode].
  /// Shows an error toast if the URL cannot be launched.
  static Future<void> openUrl(
    BuildContext context, {
    required String url,
    String? errorMessage,
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    final localizedErrorMessage =
        AppLocalizations.of(context)!.couldNotLaunchUrl;
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: mode);
    } else {
      ToastService.showErrorToast(
        message: errorMessage ?? localizedErrorMessage,
      );
    }
  }
}
