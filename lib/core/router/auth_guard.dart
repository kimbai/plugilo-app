import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugilo/core/common/cubit/auth_cubit.dart';
import 'package:plugilo/core/common/cubit/auth_state.dart';
import 'package:plugilo/core/router/guard.dart';

class AuthGuard extends StatelessWidget {
  final String fallbackRoute;
  final Widget child;

  const AuthGuard({
    super.key,
    required this.fallbackRoute,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Guard(
        canActivate: Future.value(state.isAuth),
        fallbackRoute: fallbackRoute,
        child: child,
      );
    });
  }
}
