import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'add_a_new_product_page_widget.dart' show AddANewProductPageWidget;
import 'package:flutter/material.dart';

class AddANewProductPageModel
    extends FlutterFlowModel<AddANewProductPageWidget> {
  ///  Local state fields for this page.

  bool isPreorder = false;

  bool isAddSizesOn = false;

  bool isAddColorOn = false;

  List<SizeEntryStruct> sizesList = [];
  void addToSizesList(SizeEntryStruct item) => sizesList.add(item);
  void removeFromSizesList(SizeEntryStruct item) => sizesList.remove(item);
  void removeAtIndexFromSizesList(int index) => sizesList.removeAt(index);
  void insertAtIndexInSizesList(int index, SizeEntryStruct item) =>
      sizesList.insert(index, item);
  void updateSizesListAtIndex(int index, Function(SizeEntryStruct) updateFn) =>
      sizesList[index] = updateFn(sizesList[index]);

  List<ColorEntryStruct> colorsList = [];
  void addToColorsList(ColorEntryStruct item) => colorsList.add(item);
  void removeFromColorsList(ColorEntryStruct item) => colorsList.remove(item);
  void removeAtIndexFromColorsList(int index) => colorsList.removeAt(index);
  void insertAtIndexInColorsList(int index, ColorEntryStruct item) =>
      colorsList.insert(index, item);
  void updateColorsListAtIndex(
          int index, Function(ColorEntryStruct) updateFn) =>
      colorsList[index] = updateFn(colorsList[index]);

  int totalQty = 0;

  String qtyType = 'Unlimited';

  int? limitedQty;

  int? selectedSizeMaxQty;

  int tempOldQty = 0;

  String? selectedCategory;

  String? pickupAddressId;

  String? pickupAddressLabel;

  String createdProductId = '\'\'';

  ///  State fields for stateful widgets in this page.

  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // State field(s) for tfProductName widget.
  FocusNode? tfProductNameFocusNode;
  TextEditingController? tfProductNameTextController;
  String? Function(BuildContext, String?)? tfProductNameTextControllerValidator;
  // State field(s) for tfcategory widget.
  String? tfcategoryValue;
  FormFieldController<String>? tfcategoryValueController;
  // State field(s) for tfDescriptions widget.
  FocusNode? tfDescriptionsFocusNode;
  TextEditingController? tfDescriptionsTextController;
  String? Function(BuildContext, String?)?
      tfDescriptionsTextControllerValidator;
  // State field(s) for tfWeightKg widget.
  FocusNode? tfWeightKgFocusNode;
  TextEditingController? tfWeightKgTextController;
  String? Function(BuildContext, String?)? tfWeightKgTextControllerValidator;
  // State field(s) for tfPrice widget.
  FocusNode? tfPriceFocusNode;
  TextEditingController? tfPriceTextController;
  String? Function(BuildContext, String?)? tfPriceTextControllerValidator;
  // State field(s) for ddLimits widget.
  String? ddLimitsValue;
  FormFieldController<String>? ddLimitsValueController;
  // State field(s) for tfLimitedQty widget.
  FocusNode? tfLimitedQtyFocusNode;
  TextEditingController? tfLimitedQtyTextController;
  String? Function(BuildContext, String?)? tfLimitedQtyTextControllerValidator;
  // Stores action output result for [Bottom Sheet - Select_Address_Bottom_Sheet] action in Container widget.
  PickupAddressesRow? selectPickupAddress;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue1;
  // State field(s) for tfSizeLabel widget.
  FocusNode? tfSizeLabelFocusNode;
  TextEditingController? tfSizeLabelTextController;
  String? Function(BuildContext, String?)? tfSizeLabelTextControllerValidator;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue2;
  // State field(s) for tfColorLabel widget.
  FocusNode? tfColorLabelFocusNode;
  TextEditingController? tfColorLabelTextController;
  String? Function(BuildContext, String?)? tfColorLabelTextControllerValidator;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  ProductsRow? saveNewProduct;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  ProductVariantsRow? productVariantsColors;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  ProductVariantsRow? productVariantsSizes;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tfProductNameFocusNode?.dispose();
    tfProductNameTextController?.dispose();

    tfDescriptionsFocusNode?.dispose();
    tfDescriptionsTextController?.dispose();

    tfWeightKgFocusNode?.dispose();
    tfWeightKgTextController?.dispose();

    tfPriceFocusNode?.dispose();
    tfPriceTextController?.dispose();

    tfLimitedQtyFocusNode?.dispose();
    tfLimitedQtyTextController?.dispose();

    tfSizeLabelFocusNode?.dispose();
    tfSizeLabelTextController?.dispose();

    tfColorLabelFocusNode?.dispose();
    tfColorLabelTextController?.dispose();
  }
}
