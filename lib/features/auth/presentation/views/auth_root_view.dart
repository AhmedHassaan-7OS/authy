import 'package:authy/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:authy/features/auth/presentation/cubit/auth_state.dart';
import 'package:authy/features/auth/presentation/views/auth_entry_view.dart';
import 'package:authy/features/auth/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authy/core/widgets/app_snackbar.dart';

class AuthRootView extends StatelessWidget {
  const AuthRootView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.failure && state.errorMessage != null) {
          AppSnackBar.showError(context, state.errorMessage!);
        }
      },
      builder: (context, state) {
        if (state.status == AuthStatus.loading || state.status == AuthStatus.initial) {
          return const AuthEntryLoadingView();
        }
        if (state.status == AuthStatus.authenticated && state.user != null) {
          return HomeView(user: state.user!);
        }
        return const AuthEntryView();
      },
    );
  }
}
