import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/dimensions.dart';
import '../cubit/crypto_cubit.dart';
import '../cubit/crypto_state.dart';

class CryptoForm extends StatefulWidget {
  const CryptoForm({super.key});

  @override
  _CryptoFormState createState() => _CryptoFormState();
}

class _CryptoFormState extends State<CryptoForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userInputController = TextEditingController();
  final TextEditingController _finalEncryptedController =
      TextEditingController();
  List<TextEditingController> plaintextControllers = [];
  List<FocusNode> plaintextFocusNodes = [];

  @override
  void dispose() {
    _userInputController.dispose();
    _finalEncryptedController.dispose();
    for (final controller in plaintextControllers) {
      controller.dispose();
    }
    for (final node in plaintextFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptoCubit, CryptoState>(
      builder: (context, state) {
        if (state.status == CryptoStateEnum.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == CryptoStateEnum.failure) {
          return Center(child: Text(state.errorMessage ?? 'Error occurred'));
        }

        if (state.activeCipher == CipherType.playfair) {
          final cipher = state.currentPlayfairCipher;
          if (cipher == null) {
            return const Center(child: Text('No Playfair cipher available'));
          }
          final gridLetters = getPlayfairGrid(cipher.key);
          final boxes = preparePlaintextBoxes(cipher.plainText);

          return Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Plaintext: ${cipher.plainText}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: Dimensions.size_3),
                GridView.count(
                  crossAxisCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children:
                      gridLetters
                          .map(
                            (l) => Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(
                                  Dimensions.size_1,
                                ),
                              ),
                              padding: const EdgeInsets.all(1),
                              child: Center(
                                child: Text(
                                  l,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: Dimensions.size_4),
                Text(
                  'Enter Prepared Plaintext:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: Dimensions.size_2),
                buildPlaintextInputGrid(boxes.length),
                const SizedBox(height: Dimensions.size_4),
                TextFormField(
                  controller: _finalEncryptedController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Final Encrypted Text',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.characters,
                  validator:
                      (value) =>
                          (value == null || value.isEmpty)
                              ? 'Please enter the final encrypted text'
                              : null,
                ),
                const SizedBox(height: Dimensions.size_4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Submit'),
                    ),
                    const SizedBox(width: Dimensions.size_2),
                    ElevatedButton(onPressed: _skip, child: const Text('Skip')),
                  ],
                ),
              ],
            ),
          );
        } else if (state.activeCipher == CipherType.caesar) {
          final cipher = state.currentCaesarCipher;
          if (cipher == null) {
            return const Center(child: Text('No Caesar cipher available'));
          }
          return Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Plaintext: ${cipher.plainText}'),
                const SizedBox(height: Dimensions.size_4),
                Text('Key: ${cipher.key}'),
                const SizedBox(height: Dimensions.size_4),
                TextFormField(
                  controller: _userInputController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Encrypted Text',
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          (value == null || value.isEmpty)
                              ? 'Please enter the encrypted text'
                              : null,
                ),
                const SizedBox(height: Dimensions.size_4),
                ElevatedButton(onPressed: _submit, child: const Text('Submit')),
                const SizedBox(height: Dimensions.size_2),
                ElevatedButton(onPressed: _skip, child: const Text('Skip')),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  List<String> getPlayfairGrid(String key) {
    key = key.toUpperCase().replaceAll(RegExp(r'\s+'), '');
    List<String> grid = [];
    for (var char in key.characters) {
      if (char == 'J') continue;
      if (!grid.contains(char)) grid.add(char);
    }
    const String alphabet = 'ABCDEFGHIKLMNOPQRSTUVWXYZ';
    for (var char in alphabet.characters) {
      if (!grid.contains(char)) grid.add(char);
    }
    return grid;
  }

  List<String> preparePlaintextBoxes(String text) {
    text = text.toUpperCase().replaceAll(RegExp(r'\s+'), '');
    List<String> result = [];
    int i = 0;
    while (i < text.length) {
      String current = text[i];
      String next = (i + 1 < text.length) ? text[i + 1] : '';
      if (next.isNotEmpty && current == next) {
        result.add(current);
        result.add('X');
        i++;
      } else if (next.isNotEmpty) {
        result.add(current);
        result.add(next);
        i += 2;
      } else {
        result.add(current);
        result.add('X');
        i++;
      }
    }
    return result;
  }

  Widget buildPlaintextInputGrid(int totalCount) {
    if (plaintextControllers.length != totalCount) {
      for (var c in plaintextControllers) {
        c.dispose();
      }
      for (var f in plaintextFocusNodes) {
        f.dispose();
      }
      plaintextControllers = List.generate(
        totalCount,
        (_) => TextEditingController(),
      );
      plaintextFocusNodes = List.generate(totalCount, (_) => FocusNode());
    }

    List<Widget> fields = [];
    for (int i = 0; i < totalCount; i++) {
      fields.add(
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.all(2),
          child: TextFormField(
            controller: plaintextControllers[i],
            focusNode: plaintextFocusNodes[i],
            textAlign: TextAlign.center,
            maxLength: 1,
            decoration: const InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(4),
            ),
            style: const TextStyle(fontSize: 16),
            onChanged: (value) {
              if (value.length == 1) {
                if (i + 1 < plaintextFocusNodes.length) {
                  plaintextFocusNodes[i + 1].requestFocus();
                } else {
                  plaintextFocusNodes[i].unfocus();
                }
              }
            },
          ),
        ),
      );
      if ((i + 1) % 2 == 0 && i != totalCount - 1) {
        fields.add(const SizedBox(width: Dimensions.size_4));
      } else {
        fields.add(const SizedBox(width: Dimensions.size_1));
      }
    }
    return Wrap(alignment: WrapAlignment.center, children: fields);
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final cubit = context.read<CryptoCubit>();
      if (cubit.state.activeCipher == CipherType.playfair) {
        final answer = _finalEncryptedController.text.toUpperCase();
        cubit.verifyInput(answer);
        _finalEncryptedController.clear();
        for (var c in plaintextControllers) {
          c.clear();
        }
      } else {
        cubit.verifyInput(_userInputController.text);
        _userInputController.clear();
      }
    }
  }

  void _skip() {
    context.read<CryptoCubit>().skipCipher();
    _userInputController.clear();
    _finalEncryptedController.clear();
    for (var c in plaintextControllers) {
      c.clear();
    }
  }
}
