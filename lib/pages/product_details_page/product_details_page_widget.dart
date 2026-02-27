import 'dart:math' show max, min;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/backend/supabase/supabase.dart';
import '/components/remove_product/remove_product_widget.dart';
import '/components/side_menu/side_menu_widget.dart';
import '/features/products/domain/entities/product.dart';
import '/features/products/domain/entities/product_variant.dart';
import '/features/storefront/presentation/providers/storefront_providers.dart'
    hide productVariantsProvider;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'product_details_providers.dart';

/// Page to show the product's details, so when they click the product on the
/// "Home_Main" page they'll be routed here to show the product's details.
class ProductDetailsPageWidget extends ConsumerStatefulWidget {
  const ProductDetailsPageWidget({
    super.key,
    required this.productId,
    this.storeSlug,
  });

  final String? productId;
  final StoresRow? storeSlug;

  static String routeName = 'Product_Details_Page';
  static String routePath = '/productDetailsPage';

  @override
  ConsumerState<ProductDetailsPageWidget> createState() =>
      _ProductDetailsPageWidgetState();
}

class _ProductDetailsPageWidgetState
    extends ConsumerState<ProductDetailsPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  PageController? _pageviewController;
  int _activeMediaIndex = 0;

  @override
  void dispose() {
    _pageviewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.productId == null) {
      return Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: const Center(child: Text('Product ID is required')),
      );
    }

    final mediaAsync = ref.watch(productMediaProvider(widget.productId!));
    final storeAsync = ref.watch(myStoreProvider);

    return mediaAsync.when(
      data: (mediaRows) {
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
                data: (store) => store != null
                    ? _buildWithStore(context, store, mediaRows)
                    : _buildLoadingContent(context, mediaRows, null),
                loading: () => _buildLoadingContent(context, mediaRows, null),
                error: (e, s) => _buildLoadingContent(context, mediaRows, null),
              ),
            ),
          ),
        );
      },
      loading: () => Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: SpinKitWanderingCubes(
              color: FlutterFlowTheme.of(context).primary,
              size: 50.0,
            ),
          ),
        ),
      ),
      error: (error, stack) => Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildWithStore(
    BuildContext context,
    dynamic store,
    List<ProductMediaDbRow> mediaRows,
  ) {
    return _buildLoadingContent(context, mediaRows, store);
  }

  Widget _buildLoadingContent(
    BuildContext context,
    List<ProductMediaDbRow> mediaRows,
    dynamic store,
  ) {
    final productAsync = ref.watch(productByIdProvider(widget.productId!));
    final variantsAsync = ref.watch(productVariantsProvider(widget.productId!));

    return productAsync.when(
      data: (product) => _buildContent(context, product, mediaRows, variantsAsync, store),
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
      error: (error, stack) => Center(child: Text('Error loading product: $error')),
    );
  }

  Widget _buildContent(
    BuildContext context,
    Product product,
    List<ProductMediaDbRow> mediaRows,
    AsyncValue<List<ProductVariant>> variantsAsync,
    dynamic store,
  ) {
    final storeInitials = store != null ? functions.getInitials(store.name) : '';
    final storeName = store?.name ?? 'Northing Official';

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        // Top nav bar
        _buildTopNav(context, product, storeName, storeInitials),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back + Edit row
                _buildBackEditRow(context),
                // Product Link section
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 2.0),
                  child: _buildProductLinkSection(context, product, store),
                ),
                // Product name + media
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product title
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 48.0, 0.0),
                        child: Text(
                          product.name,
                          style: FlutterFlowTheme.of(context).titleLarge.override(
                                fontFamily: 'General Sans',
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                      // Main image/video PageView
                      _buildMediaPageView(context, mediaRows),
                      // Thumbnail strip
                      _buildThumbnailStrip(context, mediaRows),
                    ].divide(const SizedBox(height: 10.0)),
                  ),
                ),
                // Product Price
                _buildLabelValueSection(context, 'Product Price',
                    'NGN ${product.price.toStringAsFixed(0)}'),
                // Product Description
                _buildLabelValueSection(context, 'Product Description',
                    product.description ?? ''),
                // Available sizes
                _buildSizesSection(context, variantsAsync),
                // Available Colours
                _buildColoursSection(context, variantsAsync),
                // Product Weight
                _buildWeightSection(context, product),
                // Product Quantity Remaining
                _buildQuantitySection(context, product),
                // Remove Product button
                _buildRemoveButton(context, product),
              ].divide(const SizedBox(height: 16.0)).addToEnd(const SizedBox(height: 80.0)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopNav(
    BuildContext context,
    Product product,
    String storeName,
    String storeInitials,
  ) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Divider(height: 1.0, thickness: 1.0, color: Color(0xFFEAEDED)),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 16.0),
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
                    onTap: () => scaffoldKey.currentState!.openDrawer(),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
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
                // Store name + avatar
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      product.name,
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
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
                      child: Center(
                        child: Text(
                          storeInitials,
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                fontFamily: 'General Sans',
                                fontSize: 10.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  ].divide(const SizedBox(width: 8.0)),
                ),
              ],
            ),
          ),
          const Divider(height: 1.0, thickness: 1.0, color: Color(0xFFEAEDED)),
        ],
      ),
    );
  }

  Widget _buildBackEditRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Back button
          Expanded(
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => context.safePop(),
              child: Container(
                decoration: const BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.chevronLeft,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 14.0,
                      ),
                      Text(
                        'Back',
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily: 'General Sans',
                              fontSize: 18.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              lineHeight: 1.33,
                            ),
                      ),
                    ].divide(const SizedBox(width: 8.0)),
                  ),
                ),
              ),
            ),
          ),
          // Edit button
          FFButtonWidget(
            onPressed: () {
              print('Edit button pressed ...');
            },
            text: 'Edit',
            icon: const Icon(Icons.edit_outlined, size: 16.0),
            options: FFButtonOptions(
              height: 32.0,
              padding: const EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
              iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
        ]
            .addToStart(const SizedBox(width: 20.0))
            .addToEnd(const SizedBox(width: 20.0)),
      ),
    );
  }

  Widget _buildProductLinkSection(
    BuildContext context,
    Product product,
    dynamic store,
  ) {
    final storeSlug = store?.slug ?? widget.storeSlug?.slug ?? '';
    final productLink =
        'https://hadi.northing.shop/$storeSlug/${product.id}';

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Link',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
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
            padding: const EdgeInsetsDirectional.fromSTEB(10.0, 16.0, 10.0, 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  productLink,
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'General Sans',
                        color: const Color(0xFF797979),
                        fontSize: 13.0,
                        letterSpacing: 0.0,
                      ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: productLink));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Copied ✅',
                          style: FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'General Sans',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                        ),
                        duration: const Duration(milliseconds: 4000),
                        backgroundColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                    );
                  },
                  text: 'Copy ',
                  options: FFButtonOptions(
                    padding: const EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 5.0),
                    iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: const Color(0xFFF4F0E7),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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
    );
  }

  Widget _buildMediaPageView(
      BuildContext context, List<ProductMediaDbRow> mediaRows) {
    _pageviewController ??= PageController(
      initialPage: max(0, min(0, mediaRows.length - 1)),
    );

    return SizedBox(
      width: double.infinity,
      height: 319.0,
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageviewController,
        onPageChanged: (index) {
          setState(() {
            _activeMediaIndex = index;
          });
        },
        scrollDirection: Axis.horizontal,
        itemCount: mediaRows.isEmpty ? 1 : mediaRows.length,
        itemBuilder: (context, index) {
          if (mediaRows.isEmpty) {
            return Container(
              color: Colors.grey[200],
              child: const Center(
                child: Icon(Icons.image, size: 60.0, color: Colors.grey),
              ),
            );
          }
          final mediaItem = mediaRows[index];
          final isVideo = mediaItem.isVideo == true;

          if (!isVideo) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                functions.urlToImagePath(mediaItem.publicUrl ?? ''),
                width: double.infinity,
                height: 200.0,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stack) => Container(
                  color: Colors.grey[200],
                  child: const Center(child: Icon(Icons.broken_image, size: 60.0)),
                ),
              ),
            );
          } else {
            // Video placeholder (FlutterFlowVideoPlayer not used in clean arch version)
            return Container(
              color: Colors.black,
              child: const Center(
                child: Icon(Icons.play_circle_fill, size: 60.0, color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildThumbnailStrip(
      BuildContext context, List<ProductMediaDbRow> mediaRows) {
    if (mediaRows.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      width: double.infinity,
      height: 52.0,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: mediaRows.length,
        separatorBuilder: (_, __) => const SizedBox(width: 5.0),
        itemBuilder: (context, index) {
          final mediaItem = mediaRows[index];
          final isVideo = mediaItem.isVideo == true;
          final isActive = _activeMediaIndex == index;

          return InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              await _pageviewController?.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
            child: Container(
              width: 57.5,
              height: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(2.61),
                border: Border.all(
                  color: isActive
                      ? FlutterFlowTheme.of(context).tertiary
                      : const Color(0x00000000),
                  width: 1.0,
                ),
              ),
              child: !isVideo
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        functions.urlToImagePath(mediaItem.publicUrl ?? ''),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    )
                  : const Center(
                      child: Icon(Icons.play_circle_fill, size: 24.0),
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabelValueSection(
      BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'General Sans',
                  color: FlutterFlowTheme.of(context).primary,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Text(
            value.isNotEmpty ? value : '-',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'General Sans',
                  color: const Color(0xFF1B1A23),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.normal,
                ),
          ),
        ].divide(const SizedBox(height: 8.0)),
      ),
    );
  }

  Widget _buildSizesSection(
      BuildContext context, AsyncValue<List<ProductVariant>> variantsAsync) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available sizes',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'General Sans',
                  color: FlutterFlowTheme.of(context).primary,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
          variantsAsync.when(
            data: (variants) => Wrap(
              spacing: 5.0,
              runSpacing: 0.0,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.start,
              verticalDirection: VerticalDirection.down,
              clipBehavior: Clip.none,
              children: variants.map((variant) {
                return Container(
                  height: 31.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          variant.size ?? '0',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'General Sans',
                                color: const Color(0xFF1B1A23),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            loading: () => const SizedBox(
              width: 50.0,
              height: 50.0,
              child: SpinKitWanderingCubes(color: Colors.grey, size: 50.0),
            ),
            error: (e, s) => const SizedBox.shrink(),
          ),
        ].divide(const SizedBox(height: 8.0)),
      ),
    );
  }

  Widget _buildColoursSection(
      BuildContext context, AsyncValue<List<ProductVariant>> variantsAsync) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Colours',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'General Sans',
                  color: FlutterFlowTheme.of(context).primary,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
          variantsAsync.when(
            data: (variants) => Wrap(
              spacing: 5.0,
              runSpacing: 0.0,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.start,
              verticalDirection: VerticalDirection.down,
              clipBehavior: Clip.none,
              children: variants.map((variant) {
                return Container(
                  height: 31.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          variant.color ?? 'Black',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'General Sans',
                                color: const Color(0xFF1B1A23),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            loading: () => const SizedBox(
              width: 50.0,
              height: 50.0,
              child: SpinKitWanderingCubes(color: Colors.grey, size: 50.0),
            ),
            error: (e, s) => const SizedBox.shrink(),
          ),
        ].divide(const SizedBox(height: 8.0)),
      ),
    );
  }

  Widget _buildWeightSection(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Weight',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'General Sans',
                  color: FlutterFlowTheme.of(context).primary,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 31.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${product.weightGrams?.toString() ?? '0'}KG',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'General Sans',
                              color: const Color(0xFF1B1A23),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ].divide(const SizedBox(width: 5.0)),
          ),
        ].divide(const SizedBox(height: 8.0)),
      ),
    );
  }

  Widget _buildQuantitySection(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Quantity Remaining',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'General Sans',
                  color: FlutterFlowTheme.of(context).primary,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 31.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.stockQuantity?.toString() ?? '0',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'General Sans',
                              color: const Color(0xFF1B1A23),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ].divide(const SizedBox(width: 5.0)),
          ),
        ].divide(const SizedBox(height: 8.0)),
      ),
    );
  }

  Widget _buildRemoveButton(BuildContext context, Product product) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: const AlignmentDirectional(1.0, 1.0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
            child: FFButtonWidget(
              onPressed: () async {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: const Color(0x52000000),
                  context: context,
                  builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Padding(
                        padding: MediaQuery.viewInsetsOf(context),
                        child: RemoveProductWidget(productId: product.id),
                      ),
                    );
                  },
                ).then((value) => setState(() {}));
              },
              text: 'Remove Product',
              icon: FaIcon(FontAwesomeIcons.trashAlt, size: 16.0),
              options: FFButtonOptions(
                height: 40.0,
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                iconAlignment: IconAlignment.end,
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconColor: const Color(0xFF652424),
                color: const Color(0x7BFDE0E6),
                textStyle: FlutterFlowTheme.of(context).labelSmall.override(
                      fontFamily: 'General Sans',
                      color: const Color(0xFF652424),
                      fontSize: 14.0,
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
    );
  }
}
