/// Centralized application strings.
abstract class AppStrings {
  static const String appName = 'Memora';
  static const String appTagline = 'One portable, patient-owned medical record';

  // Splash
  static const String splashTitle = 'Memora';

  // Onboarding
  static const String onboardingTitle1 = 'Every Patient, One Complete Record';
  static const String onboardingSubtitle1 =
      'Medical history, visits and vaccine status together in one profile, ready in seconds.';

  static const String onboardingTitle2 = 'Never Miss A Vaccine Again';
  static const String onboardingSubtitle2 =
      'Smart schedules and timely reminders keep every dose on track, for every patient.';

  static const String onboardingTitle3 = 'Your Privacy Comes First';
  static const String onboardingSubtitle3 =
      'Patient data is encrypted and visible only to authorized staff.';

  static const String skip = 'skip';
  static const String next = 'Next';
  static const String getStarted = 'Get Started';

  // Auth Gateway & Welcome ("have an account")
  static const String authTagline = 'Your health story, always with you.';
  static const String logIn = 'log in';
  static const String register = 'register';

  // Login Screen
  static const String welcomeBack = 'Welcome back';
  static const String signInSubtitle = 'Sign in to see your health timeline.';
  static const String nationalId = 'National Id';
  static const String nationalIdHint = ' National Id';
  static const String emailOrMobile = 'Email or Mobile Number';
  static const String emailPlaceholder = 'name@example.com';
  static const String password = 'Password';
  static const String passwordPlaceholder = 'password';
  static const String forgotPassword = 'forgot password?';
  static const String orDivider = 'or';
  static const String continueWithApple = 'continue with Apple';
  static const String continueWithFacebook = 'continue with Facebook';
  static const String continueWithGoogle = 'continue with Google';
  static const String dontHaveAccount = 'Don’t have an account?';
  static const String registerLink = 'Register';

  // Validation Messages
  static const String enterNationalId = 'Please enter your National ID';
  static const String invalidNationalId =
      'National ID must be exactly 14 digits';
  static const String enterEmailOrPhone =
      'Please enter your email or mobile number';
  static const String invalidEmailOrPhone =
      'Please enter a valid Gmail address or Egyptian phone number';
  static const String invalidPhoneLength =
      'Phone number must be exactly 11 digits';
  static const String invalidPhonePrefix =
      'Phone number must start with 010, 011, 012, or 015';
  static const String invalidGmailDomain =
      'Email address must end with @gmail.com';
  static const String invalidGmail = 'Please enter a valid Gmail address';
  static const String enterPassword = 'Please enter your password';
  static const String passwordLength =
      'Password must be between 6 and 10 characters';
  static const String passwordUppercase =
      'Password must include at least one uppercase letter';
  static const String passwordLowercase =
      'Password must include at least one lowercase letter';
  static const String passwordNumber =
      'Password must include at least one number';
  static const String passwordSpecialChar =
      'Password must include at least one special character';

  // Auth States & Notices (Figma Frames 1:908 & 1:954)
  static const String invalidCredentialsNotice =
      'We couldn’t sign you in. Check your details and try again.';
  static const String signingInGuidance = 'Signing you in. Please wait…';
  static const String tryAgain = 'Try Again';
  static const String logInSubmitting = 'log in...';

  // Verify Code Screen (Figma Frame 1:876)
  static const String verifyCodeTitle = 'Verify Code';
  static const String verifyCodeSubtitle =
      'You need to enter 5-digit code we send to your e-mail.';
  static const String verify = 'verify';
  static const String timerInitial = '00:59';
  static const String didntReceiveCode = 'Didn’t receive the code?';
  static const String resend = 'Resend';

  // Done / Verified Screen (Figma Frame 1:897)
  static const String verifiedTitle = 'Verified !';
  static const String verifiedSubtitle =
      'Your account has been verified. You’re all set to continue.';
  static const String done = 'Done';
}
