import '/auth/supabase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'side_menu_model.dart';
export 'side_menu_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/storefront/presentation/providers/storefront_providers.dart';

/// Drawer component that holds the menu items, that the merchant can use to
/// navigate to other pages.
class SideMenuWidget extends ConsumerStatefulWidget {
  const SideMenuWidget({super.key});

  @override
  ConsumerState<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends ConsumerState<SideMenuWidget> {
  late SideMenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SideMenuModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storeAsync = ref.watch(myStoreProvider);

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: 100.0,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 0.0, 0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/Hadi_Logo.png',
                              width: 32.0,
                              height: 22.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 60.0,
                                    height: 60.0,
                                    decoration: BoxDecoration(),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(1000.0),
                                          child: Image.asset(
                                            'assets/images/Image_Circle.png',
                                            width: double.infinity,
                                            height: double.infinity,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 100.0,
                                                  decoration: BoxDecoration(),
                                                  child: storeAsync.when(
                                                    data: (store) => Builder(
                                                      builder: (context) {
                                                        if (store?.logoUrl != null && store!.logoUrl!.isNotEmpty) {
                                                          return ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(1000.0),
                                                            child: Image.network(
                                                              store.logoUrl!,
                                                              width: double.infinity,
                                                              height: double.infinity,
                                                              fit: BoxFit.contain,
                                                              errorBuilder: (context, error, stackTrace) => _buildInitials(context, store.name),
                                                            ),
                                                          );
                                                        } else {
                                                          return _buildInitials(context, store?.name ?? 'Store');
                                                        }
                                                      },
                                                    ),
                                                    loading: () => Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                                    error: (_, __) => _buildInitials(context, 'Store'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // The user's business name.
                                            storeAsync.when(
                                              data: (store) => Text(
                                                store?.name ?? 'My Store',
                                                style: FlutterFlowTheme.of(context)
                                                    .titleLarge
                                                    .override(
                                                      fontFamily: 'General Sans',
                                                      color: Color(0xFF1F1B1B),
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              loading: () => Container(width: 100, height: 20, color: Colors.grey[200]),
                                              error: (_, __) => Text('Store'),
                                            ),

                                            // User's email.
                                            Text(
                                              currentUserEmail.isNotEmpty ? currentUserEmail : 'No Email',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    color: Color(0xFF545454),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ].divide(SizedBox(height: 2.0)),
                                        ),
                                      ].divide(SizedBox(height: 10.0)),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 10.0)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 96.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              // For navigating to the "Home_Main" page
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(HomeMainWidget.routeName);
                                },
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 20.0, 20.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 20.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/Frame.png',
                                                  width: 24.0,
                                                  height: 24.0,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Text(
                                                'Store Front',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'General Sans',
                                                          color:
                                                              Color(0xFF0C1D1F),
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ),
                                            ].divide(SizedBox(width: 8.0)),
                                          ),
                                        ),
                                        Divider(
                                          height: 1.0,
                                          thickness: 1.0,
                                          color: Color(0xFFEAEDED),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // For navigating to the "OrderTransactionHistory" page.
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context
                                      .pushNamed(OrderTransactionHistoryPageWidget.routeName);
                                },
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 20.0, 20.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 20.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/Frame-1.png',
                                                  width: 24.0,
                                                  height: 24.0,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Text(
                                                'Orders',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'General Sans',
                                                          color:
                                                              Color(0xFF0C1D1F),
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ),
                                            ].divide(SizedBox(width: 8.0)),
                                          ),
                                        ),
                                        Divider(
                                          height: 1.0,
                                          thickness: 1.0,
                                          color: Color(0xFFEAEDED),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // For navigating to the "Preorders_Page" page.
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context
                                      .pushNamed(PreordersPageWidget.routeName);
                                },
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 20.0, 20.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 20.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/Frame-2.png',
                                                  width: 24.0,
                                                  height: 24.0,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Text(
                                                'Pre-orders',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'General Sans',
                                                          color:
                                                              Color(0xFF0C1D1F),
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ),
                                            ].divide(SizedBox(width: 8.0)),
                                          ),
                                        ),
                                        Divider(
                                          height: 1.0,
                                          thickness: 1.0,
                                          color: Color(0xFFEAEDED),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // For navigating to the "Deliveryonly_Page" page.
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                      DeliveryonlyPageWidget.routeName);
                                },
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 20.0, 20.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 20.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/package.png',
                                                  width: 24.0,
                                                  height: 24.0,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Text(
                                                'Delivery Only',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'General Sans',
                                                          color:
                                                              Color(0xFF0C1D1F),
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ),
                                            ].divide(SizedBox(width: 8.0)),
                                          ),
                                        ),
                                        Divider(
                                          height: 1.0,
                                          thickness: 1.0,
                                          color: Color(0xFFEAEDED),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // For navigating to the "Profile_Page" page.
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context
                                      .pushNamed(ProfilePageWidget.routeName);
                                },
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 20.0, 20.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 20.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/user-status.png',
                                                  width: 24.0,
                                                  height: 24.0,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Text(
                                                'My Account',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'General Sans',
                                                          color:
                                                              Color(0xFF0C1D1F),
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ),
                                            ].divide(SizedBox(width: 8.0)),
                                          ),
                                        ),
                                        Divider(
                                          height: 1.0,
                                          thickness: 1.0,
                                          color: Color(0xFFEAEDED),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 20.0, 20.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 20.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/help-square.png',
                                                width: 24.0,
                                                height: 24.0,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Text(
                                              'How to & FAQs',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    color: Color(0xFF0C1D1F),
                                                    fontSize: 18.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
                                        ),
                                      ),
                                      Divider(
                                        height: 1.0,
                                        thickness: 1.0,
                                        color: Color(0xFFEAEDED),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Button to contact support.
                              Expanded(
                                child: FFButtonWidget(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text: 'Contact Support',
                                  icon: Icon(
                                    Icons.headset_mic_outlined,
                                    size: 24.0,
                                  ),
                                  options: FFButtonOptions(
                                    height: 62.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconAlignment: IconAlignment.end,
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconColor: Color(0xFF0C1D1F),
                                    color: Color(0xFFEBEBEB),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          fontFamily: 'General Sans',
                                          color: Color(0xFF0C1D1F),
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(42.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ].divide(SizedBox(height: 24.0)),
                    ),
                  ),
                ),
              ),

              // Button to close the drawer.
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 70.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/CLOSE.png',
                            width: 32.0,
                            height: 32.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ].divide(SizedBox(width: 16.0)),
          ),
        ),
      ].divide(SizedBox(height: 2.0)),
    );
  }
  Widget _buildInitials(BuildContext context, String name) {
    final initials = name.isNotEmpty
        ? name.trim().split(' ').map((l) => l[0]).take(2).join().toUpperCase()
        : 'S';
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0xFFDFAB59),
        borderRadius: BorderRadius.circular(1000.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            initials,
            style: FlutterFlowTheme.of(context).headlineLarge.override(
                  fontFamily: 'General Sans',
                  color: FlutterFlowTheme.of(context).info,
                  fontSize: 20.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
