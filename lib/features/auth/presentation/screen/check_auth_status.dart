import 'package:club_libertad_front/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckAuthStatus extends ConsumerWidget {
  const CheckAuthStatus({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(authProvider, (previous, next) {});
    return const Scaffold(
      body: Center(
          child: CircularProgressIndicator(
        strokeWidth: 2,
      )),
    );
  }
}
