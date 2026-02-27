import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/core/storage/storage_providers.dart';
import '/features/products/presentation/providers/product_providers.dart';
import '/features/products/domain/entities/product_media.dart';
import 'package:hadi/backend/supabase/database/tables/product_media.dart' as table_media;
import 'upload_product_media_page_model.dart';
export 'upload_product_media_page_model.dart';

/// Page where the user can upload their product media, either videos or
/// images.
class UploadProductMediaPageWidget extends ConsumerStatefulWidget {
  const UploadProductMediaPageWidget({
    super.key,
    required this.productId,
  });

  final String? productId;

  static String routeName = 'Upload_Product_Media_Page';
  static String routePath = '/uploadProductMediaPage';

  @override
  ConsumerState<UploadProductMediaPageWidget> createState() =>
      _UploadProductMediaPageWidgetState();
}

class _UploadProductMediaPageWidgetState
    extends ConsumerState<UploadProductMediaPageWidget> {
  late UploadProductMediaPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UploadProductMediaPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _fetchMedia();
    });
  }

  Future<void> _fetchMedia() async {
    if (widget.productId == null) return;
    try {
      final mediaList = await ref.read(productMediaProvider(widget.productId!).future);
      // Map entity back to Row if Model expects Row, or assume Model can handle Entity?
      // Model currently expects ProductMediaRow. Ideally we refactor Model to use Entity.
      // For now, we manually map Entity to Row to match Model expectation (or mock Row-like behavior).
      // But we can't instantiate Row easily without constructor? We verified checking product_media.dart
      // ProductMediaRow takes a Map.
      _model.mediaList = mediaList.map((e) => table_media.ProductMediaDbRow({
         'id': e.id,
         'product_id': e.productId,
         'storage_path': e.storagePath,
         'public_url': e.publicUrl,
         'file_name': e.fileName,
         'file_size': e.fileSize,
         'sort_order': e.sortOrder,
         'is_video': e.isVideo,
         'created_at': e.createdAt?.toIso8601String(),
      })).toList();
      safeSetState(() {});
    } catch (e) {
      // Handle error
      print('Error fetching media: $e');
    }
  }


  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                          'Upload Product Media',
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
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Add up to 5 high quality product images, GIFs and videos to make your products appealing to customers',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'General Sans',
                                  color: Color(0xFF6D6B76),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  lineHeight: 1.7142857143,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF9F9F9),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Builder(
                            builder: (context) {
                              final pendingFile = _model.pendingMedia.toList();

                              return ListView.separated(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: pendingFile.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 16.0),
                                itemBuilder: (context, pendingFileIndex) {
                                  final pendingFileItem =
                                      pendingFile[pendingFileIndex];
                                  return
                                      // Media Item Row with the name and size and delete button.
                                      Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  // Tool that can be used to rearrange the position of this item, so you can drag it above or below the other items.
                                                  Container(
                                                    width: 16.0,
                                                    height: 16.0,
                                                    decoration: BoxDecoration(),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                      child: Image.asset(
                                                        'assets/images/drag-drop-vertical.png',
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),

                                                  // Conditional to show either a video or image depending on what's been uploaded.
                                                  Builder(
                                                    builder: (context) {
                                                      if (pendingFileItem
                                                          .isVideo) {
                                                        return
                                                            // Video Player widget.
                                                            FlutterFlowVideoPlayer(
                                                          path: functions
                                                              .urlToVideoPath(
                                                                  pendingFileItem
                                                                      .url),
                                                          videoType:
                                                              VideoType.network,
                                                          width: 61.0,
                                                          height: 67.0,
                                                          autoPlay: false,
                                                          looping: true,
                                                          showControls: false,
                                                          allowFullScreen: true,
                                                          allowPlaybackSpeedMenu:
                                                              false,
                                                        );
                                                      } else {
                                                        return
                                                            // Image Container widget.
                                                            ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.network(
                                                            functions
                                                                .urlToImagePath(
                                                                    pendingFileItem
                                                                        .url),
                                                            width: 61.0,
                                                            height: 67.0,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ].divide(SizedBox(width: 8.0)),
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // The image name of the product uploaded.
                                                  Text(
                                                    pendingFileItem.fileName,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'General Sans',
                                                          color:
                                                              Color(0xFF1B1A23),
                                                          letterSpacing: 0.0,
                                                          lineHeight: 0.88,
                                                        ),
                                                  ),

                                                  // Text to show the media uploaded's size.
                                                  Text(
                                                    functions.formatBytes(
                                                        pendingFileItem.bytes),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'General Sans',
                                                          color:
                                                              Color(0xFF645E82),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(height: 5.0)),
                                              ),
                                            ].divide(SizedBox(width: 8.0)),
                                          ),
                                        ),

                                        // Delete icon button. When pressed the user would be able to delete the uploaded media.
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            await deleteSupabaseFileFromPublicUrl(
                                                pendingFileItem.url);
                                            _model.removeFromPendingMedia(
                                                pendingFileItem);
                                            safeSetState(() {});
                                          },
                                          child: FaIcon(
                                            FontAwesomeIcons.trashAlt,
                                            color: Color(0x782E2625),
                                            size: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),

                          // Button to add product media.
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                50.0, 0.0, 50.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                if (_model.mediaList.length >= 5) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Max 5 media files',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: 'General Sans',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                    ),
                                  );
                                } else {
                                  final selectedMedia =
                                      await selectMediaWithSourceBottomSheet(
                                    context: context,
                                    storageFolderPath:
                                        'products/${widget.productId}/',
                                    allowPhoto: true,
                                    allowVideo: true,
                                    textColor:
                                        FlutterFlowTheme.of(context).primary,
                                    pickerFontFamily: 'General Sans',
                                  );
                                  if (selectedMedia != null &&
                                      selectedMedia.every((m) =>
                                          validateFileFormat(
                                              m.storagePath, context))) {
                                    safeSetState(() => _model
                                        .isDataUploading_pickedMedia = true);
                                    var selectedUploadedFiles =
                                        <FFUploadedFile>[];

                                    var downloadUrls = <String>[];
                                    try {
                                      selectedUploadedFiles = selectedMedia
                                          .map((m) => FFUploadedFile(
                                                name: m.storagePath
                                                    .split('/')
                                                    .last,
                                                bytes: m.bytes,
                                                height: m.dimensions?.height,
                                                width: m.dimensions?.width,
                                                blurHash: m.blurHash,
                                                originalFilename:
                                                    m.originalFilename,
                                              ))
                                          .toList();

                                      downloadUrls = [];
                                      final uploadFile = ref.read(uploadFileProvider);
                                      for (final m in selectedMedia) {
                                         // Generate path
                                         final path = 'products/${widget.productId}/${m.storagePath.split('/').last}';
                                         final result = await uploadFile(
                                           bucketName: 'product-images',
                                           path: path,
                                           bytes: m.bytes, 
                                         );
                                         result.fold(
                                           (l) => print('Upload failed: $l'),
                                           (url) => downloadUrls.add(url),
                                         );
                                      }
                                    } finally {
                                      _model.isDataUploading_pickedMedia =
                                          false;
                                    }
                                    if (selectedUploadedFiles.length ==
                                            selectedMedia.length &&
                                        downloadUrls.length ==
                                            selectedMedia.length) {
                                      safeSetState(() {
                                        _model.uploadedLocalFile_pickedMedia =
                                            selectedUploadedFiles.first;
                                        _model.uploadedFileUrl_pickedMedia =
                                            downloadUrls.first;
                                      });
                                    } else {
                                      safeSetState(() {});
                                      return;
                                    }
                                  }

                                  _model.getSize =
                                      await actions.getRemoteFileSizeBytes(
                                    _model.uploadedFileUrl_pickedMedia,
                                  );
                                  _model.addToPendingMedia(
                                      ProductMediaEntryStructStruct(
                                    url: _model.uploadedFileUrl_pickedMedia,
                                    fileName: functions.getFileNameFromUrl(
                                        _model.uploadedFileUrl_pickedMedia),
                                    isVideo: functions.isVideoUrl(
                                        _model.uploadedFileUrl_pickedMedia),
                                    bytes: _model.getSize,
                                    storagePath: functions.buildStoragePath(
                                        widget.productId!,
                                        functions.getFileNameFromUrl(_model
                                            .uploadedFileUrl_pickedMedia)),
                                  ));
                                  safeSetState(() {});
                                }

                                safeSetState(() {});
                              },
                              text: 'Add More',
                              icon: Icon(
                                Icons.data_saver_on,
                                size: 16.0,
                              ),
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 44.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconColor: FlutterFlowTheme.of(context).primary,
                                color: Colors.white,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'General Sans',
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      fontSize: 13.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color: Color(0xFFB8A7A6),
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ]
                            .divide(SizedBox(height: 16.0))
                            .addToStart(SizedBox(height: 16.0))
                            .addToEnd(SizedBox(height: 16.0)),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Button to navigate back.
                      FFButtonWidget(
                        onPressed: () async {
                          context.safePop();
                        },
                        text: 'Back',
                        options: FFButtonOptions(
                          height: 72.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              32.0, 24.0, 32.0, 24.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Colors.white,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'General Sans',
                                    color: FlutterFlowTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),

                      // Button that saves all the uploads to Supabase and navigates back to the "Home_Main" page.
                      FFButtonWidget(
                        onPressed: () async {
                          if (_model.pendingMedia.length == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Add at least 1 media',
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'General Sans',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                            );
                          } else {
                              final addMedia = ref.read(addProductMediaProvider);
                              for (int loop1Index = 0;
                                  loop1Index < _model.pendingMedia.length;
                                  loop1Index++) {
                                final currentLoop1Item =
                                    _model.pendingMedia[loop1Index];
                                
                                await addMedia(
                                  productId: widget.productId!,
                                  storagePath: currentLoop1Item.storagePath,
                                  publicUrl: currentLoop1Item.url,
                                  fileName: currentLoop1Item.fileName,
                                  fileSize: currentLoop1Item.bytes,
                                  sortOrder: loop1Index,
                                  isVideo: currentLoop1Item.isVideo,
                                );
                              }

                            context.pushNamed(HomeMainWidget.routeName);
                          }
                        },
                        text: 'Next',
                        options: FFButtonOptions(
                          height: 72.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              32.0, 24.0, 32.0, 24.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
