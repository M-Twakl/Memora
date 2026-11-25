import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memora/core/router/app_routes.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'package:memora/shared/widgets/adaptive_layout.dart';
import 'widgets/welcome_actions_section.dart';
import 'widgets/welcome_brand_header.dart';

/// Full-screen Welcome Gateway View ("have an account" in Figma).
/// Presents the central brand identity and entry points to either login or register.
class AuthGatewayView extends StatelessWidget {
  const AuthGatewayView({super.key});

  void _onLoginPressed(BuildContext context) {
    context.push(AppRoutes.login);
  }

  void _onRegisterPressed(BuildContext context) {
    context.push(AppRoutes.register);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: AdaptiveMaxWidthContainer(
          maxWidth: 480,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Spacer(flex: 3),

                          // Centered Logo & Tagline (Figma Frame 11)
                          const WelcomeBrandHeader(),

                          const Spacer(flex: 4),

                          // Bottom Action Buttons: log in & register (Figma Frame 12)
                          WelcomeActionsSection(
                            onLoginPressed: () => _onLoginPressed(context),
                            onRegisterPressed: () => _onRegisterPressed(context),
                          ),

                          const SizedBox(height: 28),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
