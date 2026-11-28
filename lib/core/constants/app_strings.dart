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

  // Registration Screen (Figma Frames 1:1184 & 1:1650)
  static const String createYourAccount = 'Create your account';
  static const String fullName = 'Full Name';
  static const String enterFullName = 'Please enter your full name';
  static const String invalidFullName = 'Please enter your first and last name';
  static const String passwordMinLengthPlaceholder = 'at least 6 characters';
  static const String continueButton = 'continue';
  static const String haveAnAccount = 'Have an account?';
  static const String logInLink = 'Log In';
  static const String requiredFieldsNotice =
      'Complete the required fields below to continue.';
  static const String enterNationalIdNotice = 'Enter your national ID.';
  static const String confirmPasswordNotice =
      'Confirm your password to continue.';

  // Persona Screen (Figma Frame 1:1278)
  static const String personaTitle = 'How will you use Memora?';
  static const String personaSubtitle = 'Select your role to continue.';
  static const String patientRole = 'Patient';
  static const String doctorRole = 'Doctor';

  // Forgot Password Screen (Figma Frame 1:1085)
  static const String forgotPasswordTitle = 'forgot password';
  static const String forgotPasswordSubtitle =
      'We need your E-mail so we can send you the password reset code.';
  static const String sendCode = 'send code';

  // Create New Password Screen (Figma Frames 1:1006 & 1:1157)
  static const String createPasswordTitle = 'create password';
  static const String createPasswordSubtitle =
      'The password should have at least 6 characters .';
  static const String confirmPassword = 'Confirm Password';
  static const String createNewPassword = 'create new password';
  static const String passwordsDoNotMatch =
      'Passwords don’t match. Re-enter the same password.';
  static const String enterConfirmPassword =
      'Please confirm your password';

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

  // Verify Code Screen (Figma Frames 1:876, 1:1099, 1:1037, 1:1126)
  static const String verifyCodeTitle = 'Verify Code';
  static const String verifyCodeSubtitle =
      'You need to enter 5-digit code we send to your e-mail.';
  static const String verify = 'verify';
  static const String timerInitial = '00:59';
  static const String timerZero = '00:00';
  static const String didntReceiveCode = 'Didn’t receive the code?';
  static const String resend = 'Resend';
  static const String codeDoesNotMatch =
      'The code doesn’t match. Check all five digits and try again.';
  static const String codeExpiresGuidance =
      'Code expires in minutes : seconds';
  static const String codeExpiredMessage =
      'This code has expired. Resend to get a new code.';
  static const String codeExpiredGuidance =
      'Code expired · Request a new code';
  static const String newCodeSentNotice =
      'A new code has been sent to your e-mail.';
  static const String enterNewCodeGuidance =
      'Enter the new five-digit code.';
  static const String resendCooldownGuidance =
      'You can resend when the countdown ends.';

  // Done / Verified Screen (Figma Frame 1:897)
  static const String verifiedTitle = 'Verified !';
  static const String verifiedSubtitle =
      'Your account has been verified. You’re all set to continue.';
  static const String done = 'Done';
}
