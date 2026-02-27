import '/backend/supabase/supabase.dart';
import '/components/add_pickup_address_bottom_sheet/add_pickup_address_bottom_sheet_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'select_address_bottom_sheet_model.dart';
export 'select_address_bottom_sheet_model.dart';

/// Bottom sheet for selecting the address they want from the list of
/// addresses already added.
class SelectAddressBottomSheetWidget extends StatefulWidget {
  const SelectAddressBottomSheetWidget({
    super.key,
    required this.storeId,
  });

  final String? storeId;

  @override
  State<SelectAddressBottomSheetWidget> createState() =>
      _SelectAddressBottomSheetWidgetState();
}

class _SelectAddressBottomSheetWidgetState
    extends State<SelectAddressBottomSheetWidget> {
  late SelectAddressBottomSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectAddressBottomSheetModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF2F1EC),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: 47.0,
                          child: Divider(
                            height: 2.0,
                            thickness: 2.0,
                            color: Color(0xFFCDCFCB),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 12.0),
                  child: Text(
                    'Select address',
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          fontFamily: 'General Sans',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                Divider(
                  height: 1.0,
                  thickness: 1.0,
                  color: Color(0x290C1D1F),
                ),
              ].divide(SizedBox(height: 12.0)),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 280.0,
                decoration: BoxDecoration(),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: FutureBuilder<List<PickupAddressesRow>>(
                    future: PickupAddressesTable().queryRows(
                      queryFn: (q) => q
                          .eqOrNull(
                            'store_id',
                            widget.storeId,
                          )
                          .order('is_default')
                          .order('created_at'),
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
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
                      List<PickupAddressesRow> listViewPickupAddressesRowList =
                          snapshot.data!;

                      return ListView.separated(
                        padding: EdgeInsets.fromLTRB(
                          0,
                          0,
                          0,
                          20.0,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listViewPickupAddressesRowList.length,
                        separatorBuilder: (_, __) => SizedBox(height: 20.0),
                        itemBuilder: (context, listViewIndex) {
                          final listViewPickupAddressesRow =
                              listViewPickupAddressesRowList[listViewIndex];
                          return
                              // Address container.
                              Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 20.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                Navigator.pop(
                                    context, listViewPickupAddressesRow);
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: Color(0x32C3CBD9),
                                      offset: Offset(
                                        0.0,
                                        2.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color: Color(0xFFE1DFEC),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      // Address.
                                      Text(
                                        '${listViewPickupAddressesRow.addressLine1}, ${listViewPickupAddressesRow.state}, ${listViewPickupAddressesRow.city}, ${listViewPickupAddressesRow.country}',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'General Sans',
                                              color: Color(0xFF1B1A23),
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),

              // Add address button, that would activate the "Add_Pickup_Address_Bottom_Sheet" bottom sheet
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    final newAddress = await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Color(0x51000000),
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: AddPickupAddressBottomSheetWidget(
                            storeId: widget.storeId!,
                          ),
                        );
                      },
                    );

                    if (newAddress != null) {
                      _model.addPickupAddress = newAddress;
                      Navigator.pop(context, _model.addPickupAddress);
                    }

                    safeSetState(() {});
                  },
                  text: 'Add pickup address',
                  icon: Icon(
                    Icons.data_saver_on,
                    size: 24.0,
                  ),
                  options: FFButtonOptions(
                    height: 72.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconAlignment: IconAlignment.start,
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconColor: Color(0xFF2E2625),
                    color: Colors.white,
                    textStyle: FlutterFlowTheme.of(context).labelSmall.override(
                          fontFamily: 'General Sans',
                          color: Color(0xFF2E2625),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: Color(0xFF2E2625),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
              ),
            ].divide(SizedBox(height: 14.0)),
          ),
        ),
      ],
    );
  }
}
