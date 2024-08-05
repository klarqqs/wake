// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i12;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i14;
import 'package:wake/ui/views/auth_forgot_password/auth_forgot_password_view.dart'
    as _i5;
import 'package:wake/ui/views/auth_login/auth_login_view.dart' as _i7;
import 'package:wake/ui/views/auth_set_password/auth_set_password_view.dart'
    as _i6;
import 'package:wake/ui/views/auth_signup/auth_signup_user_model.dart' as _i13;
import 'package:wake/ui/views/auth_signup/auth_signup_view.dart' as _i8;
import 'package:wake/ui/views/auth_verify_email/auth_verify_email_view.dart'
    as _i9;
import 'package:wake/ui/views/home/home_view.dart' as _i2;
import 'package:wake/ui/views/spending_history/spending_history_view.dart'
    as _i11;
import 'package:wake/ui/views/startup/startup_view.dart' as _i3;
import 'package:wake/ui/views/success/success_view.dart' as _i10;
import 'package:wake/ui/views/walkthrough/walkthrough_view.dart' as _i4;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const walkthroughView = '/walkthrough-view';

  static const authForgotPasswordView = '/auth-forgot-password-view';

  static const authSetPasswordView = '/auth-set-password-view';

  static const authLoginView = '/auth-login-view';

  static const authSignupView = '/auth-signup-view';

  static const authVerifyEmailView = '/auth-verify-email-view';

  static const successView = '/success-view';

  static const spendingHistoryView = '/spending-history-view';

  static const all = <String>{
    homeView,
    startupView,
    walkthroughView,
    authForgotPasswordView,
    authSetPasswordView,
    authLoginView,
    authSignupView,
    authVerifyEmailView,
    successView,
    spendingHistoryView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.walkthroughView,
      page: _i4.WalkthroughView,
    ),
    _i1.RouteDef(
      Routes.authForgotPasswordView,
      page: _i5.AuthForgotPasswordView,
    ),
    _i1.RouteDef(
      Routes.authSetPasswordView,
      page: _i6.AuthSetPasswordView,
    ),
    _i1.RouteDef(
      Routes.authLoginView,
      page: _i7.AuthLoginView,
    ),
    _i1.RouteDef(
      Routes.authSignupView,
      page: _i8.AuthSignupView,
    ),
    _i1.RouteDef(
      Routes.authVerifyEmailView,
      page: _i9.AuthVerifyEmailView,
    ),
    _i1.RouteDef(
      Routes.successView,
      page: _i10.SuccessView,
    ),
    _i1.RouteDef(
      Routes.spendingHistoryView,
      page: _i11.SpendingHistoryView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.WalkthroughView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.WalkthroughView(),
        settings: data,
      );
    },
    _i5.AuthForgotPasswordView: (data) {
      final args = data.getArgs<AuthForgotPasswordViewArguments>(
        orElse: () => const AuthForgotPasswordViewArguments(),
      );
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.AuthForgotPasswordView(key: args.key),
        settings: data,
      );
    },
    _i6.AuthSetPasswordView: (data) {
      final args = data.getArgs<AuthSetPasswordViewArguments>(nullOk: false);
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.AuthSetPasswordView(
            key: args.key,
            isSignUp: args.isSignUp,
            signupUserModel: args.signupUserModel,
            otpCode: args.otpCode),
        settings: data,
      );
    },
    _i7.AuthLoginView: (data) {
      final args = data.getArgs<AuthLoginViewArguments>(
        orElse: () => const AuthLoginViewArguments(),
      );
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.AuthLoginView(key: args.key),
        settings: data,
      );
    },
    _i8.AuthSignupView: (data) {
      final args = data.getArgs<AuthSignupViewArguments>(
        orElse: () => const AuthSignupViewArguments(),
      );
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.AuthSignupView(key: args.key),
        settings: data,
      );
    },
    _i9.AuthVerifyEmailView: (data) {
      final args = data.getArgs<AuthVerifyEmailViewArguments>(nullOk: false);
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.AuthVerifyEmailView(
            key: args.key,
            isSignUp: args.isSignUp,
            signupUserModel: args.signupUserModel),
        settings: data,
      );
    },
    _i10.SuccessView: (data) {
      final args = data.getArgs<SuccessViewArguments>(nullOk: false);
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i10.SuccessView(key: args.key, isSignUp: args.isSignUp),
        settings: data,
      );
    },
    _i11.SpendingHistoryView: (data) {
      final args = data.getArgs<SpendingHistoryViewArguments>(nullOk: false);
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.SpendingHistoryView(
            key: args.key, processedData: args.processedData),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class AuthForgotPasswordViewArguments {
  const AuthForgotPasswordViewArguments({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant AuthForgotPasswordViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class AuthSetPasswordViewArguments {
  const AuthSetPasswordViewArguments({
    this.key,
    required this.isSignUp,
    required this.signupUserModel,
    required this.otpCode,
  });

  final _i12.Key? key;

  final bool isSignUp;

  final _i13.SignupUserModel signupUserModel;

  final String otpCode;

  @override
  String toString() {
    return '{"key": "$key", "isSignUp": "$isSignUp", "signupUserModel": "$signupUserModel", "otpCode": "$otpCode"}';
  }

  @override
  bool operator ==(covariant AuthSetPasswordViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.isSignUp == isSignUp &&
        other.signupUserModel == signupUserModel &&
        other.otpCode == otpCode;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        isSignUp.hashCode ^
        signupUserModel.hashCode ^
        otpCode.hashCode;
  }
}

class AuthLoginViewArguments {
  const AuthLoginViewArguments({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant AuthLoginViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class AuthSignupViewArguments {
  const AuthSignupViewArguments({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant AuthSignupViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class AuthVerifyEmailViewArguments {
  const AuthVerifyEmailViewArguments({
    this.key,
    required this.isSignUp,
    required this.signupUserModel,
  });

  final _i12.Key? key;

  final bool isSignUp;

  final _i13.SignupUserModel signupUserModel;

  @override
  String toString() {
    return '{"key": "$key", "isSignUp": "$isSignUp", "signupUserModel": "$signupUserModel"}';
  }

  @override
  bool operator ==(covariant AuthVerifyEmailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.isSignUp == isSignUp &&
        other.signupUserModel == signupUserModel;
  }

  @override
  int get hashCode {
    return key.hashCode ^ isSignUp.hashCode ^ signupUserModel.hashCode;
  }
}

class SuccessViewArguments {
  const SuccessViewArguments({
    this.key,
    required this.isSignUp,
  });

  final _i12.Key? key;

  final bool isSignUp;

  @override
  String toString() {
    return '{"key": "$key", "isSignUp": "$isSignUp"}';
  }

  @override
  bool operator ==(covariant SuccessViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.isSignUp == isSignUp;
  }

  @override
  int get hashCode {
    return key.hashCode ^ isSignUp.hashCode;
  }
}

class SpendingHistoryViewArguments {
  const SpendingHistoryViewArguments({
    this.key,
    required this.processedData,
  });

  final _i12.Key? key;

  final List<Map<String, dynamic>> processedData;

  @override
  String toString() {
    return '{"key": "$key", "processedData": "$processedData"}';
  }

  @override
  bool operator ==(covariant SpendingHistoryViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.processedData == processedData;
  }

  @override
  int get hashCode {
    return key.hashCode ^ processedData.hashCode;
  }
}

extension NavigatorStateExtension on _i14.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToWalkthroughView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.walkthroughView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAuthForgotPasswordView({
    _i12.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.authForgotPasswordView,
        arguments: AuthForgotPasswordViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAuthSetPasswordView({
    _i12.Key? key,
    required bool isSignUp,
    required _i13.SignupUserModel signupUserModel,
    required String otpCode,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.authSetPasswordView,
        arguments: AuthSetPasswordViewArguments(
            key: key,
            isSignUp: isSignUp,
            signupUserModel: signupUserModel,
            otpCode: otpCode),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAuthLoginView({
    _i12.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.authLoginView,
        arguments: AuthLoginViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAuthSignupView({
    _i12.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.authSignupView,
        arguments: AuthSignupViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAuthVerifyEmailView({
    _i12.Key? key,
    required bool isSignUp,
    required _i13.SignupUserModel signupUserModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.authVerifyEmailView,
        arguments: AuthVerifyEmailViewArguments(
            key: key, isSignUp: isSignUp, signupUserModel: signupUserModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSuccessView({
    _i12.Key? key,
    required bool isSignUp,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.successView,
        arguments: SuccessViewArguments(key: key, isSignUp: isSignUp),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSpendingHistoryView({
    _i12.Key? key,
    required List<Map<String, dynamic>> processedData,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.spendingHistoryView,
        arguments: SpendingHistoryViewArguments(
            key: key, processedData: processedData),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithWalkthroughView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.walkthroughView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAuthForgotPasswordView({
    _i12.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.authForgotPasswordView,
        arguments: AuthForgotPasswordViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAuthSetPasswordView({
    _i12.Key? key,
    required bool isSignUp,
    required _i13.SignupUserModel signupUserModel,
    required String otpCode,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.authSetPasswordView,
        arguments: AuthSetPasswordViewArguments(
            key: key,
            isSignUp: isSignUp,
            signupUserModel: signupUserModel,
            otpCode: otpCode),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAuthLoginView({
    _i12.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.authLoginView,
        arguments: AuthLoginViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAuthSignupView({
    _i12.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.authSignupView,
        arguments: AuthSignupViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAuthVerifyEmailView({
    _i12.Key? key,
    required bool isSignUp,
    required _i13.SignupUserModel signupUserModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.authVerifyEmailView,
        arguments: AuthVerifyEmailViewArguments(
            key: key, isSignUp: isSignUp, signupUserModel: signupUserModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSuccessView({
    _i12.Key? key,
    required bool isSignUp,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.successView,
        arguments: SuccessViewArguments(key: key, isSignUp: isSignUp),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSpendingHistoryView({
    _i12.Key? key,
    required List<Map<String, dynamic>> processedData,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.spendingHistoryView,
        arguments: SpendingHistoryViewArguments(
            key: key, processedData: processedData),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
