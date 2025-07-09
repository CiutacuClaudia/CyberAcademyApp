import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/widgets/back_button_widget.dart';
import '../../utils/dimensions.dart';
import 'cubit/xss_cubit.dart';
import 'widgets/xss_form.dart';

class XssScreen extends StatelessWidget {
  const XssScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => XssCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(Dimensions.size_1),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.size_4),
              ),
              elevation: Dimensions.size_2,
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.size_4),
                child: const XssForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
