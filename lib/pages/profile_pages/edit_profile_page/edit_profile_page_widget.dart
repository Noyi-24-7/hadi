import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universal_io/io.dart';

import '/features/auth/domain/entities/profile.dart';
import '/features/auth/presentation/providers/auth_providers.dart';
import '/features/storefront/domain/entities/store_entity.dart';
import '/features/storefront/presentation/providers/storefront_providers.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'edit_profile_page_model.dart';

export 'edit_profile_page_model.dart';

/// Page that allows the users to edit their profile's information.
class EditProfilePageWidget extends ConsumerStatefulWidget {
  const EditProfilePageWidget({super.key});

  static String routeName = 'Edit_Profile_Page';
  static String routePath = '/editProfilePage';

  @override
  ConsumerState<EditProfilePageWidget> createState() =>
      _EditProfilePageWidgetState();
}

class _EditProfilePageWidgetState extends ConsumerState<EditProfilePageWidget> {
  late EditProfilePageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  File? _selectedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditProfilePageModel());

    _model.tfFirstNameFocusNode ??= FocusNode();
    _model.tfLastNameFocusNode ??= FocusNode();
    _model.tfBusinessNameFocusNode ??= FocusNode();
    _model.tfRCNumberFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use the new Clean Architecture providers
    final storeAsync = ref.watch(myStoreProvider);
    final profileAsync = ref.watch(currentProfileProvider);

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
              storeAsync.when(
                data: (store) {
                  if (store == null) return _buildError(context, 'Store not found');
                  
                  return profileAsync.when(
                    data: (profile) {
                      if (profile == null) return _buildError(context, 'Profile not found');
                      return _buildContent(context, store, profile);
                    },
                    loading: () => _buildLoading(context),
                    error: (error, stack) => _buildError(context, error),
                  );
                },
                loading: () => _buildLoading(context),
                error: (error, stack) => _buildError(context, error),
              ),
              if (_isLoading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
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

  Widget _buildContent(BuildContext context, StoreEntity store, Profile profile) {
    // Initialize text controllers with profile data if not already set
    if (_model.tfFirstNameTextController == null || _model.tfFirstNameTextController!.text.isEmpty) {
        _model.tfFirstNameTextController ??= TextEditingController();
        _model.tfFirstNameTextController!.text = profile.firstName ?? '';
    }
    if (_model.tfLastNameTextController == null || _model.tfLastNameTextController!.text.isEmpty) {
        _model.tfLastNameTextController ??= TextEditingController();
        _model.tfLastNameTextController!.text = profile.lastName ?? '';
    }
    if (_model.tfBusinessNameTextController == null || _model.tfBusinessNameTextController!.text.isEmpty) {
        _model.tfBusinessNameTextController ??= TextEditingController();
        _model.tfBusinessNameTextController!.text = store.name;
    }
    if (_model.tfRCNumberTextController == null || _model.tfRCNumberTextController!.text.isEmpty) {
        _model.tfRCNumberTextController ??= TextEditingController();
        _model.tfRCNumberTextController!.text = store.rcNumber ?? '';
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(context),
          _buildProfileImageSection(context, profile),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 80.0),
            child: Column(
              children: [
                _buildFirstNameField(context),
                _buildLastNameField(context),
                _buildBusinessNameField(context),
                _buildRCNumberField(context),
                const SizedBox(height: 32.0),
                _buildSaveButton(context, store, profile),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                lineHeight: 1.33,
                              ),
                        ),
                      ].divide(const SizedBox(width: 8.0)),
                    ),
                  ),
                ),
                Text(
                  'Edit Profile',
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'General Sans',
                        letterSpacing: 0.0,
                        lineHeight: 1.33,
                      ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
          const Divider(height: 1.0, thickness: 1.0, color: Color(0xFFEAEDED)),
        ],
      ),
    );
  }

  Widget _buildProfileImageSection(BuildContext context, Profile profile) {
    // Logic: 
    // 1. If _selectedImage is set, show it (file).
    // 2. Else if profile has URL, show it (network).
    // 3. Else show placeholder.
    
    ImageProvider? imageProvider;
    if (_selectedImage != null) {
      imageProvider = FileImage(_selectedImage!);
    } else if (profile.profileImageUrl != null && profile.profileImageUrl!.isNotEmpty) {
      imageProvider = NetworkImage(profile.profileImageUrl!);
    }

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 4.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(25.0, 30.0, 25.0, 30.0),
          child: Column(
            children: [
               GestureDetector(
                onTap: _pickImage,
                 child: Stack(
                   alignment: Alignment.bottomRight,
                   children: [
                     ClipRRect(
                       borderRadius: BorderRadius.circular(12.0),
                       child: Container(
                         width: double.infinity,
                         height: 200.0,
                         color: Colors.grey[200],
                         child: imageProvider != null 
                            ? Image(image: imageProvider, fit: BoxFit.cover)
                            : const Icon(Icons.person, size: 80, color: Colors.grey),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: CircleAvatar(
                         backgroundColor: Colors.white,
                         child: Icon(Icons.camera_alt, color: FlutterFlowTheme.of(context).primary),
                       ),
                     ),
                   ],
                 ),
               ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(36.0),
                    border: Border.all(color: Colors.grey[300]!)
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Upload profile picture',
                          style: FlutterFlowTheme.of(context).labelLarge.override(
                                fontFamily: 'General Sans',
                                color: const Color(0xFF434343),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        const FaIcon(
                          FontAwesomeIcons.images,
                          color: Color(0xFF434343),
                          size: 20.0,
                        ),
                      ].divide(const SizedBox(width: 10.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'tap to select an image from your device',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'General Sans',
                      letterSpacing: 0.0,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirstNameField(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'First name',
            style: FlutterFlowTheme.of(context).labelMedium.override(
                  fontFamily: 'General Sans',
                  color: const Color(0xFF645E82),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  lineHeight: 1.5,
                ),
          ),
          const SizedBox(height: 4.0),
          TextFormField(
            controller: _model.tfFirstNameTextController,
            focusNode: _model.tfFirstNameFocusNode,
            decoration: InputDecoration(
              isDense: true,
              hintText: 'eg. Hadi',
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
      ),
    );
  }

  Widget _buildLastNameField(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Last name',
            style: FlutterFlowTheme.of(context).labelMedium.override(
                  fontFamily: 'General Sans',
                  color: const Color(0xFF645E82),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  lineHeight: 1.5,
                ),
          ),
          const SizedBox(height: 4.0),
          TextFormField(
            controller: _model.tfLastNameTextController,
            focusNode: _model.tfLastNameFocusNode,
            decoration: InputDecoration(
              isDense: true,
              hintText: 'eg. Smith',
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
      ),
    );
  }

  Widget _buildBusinessNameField(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Business name',
            style: FlutterFlowTheme.of(context).labelMedium.override(
                  fontFamily: 'General Sans',
                  color: const Color(0xFF645E82),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  lineHeight: 1.5,
                ),
          ),
          const SizedBox(height: 4.0),
          TextFormField(
            controller: _model.tfBusinessNameTextController,
            focusNode: _model.tfBusinessNameFocusNode,
            decoration: InputDecoration(
              isDense: true,
              hintText: 'eg. Hadi Store',
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
      ),
    );
  }

  Widget _buildRCNumberField(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RC Number',
            style: FlutterFlowTheme.of(context).labelMedium.override(
                  fontFamily: 'General Sans',
                  color: const Color(0xFF645E82),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  lineHeight: 1.5,
                ),
          ),
          const SizedBox(height: 4.0),
          TextFormField(
            controller: _model.tfRCNumberTextController,
            focusNode: _model.tfRCNumberFocusNode,
            decoration: InputDecoration(
              isDense: true,
              hintText: 'eg. RC123456',
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
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context, StoreEntity store, Profile profile) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
      child: FFButtonWidget(
        onPressed: () async {
          setState(() { _isLoading = true; });
          try {
             String? newImageUrl;
             
             // 1. Upload Image if selected
             if (_selectedImage != null) {
                final uploadResult = await ref.read(uploadProfileImageUseCaseProvider).call(_selectedImage!);
                newImageUrl = uploadResult.fold(
                   (l) => throw Exception(l.message),
                   (url) => url,
                );
             }
             
             // 2. Update Profile
             final updateProfile = ref.read(updateProfileUseCaseProvider);
             final profileResult = await updateProfile(
                 firstName: _model.tfFirstNameTextController.text,
                 lastName: _model.tfLastNameTextController.text,
                 profileImageUrl: newImageUrl, // Pass new URL if uploaded
             );
             
             profileResult.fold(
                 (l) => throw Exception(l.message),
                 (r) => null,
             );
             
             // 3. Update Store
             final updateStore = ref.read(updateStoreUseCaseProvider);
             // We need to create updated StoreEntity
             // Since StoreEntity is immutable, we use current 'store' and copyWith ideally, 
             // but StoreEntity might not have copyWith generated.
             // We'll construct a new one.
             final updatedStore = StoreEntity(
                 id: store.id,
                 name: _model.tfBusinessNameTextController.text,
                 slug: store.slug, // Don't change slug for now
                 description: store.description,
                 bannerUrl: store.bannerUrl,
                 logoUrl: store.logoUrl,
                 rcNumber: _model.tfRCNumberTextController.text,
                 isActive: store.isActive
             );
             
             final storeResult = await updateStore(updatedStore);
             storeResult.fold(
                 (l) => throw Exception(l.message),
                 (r) => null,
             );
             
             // 4. Refresh Providers
             ref.invalidate(currentProfileProvider);
             ref.invalidate(myStoreProvider);
             
             if (context.mounted) {
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                     content: Text(
                       'Profile updated successfully',
                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                             fontFamily: 'General Sans',
                             color: FlutterFlowTheme.of(context).primaryText,
                             letterSpacing: 0.0,
                           ),
                     ),
                     duration: const Duration(milliseconds: 4000),
                     backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                   ),
                 );
                 context.safePop();
             }

          } catch (e) {
             if (context.mounted) {
                 ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
                 );
             }
          } finally {
             if (mounted) setState(() { _isLoading = false; });
          }
        },
        text: 'Save Changes',
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
      ),
    );
  }
}
