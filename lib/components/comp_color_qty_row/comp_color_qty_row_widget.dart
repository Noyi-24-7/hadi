import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'comp_color_qty_row_model.dart';
export 'comp_color_qty_row_model.dart';

/// Colour and Quantity component that allows users to select the sizes for
/// which the colors match and the corresponding quantity.
class CompColorQtyRowWidget extends StatefulWidget {
  const CompColorQtyRowWidget({
    super.key,
    required this.colorEntry,
    this.index,
    required this.onUpdateColor,
    this.onRemoveColor,
    required this.sizesListParam,
  });

  final ColorEntryStruct? colorEntry;
  final int? index;
  final Future Function(ColorEntryStruct updatedColor, int index)?
      onUpdateColor;
  final Future Function()? onRemoveColor;
  final List<SizeEntryStruct>? sizesListParam;

  @override
  State<CompColorQtyRowWidget> createState() => _CompColorQtyRowWidgetState();
}

class _CompColorQtyRowWidgetState extends State<CompColorQtyRowWidget> {
  late CompColorQtyRowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CompColorQtyRowModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.selectedSizeLabel = widget.colorEntry?.sizeLabel;
      _model.selectedQtyStr = widget.colorEntry?.qty.toString();
      safeSetState(() {});
    });
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
                      valueOrDefault<String>(
                        widget.colorEntry?.label,
                        'Black',
                      ),
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
                      child: FlutterFlowDropDown<String>(
                        controller: _model.ddColorSizeValueController ??=
                            FormFieldController<String>(
                          _model.ddColorSizeValue ??=
                              widget.colorEntry?.sizeLabel,
                        ),
                        options: widget.sizesListParam!
                            .map((e) => e.label)
                            .toList(),
                        onChanged: (val) async {
                          safeSetState(() => _model.ddColorSizeValue = val);
                          _model.selectedSizeLabel = _model.ddColorSizeValue;
                          _model.selectedQtyStr = '\'\'';
                          safeSetState(() {});
                          await widget.onUpdateColor?.call(
                            ColorEntryStruct(
                              label: widget.colorEntry?.label,
                              sizeLabel: _model.selectedSizeLabel,
                              qty: 0,
                            ),
                            widget.index!,
                          );
                        },
                        width: 200.0,
                        height: 53.0,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'General Sans',
                                  color: Color(0xFF1B1A23),
                                  letterSpacing: 0.0,
                                ),
                        hintText: 'Select...',
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xFF1B1A23),
                          size: 24.0,
                        ),
                        fillColor: Colors.white,
                        elevation: 2.0,
                        borderColor: Color(0xFFE1DFEC),
                        borderWidth: 1.0,
                        borderRadius: 8.0,
                        margin: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        hidesUnderline: true,
                        isOverButton: false,
                        isSearchable: false,
                        isMultiSelect: false,
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
                      child: FlutterFlowDropDown<String>(
                        controller: _model.ddColorQtyValueController ??=
                            FormFieldController<String>(
                          _model.ddColorQtyValue ??=
                              widget.colorEntry?.qty.toString(),
                        ),
                        options: functions.qtyOptionsForSizeLabel(
                            _model.selectedSizeLabel,
                            widget.sizesListParam?.toList()),
                        onChanged: (val) async {
                          safeSetState(() => _model.ddColorQtyValue = val);
                          _model.selectedQtyStr = _model.ddColorQtyValue;
                          safeSetState(() {});
                          await widget.onUpdateColor?.call(
                            ColorEntryStruct(
                              label: widget.colorEntry?.label,
                              sizeLabel: _model.ddColorSizeValue,
                              qty:
                                  functions.parseIntSafe(_model.selectedQtyStr),
                            ),
                            widget.index!,
                          );
                        },
                        width: 200.0,
                        height: 53.0,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'General Sans',
                                  color: Color(0xFF1B1A23),
                                  letterSpacing: 0.0,
                                ),
                        hintText: 'Select...',
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xFF1B1A23),
                          size: 24.0,
                        ),
                        fillColor: Colors.white,
                        elevation: 2.0,
                        borderColor: Color(0xFFE1DFEC),
                        borderWidth: 1.0,
                        borderRadius: 8.0,
                        margin: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        hidesUnderline: true,
                        isOverButton: false,
                        isSearchable: false,
                        isMultiSelect: false,
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
