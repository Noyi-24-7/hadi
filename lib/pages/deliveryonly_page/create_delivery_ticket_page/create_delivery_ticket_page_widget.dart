import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/components/side_menu/side_menu_widget.dart';
import '/features/storefront/domain/entities/store_entity.dart';
import '/features/storefront/presentation/providers/storefront_providers.dart';
import '/features/orders/presentation/providers/checkout_provider.dart';
import '../../personal_business_information/add_pickup_address_page/add_pickup_address_page_widget.dart';
import 'create_delivery_ticket_page_model.dart';

export 'create_delivery_ticket_page_model.dart';


class CreateDeliveryTicketPageWidget extends ConsumerStatefulWidget {
  const CreateDeliveryTicketPageWidget({super.key});

  static String routeName = 'Create_Delivery_Ticket_Page';
  static String routePath = '/createDeliveryTicketPage';

  @override
  ConsumerState<CreateDeliveryTicketPageWidget> createState() =>
      _CreateDeliveryTicketPageWidgetState();
}

class _CreateDeliveryTicketPageWidgetState
    extends ConsumerState<CreateDeliveryTicketPageWidget> {
  late CreateDeliveryTicketPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateDeliveryTicketPageModel());

    _model.tfProductNameTextController1 ??= TextEditingController();
    _model.tfProductNameFocusNode1 ??= FocusNode();
    _model.tfProductAmountTextController ??= TextEditingController();
    _model.tfProductAmountFocusNode ??= FocusNode();
    _model.tfQuantityTextController ??= TextEditingController();
    _model.tfQuantityFocusNode ??= FocusNode();
    _model.tfWeightTextController ??= TextEditingController();
    _model.tfWeightFocusNode ??= FocusNode();
    _model.tfProductNameTextController2 ??= TextEditingController();
    _model.tfProductNameFocusNode2 ??= FocusNode();
    _model.tfProductNameTextController3 ??= TextEditingController();
    _model.tfProductNameFocusNode3 ??= FocusNode();
    _model.tfProductNameTextController4 ??= TextEditingController();
    _model.tfProductNameFocusNode4 ??= FocusNode();
    _model.tfProductNameTextController5 ??= TextEditingController();
    _model.tfProductNameFocusNode5 ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

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
        drawer: Drawer(
          elevation: 16.0,
          child: SideMenuWidget(),
        ),
        body: SafeArea(
          top: true,
          child: storeAsync.when(
            data: (store) {
              if (store == null) return _buildError(context, 'Store not found');
              return _buildContent(context, store);
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
            'Failed to load data',
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

  Widget _buildContent(BuildContext context, StoreEntity store) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context, store),
        _buildBackButton(context),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
          child: Text(
            'Create Delivery Ticket',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'General Sans',
                  color: const Color(0xFF131919),
                  letterSpacing: 0.0,
                ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
              child: Column(
                children: [
                  _buildItemNameField(context),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(child: _buildItemAmountField(context)),
                      const SizedBox(width: 12.0),
                      Expanded(child: _buildQuantityField(context)),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  _buildWeightField(context),
                  const SizedBox(height: 32.0),
                  _buildCreateButton(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, StoreEntity store) {
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
                Row(
                  children: [
                    Text(
                      store.name,
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
                          functions.getInitials(store.name),
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

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
      child: InkWell(
        onTap: () => context.safePop(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FaIcon(
              FontAwesomeIcons.chevronLeft,
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
    );
  }

  Widget _buildItemNameField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Name',
          style: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: 'General Sans',
                color: const Color(0xFF645E82),
                letterSpacing: 0.0,
                fontWeight: FontWeight.normal,
                lineHeight: 1.5,
              ),
        ),
        const SizedBox(height: 4.0),
        TextFormField(
          controller: _model.tfProductNameTextController1,
          focusNode: _model.tfProductNameFocusNode1,
          decoration: InputDecoration(
            isDense: true,
            hintText: 'eg. Nike Dunks',
            hintStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'General Sans',
                  color: const Color(0xFFD6D6D6),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  lineHeight: 1.5,
                ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFE1DFEC), width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).primary,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: FlutterFlowTheme.of(context).primaryBackground,
            contentPadding: const EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 20.0),
          ),
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'General Sans',
                color: const Color(0xFF1B1A23),
                letterSpacing: 0.0,
                fontWeight: FontWeight.w500,
                lineHeight: 1.5,
              ),
        ),
      ],
    );
  }

  Widget _buildItemAmountField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Amount',
          style: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: 'General Sans',
                color: const Color(0xFF645E82),
                letterSpacing: 0.0,
                fontWeight: FontWeight.normal,
                lineHeight: 1.5,
              ),
        ),
        const SizedBox(height: 4.0),
        TextFormField(
          controller: _model.tfProductAmountTextController,
          focusNode: _model.tfProductAmountFocusNode,
          decoration: InputDecoration(
            isDense: true,
            hintText: '₦0.00',
            hintStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'General Sans',
                  color: const Color(0xFFD6D6D6),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  lineHeight: 1.5,
                ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFE1DFEC), width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).primary,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: FlutterFlowTheme.of(context).primaryBackground,
            contentPadding: const EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 20.0),
          ),
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'General Sans',
                color: const Color(0xFF1B1A23),
                letterSpacing: 0.0,
                fontWeight: FontWeight.w500,
                lineHeight: 1.5,
              ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildQuantityField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quantity',
          style: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: 'General Sans',
                color: const Color(0xFF645E82),
                letterSpacing: 0.0,
                fontWeight: FontWeight.normal,
                lineHeight: 1.5,
              ),
        ),
        const SizedBox(height: 4.0),
        TextFormField(
          controller: _model.tfQuantityTextController,
          focusNode: _model.tfQuantityFocusNode,
          decoration: InputDecoration(
            isDense: true,
            hintText: '0',
            hintStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'General Sans',
                  color: const Color(0xFFD6D6D6),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  lineHeight: 1.5,
                ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFE1DFEC), width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).primary,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: FlutterFlowTheme.of(context).primaryBackground,
            contentPadding: const EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 20.0),
          ),
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'General Sans',
                color: const Color(0xFF1B1A23),
                letterSpacing: 0.0,
                fontWeight: FontWeight.w500,
                lineHeight: 1.5,
              ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildWeightField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weight (kg)',
          style: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: 'General Sans',
                color: const Color(0xFF645E82),
                letterSpacing: 0.0,
                fontWeight: FontWeight.normal,
                lineHeight: 1.5,
              ),
        ),
        const SizedBox(height: 4.0),
        TextFormField(
          controller: _model.tfWeightTextController,
          focusNode: _model.tfWeightFocusNode,
          decoration: InputDecoration(
            isDense: true,
            hintText: '0.0',
            hintStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'General Sans',
                  color: const Color(0xFFD6D6D6),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  lineHeight: 1.5,
                ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFE1DFEC), width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).primary,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: FlutterFlowTheme.of(context).primaryBackground,
            contentPadding: const EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 20.0),
          ),
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'General Sans',
                color: const Color(0xFF1B1A23),
                letterSpacing: 0.0,
                fontWeight: FontWeight.w500,
                lineHeight: 1.5,
              ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
      ],
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    return FFButtonWidget(
      onPressed: () {
        if (_model.tfProductNameTextController1.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter item name')),
          );
          return;
        }

        ref.read(checkoutSessionProvider.notifier).updateItemDetails(
              name: _model.tfProductNameTextController1.text,
              value: double.tryParse(_model.tfProductAmountTextController.text) ?? 0.0,
              quantity: int.tryParse(_model.tfQuantityTextController.text) ?? 1,
              weight: double.tryParse(_model.tfWeightTextController.text) ?? 0.0,
            );
        
        context.pushNamed(AddPickupAddressPageWidget.routeName);
      },
      text: 'Create Ticket',
      options: FFButtonOptions(
        width: double.infinity,
        height: 56.0,
        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
        color: FlutterFlowTheme.of(context).primary,
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              fontFamily: 'General Sans',
              color: Colors.white,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w600,
            ),
        elevation: 0.0,
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }
}
