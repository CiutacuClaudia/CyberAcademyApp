import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../common/widgets/toast.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../utils/dimensions.dart';
import '../cubit/xss_cubit.dart';
import '../cubit/xss_state.dart';

class XssForm extends StatefulWidget {
  const XssForm({super.key});

  @override
  State<XssForm> createState() => _XssFormState();
}

class _XssFormState extends State<XssForm> {
  final TextEditingController _controller = TextEditingController();

  bool _detectXss(String input) {
    final script = RegExp(r"<script>(.*?)</script>", caseSensitive: false);
    final onError = RegExp(r"onerror\s*=\s*", caseSensitive: false);
    return (script.hasMatch(input) && input.contains("alert")) ||
        (onError.hasMatch(input) && input.contains("alert"));
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocBuilder<XssCubit, XssState>(
      builder: (context, state) {
        if (state.status == XssStateEnum.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == XssStateEnum.failure) {
          return Center(child: Text(state.errorMessage ?? loc.anErrorOccurred));
        }
        final ch = state.currentChallenge!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '📄 ${loc.blog}${ch.blogContent}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: Dimensions.size_4),
            Text("💬 ${loc.commentsSoFar}"),
            const SizedBox(height: Dimensions.size_2),
            ...ch.comments.map((c) => Html(data: c)),
            const Divider(),

            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: loc.injectComment,
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: Dimensions.size_2),
            ElevatedButton(
              onPressed: () {
                final txt = _controller.text;
                if (_detectXss(txt)) {
                  ToastService.showSuccessToast(message: "🎉 ${ch.flag}");
                }
                context.read<XssCubit>().submitComment(txt);
                _controller.clear();
              },
              child: Text(loc.postComment),
            ),
            const SizedBox(height: Dimensions.size_2),

            ElevatedButton(
              onPressed: context.read<XssCubit>().next,
              child: Text(loc.nextChallenge),
            ),
          ],
        );
      },
    );
  }
}
