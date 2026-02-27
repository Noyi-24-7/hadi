import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'edit_product_model.dart';
export 'edit_product_model.dart';

/// Confirmation bottom sheet that's meant to confirm if the user actually
/// wants to edit the prodcut.
class EditProductWidget extends StatefulWidget {
  const EditProductWidget({super.key});

  @override
  State<EditProductWidget> createState() => _EditProductWidgetState();
}

class _EditProductWidgetState extends State<EditProductWidget> {
  late EditProductModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditProductModel());
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
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          'Edit product',
                          style:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    fontFamily: 'General Sans',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),

                      // Close button.
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/cancel-circle.png',
                          width: 24.0,
                          height: 24.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    child: Text(
                      'Are you sure you want to edit this product?',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'General Sans',
                            color: Color(0xFF353535),
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Once this is clicked the user can only edit the product price.
                      Container(
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 20.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/Tag.png',
                                        width: 24.0,
                                        height: 24.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Edit product price',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'General Sans',
                                              color: Color(0xFF0C1D1F),
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right_sharp,
                                      color: Color(0x93BDB9AA),
                                      size: 24.0,
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

                      // Once this is clicked the user can edit the full product details.
                      Container(
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 20.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/Shopping_Bag.png',
                                        width: 24.0,
                                        height: 24.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Edit full product',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'General Sans',
                                              color: Color(0xFF0C1D1F),
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right_sharp,
                                      color: Color(0x93BDB9AA),
                                      size: 24.0,
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
              ].divide(SizedBox(height: 10.0)),
            ),
          ),
        ),
      ],
    );
  }
}
