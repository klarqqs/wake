import 'package:wake/services/base_api_service.dart';
import 'package:wake/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:wake/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:wake/ui/views/home/home_view.dart';
import 'package:wake/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:wake/ui/views/walkthrough/walkthrough_view.dart';
import 'package:wake/ui/views/auth_forgot_password/auth_forgot_password_view.dart';
import 'package:wake/ui/views/auth_set_password/auth_set_password_view.dart';
import 'package:wake/ui/views/auth_login/auth_login_view.dart';
import 'package:wake/ui/views/auth_signup/auth_signup_view.dart';
import 'package:wake/ui/views/auth_verify_email/auth_verify_email_view.dart';
import 'package:wake/ui/views/success/success_view.dart';
import 'package:wake/ui/views/spending_history/spending_history_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),

    MaterialRoute(page: WalkthroughView),
    MaterialRoute(page: AuthForgotPasswordView),
    MaterialRoute(page: AuthSetPasswordView),
    MaterialRoute(page: AuthLoginView),
    MaterialRoute(page: AuthSignupView),
    MaterialRoute(page: AuthVerifyEmailView),
    MaterialRoute(page: SuccessView),
    MaterialRoute(page: SpendingHistoryView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: BaseApiService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
