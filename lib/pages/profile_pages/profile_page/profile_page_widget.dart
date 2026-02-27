import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '/components/logout/logout_widget.dart';
import '/components/side_menu/side_menu_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import '/features/storefront/domain/entities/store_entity.dart';
import '/features/storefront/presentation/providers/storefront_providers.dart';
import '/features/auth/domain/entities/profile.dart';
import '/features/auth/presentation/providers/auth_providers.dart';


/// Profile Page for merchants to view their information
/// and navigate to pages where they can change settings.
class ProfilePageWidget extends ConsumerStatefulWidget {
  const ProfilePageWidget({super.key});

  static String routeName = 'Profile_Page';
  static String routePath = '/profilePage';

  @override
  ConsumerState<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends ConsumerState<ProfilePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    // On page load action - check onboarding status
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().onboardingcomplete == true) {
        context.pushNamed(HomeMainWidget.routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Finish setup tasks first',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'General Sans',
                    color: FlutterFlowTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                  ),
            ),
            duration: const Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use clean architecture provider
    final storeAsync = ref.watch(myStoreProvider);
    final profileAsync = ref.watch(currentProfileProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: Drawer(
          elevation: 16.0,
          child: SideMenuWidget(),
        ),
        body: SafeArea(
          top: true,
          child: storeAsync.when(
            data: (store) {
              if (store == null) return _buildError(context, 'Store not found');
              return profileAsync.when(
                data: (profile) {
                  if (profile == null) return _buildError(context, 'Profile not found');
                  return _buildContent(context, store, profile);
                },
                loading: () => _buildLoading(context),
                error: (error, stack) => _buildError(context, error),
              );
            },
            loading: () => _buildLoading(context),
            error: (error, stack) => _buildError(context, error),
          ),
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50.0,
        height: 50.0,
        child: SpinKitWanderingCubes(
          color: FlutterFlowTheme.of(context).primary,
          size: 50.0,
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: FlutterFlowTheme.of(context).error,
            size: 60.0,
          ),
          const SizedBox(height: 16.0),
          Text(
            'Failed to load profile',
            style: FlutterFlowTheme.of(context).headlineSmall,
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              error.toString(),
              style: FlutterFlowTheme.of(context).bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    StoreEntity store,
    Profile profile,
  ) {
    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildProfileSection(context, store, profile),
                const SizedBox(height: 20.0),
                _buildSettingsList(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          const Divider(height: 1.0, thickness: 1.0, color: Color(0xFFEAEDED)),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 16.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => scaffoldKey.currentState!.openDrawer(),
                    child: Row(
                      children: [
                        Icon(
                          Icons.menu,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        Text(
                          'Menu',
                          style: FlutterFlowTheme.of(context).labelLarge.override(
                                fontFamily: 'General Sans',
                                color: const Color(0xFF1C2626),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ].divide(const SizedBox(width: 8.0)),
                    ),
                  ),
                ),
                Text(
                  'My Account',
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'General Sans',
                        letterSpacing: 0.0,
                        lineHeight: 1.33,
                      ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
          const Divider(height: 1.0, thickness: 1.0, color: Color(0xFFEAEDED)),
        ],
      ),
    );
  }

  Widget _buildProfileSection(
    BuildContext context,
    StoreEntity store,
    Profile profile,
  ) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
      child: Column(
        children: [
          _buildProfileAvatar(context, store, profile),
          Column(
            children: [
              Column(
                children: [
                  Text(
                    store.name ?? '',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'General Sans',
                          color: const Color(0xFF1F1B1B),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    profile.email ?? '',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'General Sans',
                          color: const Color(0xFF545454),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ].divide(const SizedBox(height: 2.0)),
              ),
              FFButtonWidget(
                onPressed: () {
                  context.pushNamed(EditProfilePageWidget.routeName);
                },
                text: 'Edit Profile',
                icon: const Icon(Icons.edit_outlined, size: 16.0),
                options: FFButtonOptions(
                  height: 32.0,
                  padding: const EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                  color: const Color(0x19918D8D),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'General Sans',
                        color: const Color(0xFF171719),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        lineHeight: 1.0,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ].divide(const SizedBox(height: 10.0)),
          ),
        ].divide(const SizedBox(height: 10.0)),
      ),
    );
  }

  Widget _buildProfileAvatar(
    BuildContext context,
    StoreEntity store,
    Profile profile,
  ) {
    final hasProfileImage = profile.profileImageUrl != null && 
                           profile.profileImageUrl!.isNotEmpty;

    return SizedBox(
      width: 100.0,
      height: 100.0,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(1000.0),
            child: Image.asset(
              'assets/images/Ellipse_580.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: hasProfileImage
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(1000.0),
                    child: Image.network(
                      profile.profileImageUrl!,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDFAB59),
                      borderRadius: BorderRadius.circular(1000.0),
                    ),
                    child: Center(
                      child: Text(
                        functions.getInitials(store.name),
                        style: FlutterFlowTheme.of(context).headlineLarge.override(
                              fontFamily: 'General Sans',
                              color: FlutterFlowTheme.of(context).info,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsList(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
      child: Column(
        children: [
          _buildSettingsItem(
            context,
            'Edit Profile',
            Icons.edit_outlined,
            () => context.pushNamed(EditProfilePageWidget.routeName),
          ),
          _buildSettingsItem(
            context,
            'Log Out',
            Icons.logout,
            () async {
              await showModalBottomSheet(
                context: context,
                builder: (context) => const LogoutWidget(),
              );
            },
            isDestructive: true,
          ),
        ].divide(const SizedBox(height: 8.0)),
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: isDestructive
                    ? FlutterFlowTheme.of(context).error
                    : FlutterFlowTheme.of(context).secondaryText,
                size: 24.0,
              ),
              Expanded(
                child: Text(
                  title,
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily: 'General Sans',
                        color: isDestructive
                            ? FlutterFlowTheme.of(context).error
                            : null,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 24.0,
              ),
            ].divide(const SizedBox(width: 12.0)),
          ),
        ),
      ),
    );
  }
}
