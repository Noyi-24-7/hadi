import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'comp_size_qty_row_model.dart';
export 'comp_size_qty_row_model.dart';

/// Size and Quantity component that allows users to enter the prices and the
/// corresponding quantity.
class CompSizeQtyRowWidget extends StatefulWidget {
  const CompSizeQtyRowWidget({
    super.key,
    this.sizeEntry,
    this.index,
    required this.onUpdateSize,
    this.onRemoveSize,
  });

  final SizeEntryStruct? sizeEntry;
  final int? index;
  final Future Function(
          int index, double price, int qty, int newQty, double newPrice)?
      onUpdateSize;
  final Future Function()? onRemoveSize;

  @override
  State<CompSizeQtyRowWidget> createState() => _CompSizeQtyRowWidgetState();
}

class _CompSizeQtyRowWidgetState extends State<CompSizeQtyRowWidget> {
  late CompSizeQtyRowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CompSizeQtyRowModel());

    _model.tfCompPriceTextController ??=
        TextEditingController(text: widget.sizeEntry?.price.toString());
    _model.tfCompPriceFocusNode ??= FocusNode();

    _model.tfCompQuantityTextController ??=
        TextEditingController(text: widget.sizeEntry?.qty.toString());
    _model.tfCompQuantityFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Size ',
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'General Sans',
                            color: Color(0xFF645E82),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                            lineHeight: 1.5,
                          ),
                    ),
                    Text(
                      valueOrDefault<String>(
                        widget.sizeEntry?.label,
                        '0',
                      ),
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'General Sans',
                            color: Color(0xFF645E82),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            lineHeight: 1.5,
                          ),
                    ),
                    Text(
                      ' Price',
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'General Sans',
                            color: Color(0xFF645E82),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                            lineHeight: 1.5,
                          ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Container(
                        width: 165.0,
                        child: TextFormField(
                          controller: _model.tfCompPriceTextController,
                          focusNode: _model.tfCompPriceFocusNode,
                          onFieldSubmitted: (_) async {
                            await widget.onUpdateSize?.call(
                              widget.index!,
                              double.parse(
                                  _model.tfCompPriceTextController.text),
                              int.parse(
                                  _model.tfCompQuantityTextController.text),
                              int.parse(
                                  _model.tfCompQuantityTextController.text),
                              double.parse(
                                  _model.tfCompPriceTextController.text),
                            );
                          },
                          autofocus: false,
                          enabled: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'General Sans',
                                  letterSpacing: 0.0,
                                ),
                            hintText: 'eg. 70,000',
                            hintStyle:
                                FlutterFlowTheme.of(context).bodyLarge.override(
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
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 20.0, 16.0, 20.0),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyLarge.override(
                                    fontFamily: 'General Sans',
                                    color: Color(0xFF1B1A23),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    lineHeight: 1.5,
                                  ),
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          enableInteractiveSelection: true,
                          validator: _model.tfCompPriceTextControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(width: 5.0)),
                ),
              ].divide(SizedBox(height: 4.0)),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quantity Avalliable',
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily: 'General Sans',
                        color: Color(0xFF645E82),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                        lineHeight: 1.5,
                      ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Container(
                        width: 165.0,
                        child: TextFormField(
                          controller: _model.tfCompQuantityTextController,
                          focusNode: _model.tfCompQuantityFocusNode,
                          onFieldSubmitted: (_) async {
                            await widget.onUpdateSize?.call(
                              widget.index!,
                              double.parse(
                                  _model.tfCompPriceTextController.text),
                              int.parse(
                                  _model.tfCompQuantityTextController.text),
                              int.parse(
                                  _model.tfCompQuantityTextController.text),
                              double.parse(
                                  _model.tfCompPriceTextController.text),
                            );
                          },
                          autofocus: false,
                          enabled: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'General Sans',
                                  letterSpacing: 0.0,
                                ),
                            hintText: 'eg. 3',
                            hintStyle:
                                FlutterFlowTheme.of(context).bodyLarge.override(
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
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 20.0, 16.0, 20.0),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyLarge.override(
                                    fontFamily: 'General Sans',
                                    color: Color(0xFF1B1A23),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    lineHeight: 1.5,
                                  ),
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          enableInteractiveSelection: true,
                          validator: _model
                              .tfCompQuantityTextControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(width: 5.0)),
                ),
              ].divide(SizedBox(height: 4.0)),
            ),
          ),
        ),
      ].divide(SizedBox(width: 20.0)),
    );
  }
}
