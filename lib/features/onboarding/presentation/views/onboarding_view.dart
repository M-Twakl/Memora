import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memora/core/router/app_routes.dart';
import 'package:memora/core/theme/app_colors.dart';
import 'package:memora/features/onboarding/data/models/onboarding_item_model.dart';
import 'package:memora/shared/widgets/adaptive_layout.dart';
import 'widgets/onboarding_bottom_section.dart';
import 'widgets/onboarding_page_content.dart';
import 'widgets/onboarding_top_bar.dart';

/// Full-screen Onboarding View managing 3-step carousel navigation.
/// Illustrations span edge-to-edge without padding with precise wave and icon geometry.
class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late final PageController _pageController;
  int _currentPage = 0;

  List<OnboardingItemModel> get _items => OnboardingItemModel.items;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _onBackPressed() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _onNextPressed() {
    if (_currentPage < _items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _onSkipPressed() {
    _completeOnboarding();
  }

  void _completeOnboarding() {
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _items.length - 1;
    final canGoBack = _currentPage > 0;
    final showSkip = !isLastPage;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: AdaptiveMaxWidthContainer(
          maxWidth: 480,
          child: Column(
            children: [
              // Top Bar with Back and Skip actions
              OnboardingTopBar(
                canGoBack: canGoBack,
                showSkip: showSkip,
                onBackPressed: _onBackPressed,
                onSkipPressed: _onSkipPressed,
              ),

              // Edge-to-edge Page Content Carousel with layered SVGs and exact waves
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return OnboardingPageContent(
                      item: _items[index],
                      currentIndex: _currentPage,
                      totalCount: _items.length,
                    );
                  },
                ),
              ),

              // Bottom Button Section (Next / Get Started)
              OnboardingBottomSection(
                isLastPage: isLastPage,
                onButtonPressed: _onNextPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
