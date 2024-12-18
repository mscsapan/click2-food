import 'package:click_food/data/models/auth/auth_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc/auth/auth_bloc.dart';
import '../../routes/route_names.dart';
import '../../widgets/error_text.dart';
import '../../widgets/loading_widget.dart';
import '/presentation/routes/route_packages_name.dart';
import '/presentation/widgets/custom_form.dart';
import '/presentation/widgets/primary_button.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = context.read<AuthBloc>();
    // debugPrint('current-state ${authBloc.state.authState}');
    if (authBloc.state.email.isNotEmpty) {
      debugPrint('not-empty-email ${authBloc.state.email}');
      authBloc.add(const AuthEventUserEmail(''));
    }

    // debugPrint('current-state ${authBloc.state.authState}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        padding: Utils.symmetric(),
        shrinkWrap: true,
        children: [
          const CustomText(
              text: 'Personal information',
              fontSize: 24.0,
              color: Color(0xFF2D3034),
              fontWeight: FontWeight.w700),
          Utils.verticalSpace(6.0),
          const CustomText(
              text: 'Please provide us your information to continue',
              fontWeight: FontWeight.w500,
              color: grayColor3),
          Utils.verticalSpace(24.0),
          BlocBuilder<AuthBloc, AuthStateModel>(
            builder: (context, state) {
              return CustomForm(
                label: '',
                bottomSpace: 0.0,
                topSpace: 0.0,
                child: TextFormField(
                    initialValue: state.name,
                    onChanged: (String text) =>
                        authBloc.add(AuthEventUserName(text)),
                    decoration: InputDecoration(
                      hintText: 'Type your full name',
                      prefixIcon: Padding(
                        padding: Utils.only(top: 2.0),
                        child: const Icon(
                          Icons.person,
                          color: grayColor3,
                          size: 24.0,
                        ),
                      ),
                    ),
                    style: inputStyle),
              );
            },
          ),
          BlocBuilder<AuthBloc, AuthStateModel>(
            builder: (context, auth) {
              final state = auth.authState;
              return CustomForm(
                label: '',
                bottomSpace: 0.0,
                topSpace: 0.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                        controller: authBloc.emailController,
                        // initialValue: auth.email,
                        onChanged: (String text) => authBloc
                          ..add(AuthEventUserEmail(text))
                          ..add(const AuthEmailValidate()),
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          prefixIcon: Padding(
                            padding: Utils.only(top: 2.0),
                            child: const Icon(
                              Icons.email_outlined,
                              color: grayColor3,
                              size: 24.0,
                            ),
                          ),
                        ),
                        style: inputStyle),
                    if (state is AuthInvalidEmail) ...[
                      ErrorText(text: state.message),
                    ]
                  ],
                ),
              );
            },
          ),
          BlocBuilder<AuthBloc, AuthStateModel>(
            builder: (context, auth) {
              final state = auth.authState;
              return CustomForm(
                label: '',
                bottomSpace: 16.0,
                topSpace: 0.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                        initialValue: auth.password,
                        onChanged: (String text) => authBloc
                          ..add(AuthEventPassword(text))
                          ..add(const AuthPasswordValidate()),
                        decoration: InputDecoration(
                          hintText: 'Type your password',
                          prefixIcon: Padding(
                            padding: Utils.only(top: 2.0),
                            child: const Icon(
                              Icons.lock_outline,
                              color: grayColor3,
                              size: 24.0,
                            ),
                          ),
                          suffixIcon: Padding(
                            padding: Utils.only(top: 2.0),
                            child: IconButton(
                              onPressed: () =>
                                  authBloc.add(const AuthShowPassword()),
                              icon: Icon(
                                auth.isActive
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_outlined,
                                color: grayColor3,
                                size: 22.0,
                              ),
                            ),
                          ),
                        ),
                        obscureText: auth.isActive,
                        style: inputStyle),
                    if (state is AuthInvalidPassword) ...[
                      ErrorText(text: state.message),
                    ]
                  ],
                ),
              );
            },
          ),
          BlocBuilder<AuthBloc, AuthStateModel>(
            builder: (context, auth) {
              final state = auth.authState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                      initialValue: auth.password,
                      onChanged: (String text) => authBloc
                        ..add(AuthEventConPassword(text))
                        ..add(const AuthConPasswordValidate()),
                      decoration: InputDecoration(
                        hintText: 'Confirm password',
                        prefixIcon: Padding(
                          padding: Utils.only(top: 2.0),
                          child: const Icon(
                            Icons.lock_outline,
                            color: grayColor3,
                            size: 24.0,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: Utils.only(top: 2.0),
                          child: IconButton(
                            onPressed: () =>
                                authBloc.add(const AuthShowConPassword()),
                            icon: Icon(
                              auth.showCon
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_outlined,
                              color: grayColor3,
                              size: 22.0,
                            ),
                          ),
                        ),
                      ),
                      obscureText: auth.showCon,
                      style: inputStyle),
                  if (state is AuthInvalidConPassword) ...[
                    ErrorText(text: state.message),
                  ]
                ],
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: _submitButton(context),
    );
  }

  Widget _submitButton(BuildContext context) {
    // final sCubit = context.read<AddAdditionalCubit>();
    return BlocConsumer<AuthBloc, AuthStateModel>(
      listener: (context, states) {
        final state = states.authState;
        if(state is AuthStateError){
          authBloc.add(const AuthEventReset());
          Utils.errorSnackBar(context, state.message);
        }else if(state is AuthStateUserAdded){
          authBloc.add(const AuthEventReset());
          Utils.showSnackBar(context, state.responses);
          Navigator.pushNamedAndRemoveUntil(context,RouteNames.homeScreen,(route)=>false);
        }
      },
      builder: (context, states) {
        final state = states.authState;
        final isValid = states.name.trim().isNotEmpty && states.email.trim().isNotEmpty && Utils.isValidEmail(states.email)  && states.password.trim().isNotEmpty && Utils.isValidPassword(states.password) && states.conPassword.contains(states.password);
        return state is AuthStateLoading? _loading():  Container(
          padding: Utils.only(
            left: 20.0,
            right: 20.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          margin: Utils.symmetric(h: 0.0, v: 20.0).copyWith(bottom: 24.0),
          child: PrimaryButton(
              text: 'Continue',
              onPressed: () {
                Utils.closeKeyBoard(context);
                if(isValid){
                  authBloc.add(const AuthEventAddUser());
                }else{
                  debugPrint('condition-false');
                      }
                // Navigator.pushNamed(context, RouteNames.updatePasswordScreen,
                //     arguments: false)
              },
              buttonType: ButtonType.icon),
        );
      },
    );
  }

  Widget _loading() {
    return Padding(
      padding: Utils.only(bottom: 20.0),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [LoadingWidget()],
      ),
    );
  }
}
