import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/backend/schema/structs/index.dart';

import '/backend/supabase/supabase.dart';

import '/auth/base_auth_user_provider.dart';

import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/createAccountEmailPassword',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) => appStateNotifier.loggedIn
          ? HomeIncompleteInfoWidget()
          : LogInPageEmailWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.loggedIn
              ? HomeIncompleteInfoWidget()
              : LogInPageEmailWidget(),
        ),
        FFRoute(
          name: HomeIncompleteInfoWidget.routeName,
          path: HomeIncompleteInfoWidget.routePath,
          builder: (context, params) => HomeIncompleteInfoWidget(),
        ),
        FFRoute(
          name: LogInPageEmailWidget.routeName,
          path: LogInPageEmailWidget.routePath,
          builder: (context, params) => LogInPageEmailWidget(),
        ),
        FFRoute(
          name: LogInPagePhoneWidget.routeName,
          path: LogInPagePhoneWidget.routePath,
          builder: (context, params) => LogInPagePhoneWidget(),
        ),
        FFRoute(
          name: CreateAccountPhoneWidget.routeName,
          path: CreateAccountPhoneWidget.routePath,
          builder: (context, params) => CreateAccountPhoneWidget(),
        ),
        FFRoute(
          name: VerifyChannelWidget.routeName,
          path: VerifyChannelWidget.routePath,
          builder: (context, params) => VerifyChannelWidget(),
        ),
        FFRoute(
          name: VerificationCodeWidget.routeName,
          path: VerificationCodeWidget.routePath,
          builder: (context, params) => VerificationCodeWidget(),
        ),
        FFRoute(
          name: VerifiedWidget.routeName,
          path: VerifiedWidget.routePath,
          builder: (context, params) => VerifiedWidget(),
        ),
        FFRoute(
          name: CreateAccountEmailPasswordWidget.routeName,
          path: CreateAccountEmailPasswordWidget.routePath,
          builder: (context, params) => CreateAccountEmailPasswordWidget(),
        ),
        FFRoute(
          name: UpdateBusinessInfoPageWidget.routeName,
          path: UpdateBusinessInfoPageWidget.routePath,
          builder: (context, params) => UpdateBusinessInfoPageWidget(),
        ),
        FFRoute(
          name: AddBankAccountPageWidget.routeName,
          path: AddBankAccountPageWidget.routePath,
          builder: (context, params) => AddBankAccountPageWidget(),
        ),
        FFRoute(
          name: AddPickupAddressPageWidget.routeName,
          path: AddPickupAddressPageWidget.routePath,
          builder: (context, params) => AddPickupAddressPageWidget(
            returnToOnboarding: params.getParam('returnToOnboarding', ParamType.bool) ?? false,
          ),
        ),
        FFRoute(
          name: AddANewProductPageWidget.routeName,
          path: AddANewProductPageWidget.routePath,
          builder: (context, params) => AddANewProductPageWidget(
            storeId: params.getParam(
              'storeId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: UploadProductMediaPageWidget.routeName,
          path: UploadProductMediaPageWidget.routePath,
          builder: (context, params) => UploadProductMediaPageWidget(
            productId: params.getParam(
              'productId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: HomeMainWidget.routeName,
          path: HomeMainWidget.routePath,
          builder: (context, params) => HomeMainWidget(),
        ),
        FFRoute(
          name: ProductDetailsPageWidget.routeName,
          path: ProductDetailsPageWidget.routePath,
          builder: (context, params) => ProductDetailsPageWidget(
            productId: params.getParam(
              'productId',
              ParamType.String,
            ),
            storeSlug: params.getParam<StoresRow>(
              'storeSlug',
              ParamType.SupabaseRow,
            ),
          ),
        ),
        FFRoute(
          name: ProfilePageWidget.routeName,
          path: ProfilePageWidget.routePath,
          builder: (context, params) => ProfilePageWidget(),
        ),
        FFRoute(
          name: EditProfilePageWidget.routeName,
          path: EditProfilePageWidget.routePath,
          builder: (context, params) => EditProfilePageWidget(),
        ),
        FFRoute(
          name: OrderTransactionHistoryPageWidget.routeName,
          path: OrderTransactionHistoryPageWidget.routePath,
          builder: (context, params) => OrderTransactionHistoryPageWidget(),
        ),
        FFRoute(
          name: ChangePasswordPageWidget.routeName,
          path: ChangePasswordPageWidget.routePath,
          builder: (context, params) => ChangePasswordPageWidget(),
        ),
        FFRoute(
          name: PreordersPageWidget.routeName,
          path: PreordersPageWidget.routePath,
          builder: (context, params) => PreordersPageWidget(),
        ),
        FFRoute(
          name: PreordersProductDetailsPageWidget.routeName,
          path: PreordersProductDetailsPageWidget.routePath,
          builder: (context, params) => PreordersProductDetailsPageWidget(),
        ),
        FFRoute(
          name: DeliveryonlyPageWidget.routeName,
          path: DeliveryonlyPageWidget.routePath,
          builder: (context, params) => DeliveryonlyPageWidget(),
        ),
        FFRoute(
          name: DeliveryDetailsPageWidget.routeName,
          path: DeliveryDetailsPageWidget.routePath,
          builder: (context, params) => DeliveryDetailsPageWidget(),
        ),
        FFRoute(
          name: CreateDeliveryTicketPageWidget.routeName,
          path: CreateDeliveryTicketPageWidget.routePath,
          builder: (context, params) => CreateDeliveryTicketPageWidget(),
        ),
        FFRoute(
          name: Checkout1PageWidget.routeName,
          path: Checkout1PageWidget.routePath,
          builder: (context, params) => Checkout1PageWidget(),
        ),
        FFRoute(
          name: Checkout2PageWidget.routeName,
          path: Checkout2PageWidget.routePath,
          builder: (context, params) => Checkout2PageWidget(),
        ),
        FFRoute(
          name: PaymentSuccessfulPageWidget.routeName,
          path: PaymentSuccessfulPageWidget.routePath,
          builder: (context, params) => PaymentSuccessfulPageWidget(),
        ),
        FFRoute(
          name: ShipmentNotCreatedPageWidget.routeName,
          path: ShipmentNotCreatedPageWidget.routePath,
          builder: (context, params) => ShipmentNotCreatedPageWidget(),
        ),
        FFRoute(
          name: PaymentCancelledPageWidget.routeName,
          path: PaymentCancelledPageWidget.routePath,
          builder: (context, params) => PaymentCancelledPageWidget(),
        ),
        FFRoute(
          name: ForgotPasswordPageWidget.routeName,
          path: ForgotPasswordPageWidget.routePath,
          builder: (context, params) => ForgotPasswordPageWidget(),
        ),
        FFRoute(
          name: RestLinkSentPageWidget.routeName,
          path: RestLinkSentPageWidget.routePath,
          builder: (context, params) => RestLinkSentPageWidget(),
        ),
        FFRoute(
          name: PasswordRestPageWidget.routeName,
          path: PasswordRestPageWidget.routePath,
          builder: (context, params) => PasswordRestPageWidget(),
        ),
        FFRoute(
          name: RestSuccessfulPageWidget.routeName,
          path: RestSuccessfulPageWidget.routePath,
          builder: (context, params) => RestSuccessfulPageWidget(),
        ),
        FFRoute(
          name: StorefrontPage.routeName,
          path: StorefrontPage.routePath,
          builder: (context, params) => StorefrontPage(
            storeSlug: params.getParam(
              'slug',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: StoreProductDetailsPage.routeName,
          path: StoreProductDetailsPage.routePath,
          builder: (context, params) => StoreProductDetailsPage(
            storeSlug: params.getParam(
              'slug',
              ParamType.String,
            ),
            productId: params.getParam(
              'productId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: CartPage.routeName,
          path: CartPage.routePath,
          builder: (context, params) => CartPage(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      observers: [routeObserver],
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/logInPageEmail';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Color(0x1499725D),
                  child: Center(
                    child: Image.asset(
                      'assets/images/Hadi_Logo.png',
                      width: 96.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
