import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '/auth/supabase_auth/auth_util.dart';
import '/features/products/domain/entities/product.dart';
import '/features/storefront/domain/entities/store_entity.dart';
import '/features/storefront/presentation/providers/storefront_providers.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import '../../components/side_menu/side_menu_widget.dart';
import '/pages/personal_business_information/add_a_new_product_page/add_a_new_product_page_widget.dart';

/// The main storefront home page for merchants.
///
/// Displays:
/// - Store header image (banner) with upload/change option
/// - Shareable store link with copy button
/// - Product grid / empty state with Add Product CTA
class HomeMainWidget extends ConsumerStatefulWidget {
  const HomeMainWidget({super.key});

  static String routeName = 'Home_Main';
  static String routePath = '/homeMain';

  @override
  ConsumerState<HomeMainWidget> createState() => _HomeMainWidgetState();
}

class _HomeMainWidgetState extends ConsumerState<HomeMainWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final storeAsync = ref.watch(myStoreProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
          ),
          child: Drawer(
            child: SideMenuWidget(),
          ),
        ),
        body: SafeArea(
          top: true,
          child: storeAsync.when(
            data: (store) {
              if (store == null) {
                return _buildError(context, 'Store not found. Please verify your account.');
              }
              final productsAsync = ref.watch(storeProductsProvider(store.id));
              return _buildContent(context, store, productsAsync);
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
            'Failed to load store',
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
          const SizedBox(height: 16.0),
          FFButtonWidget(
            onPressed: () => ref.invalidate(myStoreProvider),
            text: 'Retry',
            options: FFButtonOptions(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              color: FlutterFlowTheme.of(context).primary,
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'General Sans',
                    color: Colors.white,
                  ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    StoreEntity store,
    AsyncValue<List<Product>> productsAsync,
  ) {
    final products = productsAsync.valueOrNull ?? [];
    final hasProducts = products.isNotEmpty;

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Top Nav Bar ──────────────────────────────────────────────
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Divider(
                      height: 1.0,
                      thickness: 1.0,
                      color: Color(0xFFEAEDED),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 16.0, 20.0, 16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          // Menu button
                          Expanded(
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                scaffoldKey.currentState!.openDrawer();
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.menu,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  Text(
                                    'Menu',
                                    style: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
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
                          // Store name + avatar
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                valueOrDefault<String>(
                                  store.name,
                                  'Northing Official',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: 'General Sans',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                              Container(
                                width: 24.0,
                                height: 24.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5CA86),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      functions.getInitials(store.name),
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily: 'General Sans',
                                            fontSize: 10.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ].divide(const SizedBox(width: 8.0)),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1.0,
                      thickness: 1.0,
                      color: Color(0xFFEAEDED),
                    ),
                  ],
                ),
              ),

              // ── "Store Front" label ──────────────────────────────────────
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                child: Text(
                  'Store Front',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily: 'General Sans',
                        color: const Color(0xFF131919),
                        letterSpacing: 0.0,
                      ),
                ),
              ),

              // ── Banner section ───────────────────────────────────────────
              _buildBannerSection(context, store),

              // ── Share Storefront Link ────────────────────────────────────
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    20.0, 0.0, 20.0, 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Share Storefront Link',
                      style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'General Sans',
                                color: const Color(0xFF2A3535),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBFBF9),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 16.0, 10.0, 16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'https://hadi.northing.shop/${store.slug ?? ''}',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'General Sans',
                                      color: const Color(0xFF797979),
                                      fontSize: 13.0,
                                      letterSpacing: 0.0,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                await Clipboard.setData(ClipboardData(
                                    text:
                                        'https://hadi.northing.shop/${store.slug ?? ''}'));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Copied',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    duration:
                                        const Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                  ),
                                );
                              },
                              text: 'Copy ',
                              options: FFButtonOptions(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0, 5.0, 10.0, 5.0),
                                iconPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                color: const Color(0xFFF4F0E7),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'General Sans',
                                      color: const Color(0xFF2A3535),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      lineHeight: 1.0,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ].divide(const SizedBox(height: 8.0)),
                ),
              ),

              // ── Products section ─────────────────────────────────────────
              _buildProductsSection(context, store, productsAsync),

            ].divide(const SizedBox(height: 16.0)),
          ),
        ),

        // ── Floating Add Product button (shown only when storefront complete + has products) ──
        if ((store.storefrontSetupComplete == true) && hasProducts)
          Align(
            alignment: const AlignmentDirectional(1.0, 1.0),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 24.0),
              child: FFButtonWidget(
                onPressed: () {
                  context.pushNamed(
                    AddANewProductPageWidget.routeName,
                    queryParameters: {
                      'storeId': serializeParam(
                        store.id,
                        ParamType.String,
                      ),
                    }.withoutNulls,
                  );
                },
                text: 'Add Product',
                icon: const Icon(
                  Icons.data_saver_on,
                  size: 16.0,
                ),
                options: FFButtonOptions(
                  height: 72.0,
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      32.0, 24.0, 32.0, 24.0),
                  iconPadding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle:
                      FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'General Sans',
                            color: Colors.white,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(40.0),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBannerSection(BuildContext context, StoreEntity store) {
    final hasBanner =
        store.bannerUrl != null && store.bannerUrl!.isNotEmpty;

    if (hasBanner) {
      return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
        child: Container(
          width: double.infinity,
          height: 95.0,
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F8),
            border: Border.all(
              color: const Color(0xFFE3E3E3),
              width: 0.5,
            ),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(0.0),
                child: Image.network(
                  store.bannerUrl!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(1.0, 1.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      0.0, 0.0, 8.0, 8.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      // Banner upload — handled by the media picker
                      // TODO: wire to ImagePicker + Supabase storage upload
                    },
                    text: 'Change Header',
                    options: FFButtonOptions(
                      height: 32.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 0.0, 16.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      color: Colors.white,
                      textStyle:
                          FlutterFlowTheme.of(context).labelSmall.override(
                                fontFamily: 'General Sans',
                                color: const Color(0xFF171719),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Empty banner state
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
      child: GestureDetector(
        onTap: () async {
          // TODO: wire to ImagePicker + Supabase storage upload
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F8),
            border: Border.all(
              color: const Color(0xFFE3E3E3),
              width: 0.5,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsetsDirectional.fromSTEB(0.0, 26.0, 0.0, 26.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 25.0,
                  height: 25.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(0.0),
                        child: Image.asset(
                          'assets/images/upload_1.png',
                          width: 24.6,
                          height: 24.6,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tap here ',
                      style:
                          FlutterFlowTheme.of(context).bodySmall.override(
                                fontFamily: 'General Sans',
                                color: const Color(0xFFA55954),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                    Text(
                      'to upload header image',
                      style:
                          FlutterFlowTheme.of(context).bodySmall.override(
                                fontFamily: 'General Sans',
                                color: const Color(0xFF384A62),
                                letterSpacing: 0.0,
                              ),
                    ),
                  ],
                ),
              ].divide(const SizedBox(height: 2.0)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductsSection(
    BuildContext context,
    StoreEntity store,
    AsyncValue<List<Product>> productsAsync,
  ) {
    return productsAsync.when(
      loading: () => Center(
        child: SizedBox(
          width: 50.0,
          height: 50.0,
          child: SpinKitWanderingCubes(
            color: FlutterFlowTheme.of(context).primary,
            size: 50.0,
          ),
        ),
      ),
      error: (error, _) => Center(
        child: Text(
          'Failed to load products: $error',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'General Sans',
                color: FlutterFlowTheme.of(context).error,
                letterSpacing: 0.0,
              ),
        ),
      ),
      data: (products) {
        final storefrontReady = store.storefrontSetupComplete == true;

        if (storefrontReady && products.isNotEmpty) {
          // ── 2-column product grid ────────────────────────────────────
          return Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                20.0, 0.0, 20.0, 120.0),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 24.0,
                mainAxisSpacing: 24.0,
                childAspectRatio: 0.72,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    context.pushNamed(
                      ProductDetailsPageWidget.routeName,
                      queryParameters: {
                        'productId': serializeParam(
                          product.id,
                          ParamType.String,
                        ),
                      }.withoutNulls,
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 181.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              'https://picsum.photos/seed/${product.id}/600',
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'General Sans',
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    lineHeight: 0.88,
                                  ),
                            ),
                            Text(
                              product.price.toString(),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'General Sans',
                                    color: const Color(0xFF645E82),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ].divide(const SizedBox(height: 8.0)),
                        ),
                      ].divide(const SizedBox(height: 5.0)),
                    ),
                  ),
                );
              },
            ),
          );
        }

        // ── Empty state with arrow + big Add Product button ──────────
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 56.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 134.1,
                        height: 81.8,
                        decoration: const BoxDecoration(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/Group_599.png',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Text(
                        'You have not added any products to\nyour store front yet. ',
                        textAlign: TextAlign.center,
                        style:
                            FlutterFlowTheme.of(context).bodyLarge.override(
                                  fontFamily: 'General Sans',
                                  color: const Color(0xFF424A4A),
                                  letterSpacing: 0.0,
                                ),
                      ),
                    ].divide(const SizedBox(height: 20.0)),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 13.0,
                      height: 68.0,
                      decoration: const BoxDecoration(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/Arrow.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () {
                        context.pushNamed(
                          AddANewProductPageWidget.routeName,
                          queryParameters: {
                            'storeId': serializeParam(
                              store.id,
                              ParamType.String,
                            ),
                          }.withoutNulls,
                        );
                      },
                      text: 'Add Product',
                      icon: const Icon(
                        Icons.data_saver_on,
                        size: 16.0,
                      ),
                      options: FFButtonOptions(
                        height: 72.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            32.0, 24.0, 32.0, 24.0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily: 'General Sans',
                              color: Colors.white,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                  ].divide(const SizedBox(height: 12.0)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
