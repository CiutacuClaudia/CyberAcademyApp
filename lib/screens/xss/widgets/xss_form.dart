import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/widgets/toast.dart';
import 'package:flutter_html/flutter_html.dart';
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
    return BlocBuilder<XssCubit, XssState>(
      builder: (context, state) {
        if (state.status == XssStateEnum.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == XssStateEnum.failure) {
          return Center(child: Text(state.errorMessage ?? 'Error'));
        }
        final ch = state.currentChallenge!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "📄 Blog:\n${ch.blogContent}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text("💬 Comments so far:"),
            const SizedBox(height: 8),
            ...ch.comments.map((c) => Html(data: c)),
            const Divider(),

            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Inject your comment here...",
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final txt = _controller.text;
                if (_detectXss(txt)) {
                  ToastService.showSuccessToast(
                    message: "🎉 ${ch.flag}\nCookie stolen!",
                  );
                }
                context.read<XssCubit>().submitComment(txt);
                _controller.clear();
              },
              child: const Text("Post Comment"),
            ),
            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: context.read<XssCubit>().next,
              child: const Text("Next Challenge"),
            ),
          ],
        );
      },
    );
  }
}
