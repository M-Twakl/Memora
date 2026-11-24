import 'package:flutter/material.dart';
import 'core/router/app_router.dart';

void main() {
  runApp(const MemoraApp());
}

class MemoraApp extends StatelessWidget {
  const MemoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Memora',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
