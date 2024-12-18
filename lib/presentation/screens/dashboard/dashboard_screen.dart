import 'package:click_food/presentation/routes/route_packages_name.dart';
import 'package:click_food/presentation/widgets/custom_app_bar.dart';
import 'package:click_food/presentation/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc/auth/auth_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
    return  Scaffold(
      appBar: AppBar(),
      // appBar: const CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(text: authBloc.responses?.userName??'',fontSize: 16.0,fontWeight: FontWeight.w600,color: blackColor,)
          ],
        ),
      ),
    );
  }
}
