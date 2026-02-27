import '/backend/schema/structs/index.dart';

import '/components/comp_color_qty_row/comp_color_qty_row_widget.dart';
import '/components/comp_size_qty_row/comp_size_qty_row_widget.dart';
import '/components/select_address_bottom_sheet/select_address_bottom_sheet_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/features/products/presentation/providers/product_providers.dart';

import 'add_a_new_product_page_model.dart';
export 'add_a_new_product_page_model.dart';

/// Page that would take in all the necessary information about the product.
///
/// Then save all this information to Supabase.
class AddANewProductPageWidget extends ConsumerStatefulWidget {
  const AddANewProductPageWidget({
    super.key,
    required this.storeId,
  });

  final String? storeId;

  static String routeName = 'Add_A_New_Product_Page';
  static String routePath = '/addANewProductPage';

  @override
  ConsumerState<AddANewProductPageWidget> createState() =>
      _AddANewProductPageWidgetState();
}

class _AddANewProductPageWidgetState extends ConsumerState<AddANewProductPageWidget> {
  late AddANewProductPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddANewProductPageModel());

    _model.tfProductNameTextController ??= TextEditingController();
    _model.tfProductNameFocusNode ??= FocusNode();

    _model.tfDescriptionsTextController ??= TextEditingController();
    _model.tfDescriptionsFocusNode ??= FocusNode();

    _model.tfWeightKgTextController ??= TextEditingController();
    _model.tfWeightKgFocusNode ??= FocusNode();

    _model.tfPriceTextController ??= TextEditingController();
    _model.tfPriceFocusNode ??= FocusNode();

    _model.tfLimitedQtyTextController ??= TextEditingController();
    _model.tfLimitedQtyFocusNode ??= FocusNode();

    _model.tfSizeLabelTextController ??= TextEditingController();
    _model.tfSizeLabelFocusNode ??= FocusNode();

    _model.tfColorLabelTextController ??= TextEditingController();
    _model.tfColorLabelFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Context watch removed as it is not needed for FFAppState in this specific widget or handled by Consumer
    // context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Back Button.
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 0.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.safePop();
                              },
                              child: Container(
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      6.0, 0.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.chevronLeft,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 14.0,
                                      ),
                                      Text(
                                        'Back',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: 'General Sans',
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              lineHeight: 1.33,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'New Product',
                          style:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'General Sans',
                                    letterSpacing: 0.0,
                                    lineHeight: 1.33,
                                  ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 20.0, 0.0),
                            child: Container(
                              decoration: BoxDecoration(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          // Row containing a check mark to set if this product is a preorder product or not.
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 20.0, 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Theme(
                                  data: ThemeData(
                                    checkboxTheme: CheckboxThemeData(
                                      visualDensity: VisualDensity.compact,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                    ),
                                    unselectedWidgetColor: Color(0xFF495A69),
                                  ),
                                  child: Checkbox(
                                    value: _model.checkboxValue ??=
                                        _model.isPreorder,
                                    onChanged: (newValue) async {
                                      safeSetState(() =>
                                          _model.checkboxValue = newValue!);
                                      if (newValue!) {
                                        _model.isPreorder =
                                            _model.checkboxValue!;
                                        safeSetState(() {});
                                      }
                                    },
                                    side: BorderSide(
                                            width: 2,
                                            color: Color(0xFF495A69),
                                          ),
                                    activeColor: Color(0xFF2881D3),
                                    checkColor:
                                        FlutterFlowTheme.of(context).info,
                                  ),
                                ),
                                Text(
                                  'Set this product as pre-order',
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: 'General Sans',
                                        color: Color(0xFF384A62),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 20.0, 16.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFE9F3F7),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 16.0, 12.0, 16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Important Info',
                                      style: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: Color(0xFF131919),
                                            letterSpacing: 0.0,
                                            lineHeight: 1.33,
                                          ),
                                    ),
                                    Text(
                                      'If the product is unavailable, use the pre-order feature to generate interest or sell custom-made items. Once ready, you can request pickup from the item\'s location.',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'General Sans',
                                            color: Color(0xFF434343),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.7142857143,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 5.0)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 14.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Product Name',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'General Sans',
                                              color: Color(0xFF645E82),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              lineHeight: 1.5,
                                            ),
                                      ),

                                      // Text Field where the user would enter the product's name.
                                      Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller: _model
                                              .tfProductNameTextController,
                                          focusNode:
                                              _model.tfProductNameFocusNode,
                                          autofocus: false,
                                          enabled: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily:
                                                          'General Sans',
                                                      letterSpacing: 0.0,
                                                    ),
                                            hintText: 'eg. Nike Dunks',
                                            hintStyle: FlutterFlowTheme.of(
                                                    context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'General Sans',
                                                  color: Color(0xFFD6D6D6),
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  lineHeight: 1.5,
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFE1DFEC),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            filled: true,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 20.0, 16.0, 20.0),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily: 'General Sans',
                                                color: Color(0xFF1B1A23),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                lineHeight: 1.5,
                                              ),
                                          cursorColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          enableInteractiveSelection: true,
                                          validator: _model
                                              .tfProductNameTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 4.0)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Product Category',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'General Sans',
                                              color: Color(0xFF645E82),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              lineHeight: 1.5,
                                            ),
                                      ),

                                      // Dropdown the user would use to select the category of the product.
                                      FlutterFlowDropDown<String>(
                                        controller: _model
                                                .tfcategoryValueController ??=
                                            FormFieldController<String>(null),
                                        options: FFAppState().productCategories,
                                        onChanged: (val) async {
                                          safeSetState(() =>
                                              _model.tfcategoryValue = val);
                                          _model.selectedCategory =
                                              _model.tfcategoryValue;
                                          safeSetState(() {});
                                        },
                                        width: double.infinity,
                                        height: 53.0,
                                        searchHintTextStyle:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'General Sans',
                                                  letterSpacing: 0.0,
                                                ),
                                        searchTextStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'General Sans',
                                                  letterSpacing: 0.0,
                                                ),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'General Sans',
                                              letterSpacing: 0.0,
                                              lineHeight: 1.5,
                                            ),
                                        hintText: 'Select Category...',
                                        searchHintText: 'Search...',
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Color(0xFF645E82),
                                          size: 24.0,
                                        ),
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        elevation: 2.0,
                                        borderColor: Color(0xFFE1DFEC),
                                        borderWidth: 1.0,
                                        borderRadius: 8.0,
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        hidesUnderline: true,
                                        isOverButton: false,
                                        isSearchable: true,
                                        isMultiSelect: false,
                                      ),
                                    ].divide(SizedBox(height: 4.0)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Descriptions',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'General Sans',
                                              color: Color(0xFF645E82),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              lineHeight: 1.5,
                                            ),
                                      ),

                                      // Text Field used to enter the description of the product.
                                      Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller: _model
                                              .tfDescriptionsTextController,
                                          focusNode:
                                              _model.tfDescriptionsFocusNode,
                                          autofocus: false,
                                          enabled: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily:
                                                          'General Sans',
                                                      letterSpacing: 0.0,
                                                    ),
                                            hintText:
                                                'eg. New SB Nike rabbit shoes, comfortable wear for all occasions.',
                                            hintStyle: FlutterFlowTheme.of(
                                                    context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'General Sans',
                                                  color: Color(0xFFD6D6D6),
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  lineHeight: 1.5,
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFE1DFEC),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            filled: true,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 20.0, 16.0, 20.0),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily: 'General Sans',
                                                color: Color(0xFF1B1A23),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                lineHeight: 1.5,
                                              ),
                                          maxLines: null,
                                          minLines: 4,
                                          cursorColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          enableInteractiveSelection: true,
                                          validator: _model
                                              .tfDescriptionsTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 4.0)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Weight (Kg)',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'General Sans',
                                              color: Color(0xFF645E82),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              lineHeight: 1.5,
                                            ),
                                      ),

                                      // Text Field the used to enter the weight of the product
                                      Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller:
                                              _model.tfWeightKgTextController,
                                          focusNode: _model.tfWeightKgFocusNode,
                                          autofocus: false,
                                          enabled: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily:
                                                          'General Sans',
                                                      letterSpacing: 0.0,
                                                    ),
                                            hintText: 'eg. 1.2',
                                            hintStyle: FlutterFlowTheme.of(
                                                    context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'General Sans',
                                                  color: Color(0xFFD6D6D6),
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  lineHeight: 1.5,
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFE1DFEC),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            filled: true,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 20.0, 16.0, 20.0),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily: 'General Sans',
                                                color: Color(0xFF1B1A23),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                lineHeight: 1.5,
                                              ),
                                          cursorColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          enableInteractiveSelection: true,
                                          validator: _model
                                              .tfWeightKgTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 4.0)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Price',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'General Sans',
                                              color: Color(0xFF645E82),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              lineHeight: 1.5,
                                            ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: 70.0,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF2F2F2),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              border: Border.all(
                                                color: Color(0xFFE1DFEC),
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 18.0, 0.0, 18.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'NGN',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'General Sans',
                                                          color:
                                                              Color(0xFF686868),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // Text Field used to enter the product price.
                                          Expanded(
                                            child: TextFormField(
                                              controller:
                                                  _model.tfPriceTextController,
                                              focusNode:
                                                  _model.tfPriceFocusNode,
                                              autofocus: false,
                                              enabled: true,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'General Sans',
                                                          letterSpacing: 0.0,
                                                        ),
                                                hintText: 'eg. 60,000',
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .override(
                                                          fontFamily:
                                                              'General Sans',
                                                          color:
                                                              Color(0xFFD6D6D6),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          lineHeight: 1.5,
                                                        ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xFFE1DFEC),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                filled: true,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                contentPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(16.0, 20.0,
                                                            16.0, 20.0),
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyLarge
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    color: Color(0xFF1B1A23),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    lineHeight: 1.5,
                                                  ),
                                              cursorColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              enableInteractiveSelection: true,
                                              validator: _model
                                                  .tfPriceTextControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 5.0)),
                                      ),
                                    ].divide(SizedBox(height: 4.0)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Quantity',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'General Sans',
                                              color: Color(0xFF645E82),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              lineHeight: 1.5,
                                            ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          // Dropdown used to set if the product is unlimited or not.
                                          FlutterFlowDropDown<String>(
                                            controller: _model
                                                    .ddLimitsValueController ??=
                                                FormFieldController<String>(
                                                    null),
                                            options: List<String>.from(
                                                ['Unlimited', 'Limited']),
                                            optionLabels: [
                                              'Unlimited',
                                              'Limited'
                                            ],
                                            onChanged: (val) async {
                                              safeSetState(() =>
                                                  _model.ddLimitsValue = val);
                                              _model.qtyType =
                                                  _model.ddLimitsValue!;
                                              safeSetState(() {});
                                            },
                                            height: 53.0,
                                            searchHintTextStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily:
                                                          'General Sans',
                                                      letterSpacing: 0.0,
                                                    ),
                                            searchTextStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          'General Sans',
                                                      letterSpacing: 0.0,
                                                    ),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          'General Sans',
                                                      letterSpacing: 0.0,
                                                      lineHeight: 1.5,
                                                    ),
                                            hintText: 'Limited',
                                            searchHintText: 'Search...',
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color: Color(0xFF645E82),
                                              size: 24.0,
                                            ),
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            elevation: 2.0,
                                            borderColor: Color(0xFFE1DFEC),
                                            borderWidth: 1.0,
                                            borderRadius: 8.0,
                                            margin:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            hidesUnderline: true,
                                            isOverButton: false,
                                            isSearchable: true,
                                            isMultiSelect: false,
                                          ),

                                          // Text Field used to enter the quantity of the product, only visible if the ddLimits dropdown is set to limited.
                                          if (_model.qtyType == 'Limited')
                                            Expanded(
                                              child: TextFormField(
                                                controller: _model
                                                    .tfLimitedQtyTextController,
                                                focusNode: _model
                                                    .tfLimitedQtyFocusNode,
                                                onFieldSubmitted: (_) async {
                                                  _model.limitedQty =
                                                      int.tryParse(_model
                                                          .tfLimitedQtyTextController
                                                          .text);
                                                  safeSetState(() {});
                                                },
                                                autofocus: false,
                                                enabled: true,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .override(
                                                            fontFamily:
                                                                'General Sans',
                                                            letterSpacing: 0.0,
                                                          ),
                                                  hintText: 'eg. 10',
                                                  hintStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily:
                                                            'General Sans',
                                                        color:
                                                            Color(0xFFD6D6D6),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        lineHeight: 1.5,
                                                      ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFE1DFEC),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryBackground,
                                                  contentPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(16.0, 20.0,
                                                              16.0, 20.0),
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .override(
                                                          fontFamily:
                                                              'General Sans',
                                                          color:
                                                              Color(0xFF1B1A23),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          lineHeight: 1.5,
                                                        ),
                                                cursorColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                enableInteractiveSelection:
                                                    true,
                                                validator: _model
                                                    .tfLimitedQtyTextControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                        ].divide(SizedBox(width: 5.0)),
                                      ),
                                    ].divide(SizedBox(height: 4.0)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Select Pickup Address',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'General Sans',
                                              color: Color(0xFF645E82),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              lineHeight: 1.5,
                                            ),
                                      ),

                                      // Container to activate the bottom sheet "Select_Address_Bottom_Sheet" component.
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Color(0x52000000),
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child:
                                                      SelectAddressBottomSheetWidget(
                                                    storeId: widget.storeId!,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => safeSetState(() =>
                                              _model.selectPickupAddress =
                                                  value));

                                          _model.pickupAddressId =
                                              _model.selectPickupAddress?.id;
                                          _model.pickupAddressLabel =
                                              '${_model.selectPickupAddress?.addressLine1}, ${_model.selectPickupAddress?.city}, ${_model.selectPickupAddress?.state}, ${_model.selectPickupAddress?.country}';
                                          safeSetState(() {});

                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 53.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                              color: Color(0xFFE1DFEC),
                                            ),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      _model.pickupAddressLabel ==
                                                                  null ||
                                                              _model.pickupAddressLabel ==
                                                                  ''
                                                          ? 'Select Address...'
                                                          : _model
                                                              .pickupAddressLabel,
                                                      'Select Address...',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'General Sans',
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color: Color(0xFF645E82),
                                                  size: 24.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 4.0)),
                                  ),
                                ),
                              ].divide(SizedBox(height: 20.0)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 4.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 14.0, 0.0, 0.0),
                                        child: Container(
                                          width: 24.0,
                                          height: 24.0,
                                          decoration: BoxDecoration(),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/arrow-all-direction.png',
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Toggle on to add sizes. it would make the collumn containing the text field for users to input the sizes, the chips reflecting the size, text field for the size's price, the quantity of that price and the total quantity strip.
                                      Expanded(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: SwitchListTile(
                                            value: _model
                                                .switchListTileValue1 ??= false,
                                            onChanged: (newValue) async {
                                              safeSetState(() =>
                                                  _model.switchListTileValue1 =
                                                      newValue);
                                              if (newValue) {
                                                _model.isAddSizesOn = true;
                                                safeSetState(() {});
                                              }
                                            },
                                            title: Text(
                                              'Add Sizes',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelLarge
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    color: Color(0xFF131919),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    lineHeight: 1.71,
                                                  ),
                                            ),
                                            subtitle: Text(
                                              'If your product has different sizes',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    color: Color(0xFF434343),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            activeThumbColor: Colors.white,
                                            activeTrackColor: Color(0xFF0C1D1F),
                                            dense: true,
                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .trailing,
                                            contentPadding: EdgeInsets.all(0.0),
                                          ),
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

                          // Only visible if the add size toggle is on.
                          if (_model.isAddSizesOn == true)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 14.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 0.0, 20.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Available Sizes',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'General Sans',
                                                          color:
                                                              Color(0xFF645E82),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          lineHeight: 1.5,
                                                        ),
                                              ),
                                            ),
                                            Text(
                                              'Hit enter when you input a size',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelSmall
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    color: Color(0xFF645E82),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    lineHeight: 1.5,
                                                  ),
                                            ),
                                          ],
                                        ),

                                        // Text Field for entering the Sizes, once the user presses enter, it saves it and creates a chip to display it.
                                        Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller: _model
                                                .tfSizeLabelTextController,
                                            focusNode:
                                                _model.tfSizeLabelFocusNode,
                                            onFieldSubmitted: (_) async {
                                              _model.addToSizesList(
                                                  SizeEntryStruct(
                                                label: _model
                                                    .tfSizeLabelTextController
                                                    .text,
                                                price: 0.0,
                                                qty: 0,
                                              ));
                                              safeSetState(() {});
                                              safeSetState(() {
                                                _model.tfSizeLabelTextController
                                                    ?.clear();
                                              });
                                              _model.totalQty =
                                                  _model.totalQty +
                                                      _model.sizesList
                                                          .firstOrNull!.qty;
                                              safeSetState(() {});
                                            },
                                            autofocus: false,
                                            enabled: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            'General Sans',
                                                        letterSpacing: 0.0,
                                                      ),
                                              hintText: 'eg. 42',
                                              hintStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyLarge
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    color: Color(0xFFD6D6D6),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    lineHeight: 1.5,
                                                  ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFE1DFEC),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 20.0,
                                                          16.0, 20.0),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'General Sans',
                                                  color: Color(0xFF1B1A23),
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  lineHeight: 1.5,
                                                ),
                                            cursorColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            enableInteractiveSelection: true,
                                            validator: _model
                                                .tfSizeLabelTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 8.0, 0.0, 0.0),
                                                child: Builder(
                                                  builder: (context) {
                                                    final sizeList = _model
                                                        .sizesList
                                                        .toList();

                                                    return Wrap(
                                                      spacing: 10.0,
                                                      runSpacing: 10.0,
                                                      alignment:
                                                          WrapAlignment.start,
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .start,
                                                      direction:
                                                          Axis.horizontal,
                                                      runAlignment:
                                                          WrapAlignment.start,
                                                      verticalDirection:
                                                          VerticalDirection
                                                              .down,
                                                      clipBehavior: Clip.none,
                                                      children: List.generate(
                                                          sizeList.length,
                                                          (sizeListIndex) {
                                                        final sizeListItem =
                                                            sizeList[
                                                                sizeListIndex];
                                                        return
                                                            // Size_Chip meant to show the sizes.
                                                            Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        6.0,
                                                                        8.0,
                                                                        6.0,
                                                                        8.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                // Size entered in the tfSizeLabel Text Field.
                                                                Text(
                                                                  sizeListItem
                                                                      .label,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'General Sans',
                                                                        color: Color(
                                                                            0xFF1B1A23),
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),

                                                                // Icon that when pressed the chip would disapear and not be included in Supabase.
                                                                InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    _model.tempOldQty =
                                                                        sizeListItem
                                                                            .qty;
                                                                    safeSetState(
                                                                        () {});
                                                                    _model.removeFromSizesList(
                                                                        sizeListItem);
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .close_rounded,
                                                                    color: Color(
                                                                        0xFF1B1A23),
                                                                    size: 20.0,
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 10.0)),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ].divide(SizedBox(height: 4.0)),
                                    ),
                                  ),

                                  // Containing all the size and quantity items.
                                  Builder(
                                    builder: (context) {
                                      final sizePriceList =
                                          _model.sizesList.toList();

                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children:
                                            List.generate(sizePriceList.length,
                                                (sizePriceListIndex) {
                                          final sizePriceListItem =
                                              sizePriceList[sizePriceListIndex];
                                          return
                                              // Component with 2 Text Fields to enter the Size's price and quantity. For example Size is 40, size 40 price (Text Field) and size 40 quantity available (Text Field).
                                              CompSizeQtyRowWidget(
                                            key: Key(
                                                'Key10b_${sizePriceListIndex}_of_${sizePriceList.length}'),
                                            sizeEntry: sizePriceListItem,
                                            index: sizePriceListIndex,
                                            onUpdateSize: (index, price, qty,
                                                newQty, newPrice) async {
                                              _model.updateSizesListAtIndex(
                                                index,
                                                (_) => SizeEntryStruct(
                                                  label: _model.sizesList
                                                      .elementAtOrNull(index)
                                                      ?.label,
                                                  price: price,
                                                  qty: qty,
                                                ),
                                              );
                                              safeSetState(() {});
                                            },
                                            onRemoveSize: () async {
                                              _model.removeFromSizesList(
                                                  SizeEntryStruct());
                                              safeSetState(() {});
                                            },
                                          );
                                        }).divide(SizedBox(height: 20.0)),
                                      );
                                    },
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF3E7D6A),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 14.0, 0.0, 14.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Total Quantity',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    color: Colors.white,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ),

                                          // Total Size Quantity
                                          Expanded(
                                            child: Text(
                                              functions
                                                  .totalQtyFromSizes(
                                                      _model.sizesList.toList())
                                                  .toString(),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    color: Colors.white,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 20.0)),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 4.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 14.0, 0.0, 0.0),
                                        child: Container(
                                          width: 24.0,
                                          height: 24.0,
                                          decoration: BoxDecoration(),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/paint-board.png',
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Toggle on to add colors. it would make the column containing the text field for users to input the colors, the chips reflecting the color, dropdown for selectig the size, a dropdown for selecting the quantity and the total quantity strip.
                                      Expanded(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: SwitchListTile(
                                            value: _model
                                                .switchListTileValue2 ??= false,
                                            onChanged: (newValue) async {
                                              safeSetState(() =>
                                                  _model.switchListTileValue2 =
                                                      newValue);
                                              if (newValue) {
                                                _model.isAddColorOn = true;
                                                safeSetState(() {});
                                              }
                                            },
                                            title: Text(
                                              'Add color',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelLarge
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    color: Color(0xFF131919),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    lineHeight: 1.71,
                                                  ),
                                            ),
                                            subtitle: Text(
                                              'if your product has different colours',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    color: Color(0xFF434343),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            activeThumbColor: Colors.white,
                                            activeTrackColor: Color(0xFF0C1D1F),
                                            dense: true,
                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .trailing,
                                            contentPadding: EdgeInsets.all(0.0),
                                          ),
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

                          // Only visible if the add color toggle is on.
                          if (_model.isAddColorOn == true)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 14.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 0.0, 20.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Available Colors',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'General Sans',
                                                          color:
                                                              Color(0xFF645E82),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          lineHeight: 1.5,
                                                        ),
                                              ),
                                            ),
                                            Text(
                                              'Hit enter when you input a color',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelSmall
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    color: Color(0xFF645E82),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    lineHeight: 1.5,
                                                  ),
                                            ),
                                          ],
                                        ),

                                        // Text Field for entering the Colors, once the user presses enter, it saves it and creates a chip to display it.
                                        Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller: _model
                                                .tfColorLabelTextController,
                                            focusNode:
                                                _model.tfColorLabelFocusNode,
                                            onFieldSubmitted: (_) async {
                                              _model.addToColorsList(
                                                  ColorEntryStruct(
                                                label: _model
                                                    .tfColorLabelTextController
                                                    .text,
                                                sizeLabel: '\'\'',
                                                qty: 0,
                                              ));
                                              safeSetState(() {});
                                              safeSetState(() {
                                                _model
                                                    .tfColorLabelTextController
                                                    ?.clear();
                                              });
                                            },
                                            autofocus: false,
                                            enabled: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily:
                                                            'General Sans',
                                                        letterSpacing: 0.0,
                                                      ),
                                              hintText: 'eg. Black & White',
                                              hintStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyLarge
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    color: Color(0xFFD6D6D6),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    lineHeight: 1.5,
                                                  ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFE1DFEC),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 20.0,
                                                          16.0, 20.0),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'General Sans',
                                                  color: Color(0xFF1B1A23),
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  lineHeight: 1.5,
                                                ),
                                            cursorColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            enableInteractiveSelection: true,
                                            validator: _model
                                                .tfColorLabelTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 8.0, 0.0, 0.0),
                                                child: Builder(
                                                  builder: (context) {
                                                    final colorList = _model
                                                        .colorsList
                                                        .toList();

                                                    return Wrap(
                                                      spacing: 10.0,
                                                      runSpacing: 10.0,
                                                      alignment:
                                                          WrapAlignment.start,
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .start,
                                                      direction:
                                                          Axis.horizontal,
                                                      runAlignment:
                                                          WrapAlignment.start,
                                                      verticalDirection:
                                                          VerticalDirection
                                                              .down,
                                                      clipBehavior: Clip.none,
                                                      children: List.generate(
                                                          colorList.length,
                                                          (colorListIndex) {
                                                        final colorListItem =
                                                            colorList[
                                                                colorListIndex];
                                                        return
                                                            // Color_Chip meant to show the colors.
                                                            Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        6.0,
                                                                        8.0,
                                                                        6.0,
                                                                        8.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                // Color entered in the tfColorLabel Text Field.
                                                                Text(
                                                                  colorListItem
                                                                      .label,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'General Sans',
                                                                        color: Color(
                                                                            0xFF1B1A23),
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),

                                                                // Icon that when pressed the chip would disapear and not be included in Supabase.
                                                                InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    _model.removeFromColorsList(
                                                                        colorListItem);
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .close_rounded,
                                                                    color: Color(
                                                                        0xFF1B1A23),
                                                                    size: 20.0,
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 10.0)),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ].divide(SizedBox(height: 4.0)),
                                    ),
                                  ),

                                  // Containing all the color and quantity items.
                                  Builder(
                                    builder: (context) {
                                      final colorQuantityList =
                                          _model.colorsList.toList();

                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: List.generate(
                                            colorQuantityList.length,
                                            (colorQuantityListIndex) {
                                          final colorQuantityListItem =
                                              colorQuantityList[
                                                  colorQuantityListIndex];
                                          return
                                              // Component with 2 dropdowns to select the Sizes and quantity. For example Black & White is size 40, and the quantity is 4 or something.
                                              CompColorQtyRowWidget(
                                            key: Key(
                                                'Key5l0_${colorQuantityListIndex}_of_${colorQuantityList.length}'),
                                            colorEntry: colorQuantityListItem,
                                            index: colorQuantityListIndex,
                                            sizesListParam: _model.sizesList,
                                            onUpdateColor:
                                                (updatedColor, index) async {
                                              _model.updateColorsListAtIndex(
                                                index,
                                                (_) => updatedColor,
                                              );
                                              safeSetState(() {});
                                            },
                                            onRemoveColor: () async {},
                                          );
                                        }).divide(SizedBox(height: 20.0)),
                                      );
                                    },
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF3E7D6A),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 14.0, 0.0, 14.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Total Quantity',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    color: Colors.white,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ),

                                          // Total Color Quantity
                                          Expanded(
                                            child: Text(
                                              functions
                                                  .totalQtyFromSizes(
                                                      _model.sizesList.toList())
                                                  .toString(),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'General Sans',
                                                    color: Colors.white,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 20.0)),
                              ),
                            ),
                        ].addToEnd(SizedBox(height: 140.0)),
                      ),
                    ),

                    // Button that would save all the information entered by the user to Supabase. Then navigates to the "Upload_Product_Media_Page" page.
                    Align(
                      alignment: AlignmentDirectional(1.0, 1.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                              final createProduct = ref.read(createProductProvider);
                              final createVariant = ref.read(createVariantProvider);

                              final price = functions.parseIntSafe(_model.tfPriceTextController.text).toDouble();
                              final weight = functions.kgToGrams(_model.tfWeightKgTextController.text).toDouble();
                              final stockQty = _model.ddLimitsValue == 'Limited'
                                  ? functions.parseIntSafe(_model.tfLimitedQtyTextController.text)
                                  : functions.totalQtyFromSizes(_model.sizesList.toList());
                              
                              // Create Product
                              final productResult = await createProduct(
                                storeId: widget.storeId!,
                                name: _model.tfProductNameTextController.text,
                                category: _model.selectedCategory,
                                description: _model.tfDescriptionsTextController.text,
                                isPreorder: _model.isPreorder,
                                pickupAddressId: _model.pickupAddressId,
                                price: price,
                                weightGrams: weight,
                                stockQuantity: stockQty,
                              );

                              await productResult.fold(
                                (failure) async {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Failed to create product: ${failure.message}',
                                        style: TextStyle(color: FlutterFlowTheme.of(context).primaryText),
                                      ),
                                      backgroundColor: FlutterFlowTheme.of(context).error,
                                    ),
                                  );
                                },
                                (newProduct) async {
                                  _model.createdProductId = newProduct.id;
                                  // _model.saveNewProduct = ...; // Skipped, using createdProductId
                                  safeSetState(() {});

                                  // Create Variants
                                  if ((_model.isAddColorOn == true) && (_model.colorsList.isNotEmpty)) {
                                    for (final currentLoop1Item in _model.colorsList) {
                                      await createVariant(
                                        productId: _model.createdProductId,
                                        size: currentLoop1Item.sizeLabel,
                                        color: currentLoop1Item.label,
                                        priceAmount: functions.priceForSizeLabel(
                                            currentLoop1Item.sizeLabel,
                                            _model.sizesList.toList(),
                                            int.parse(_model.tfPriceTextController.text)),
                                        quantity: currentLoop1Item.qty,
                                      );
                                    }
                                  } else {
                                    if ((_model.isAddSizesOn == true) && (_model.sizesList.isNotEmpty)) {
                                       for (final currentLoop2Item in _model.sizesList) {
                                         await createVariant(
                                          productId: _model.createdProductId,
                                          size: currentLoop2Item.label,
                                          color: '', // No color
                                          priceAmount: functions.parseIntSafe(currentLoop2Item.price.toString()),
                                          quantity: currentLoop2Item.qty,
                                         );
                                       }
                                    }
                                  }

                                  context.pushNamed(
                                    UploadProductMediaPageWidget.routeName,
                                    queryParameters: {
                                      'productId': serializeParam(
                                        _model.createdProductId,
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );
                                  
                                  safeSetState(() {});
                                },
                              );
                          },
                          text: 'Next',
                          options: FFButtonOptions(
                            height: 72.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                32.0, 24.0, 32.0, 24.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
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
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
