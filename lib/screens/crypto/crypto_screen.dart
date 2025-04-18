import 'package:disertatie/screens/crypto/widgets/crypto_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/widgets/back_button_widget.dart';
import '../../utils/dimensions.dart';
import 'cubit/crypto_cubit.dart';

class CryptoScreen extends StatelessWidget {
  const CryptoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CryptoCubit(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: const CustomBackButton(),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(Dimensions.size_6),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.size_4),
              ),
              elevation: Dimensions.size_2,
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.size_4),
                child: const CryptoForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
