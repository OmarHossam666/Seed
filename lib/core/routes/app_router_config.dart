import 'package:go_router/go_router.dart';
import 'package:seed/core/routes/app_routes.dart';
import 'package:seed/features/assessment/presentation/screens/test_your_skills_screen.dart';
import 'package:seed/features/authentication/presentation/screens/create_new_password_screen.dart';
import 'package:seed/features/authentication/presentation/screens/forget_your_password_screen.dart';
import 'package:seed/features/authentication/presentation/screens/login_screen.dart';
import 'package:seed/features/authentication/presentation/screens/otp_verification_screen.dart';
import 'package:seed/presentation/essay/screens/essays_screen.dart';
import 'package:seed/presentation/face_id/screens/face_id_screen.dart';
import 'package:seed/presentation/home/screens/home_screen.dart';
import 'package:seed/presentation/jobs/screens/jobs_screen.dart';
import 'package:seed/presentation/learning/screens/learning_screen.dart';
import 'package:seed/presentation/mcq/screens/mcqs_screen.dart';
import 'package:seed/presentation/sign_up/screens/signup_screen.dart';
import 'package:seed/presentation/soft_skills/screens/soft_skills_screen.dart';
import 'package:seed/presentation/splash/screens/splash_screen.dart';
import 'package:seed/presentation/weekly_test/screens/weekly_test_screen.dart';

class AppRouterConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.faceId,
    routes: [
      GoRoute(
        path: AppRoutes.faceId,
        builder: (context, state) => const FaceIdScreen(),
      ),
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgetYourPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.createNewPassword,
        builder: (context, state) => const CreateNewPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.otpVerification,
        builder: (context, state) => const OtpVerificationScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: AppRoutes.test,
        builder: (context, state) => const TestYourSkillsScreen(),
      ),
      GoRoute(
        path: AppRoutes.essay,
        builder: (context, state) => const EssaysScreen(),
      ),
      GoRoute(
        path: AppRoutes.mcq,
        builder: (context, state) => const McqsScreen(),
      ),
      GoRoute(
        path: AppRoutes.softSkills,
        builder: (context, state) => const SoftSkillsScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.jobs,
        builder: (context, state) => const JobsScreen(),
      ),
      GoRoute(
        path: AppRoutes.learning,
        builder: (context, state) => const LearningScreen(),
      ),
      GoRoute(
        path: AppRoutes.weeklyTest,
        builder: (context, state) => const WeeklyTestScreen(),
      ),
    ],
  );
}
