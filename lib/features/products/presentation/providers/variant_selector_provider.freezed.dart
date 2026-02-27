// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'variant_selector_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VariantSelectorState {
  String? get selectedSize => throw _privateConstructorUsedError;
  String? get selectedColor => throw _privateConstructorUsedError;
  ProductVariant? get resolvedVariant => throw _privateConstructorUsedError;
  Product? get product => throw _privateConstructorUsedError;

  /// Create a copy of VariantSelectorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VariantSelectorStateCopyWith<VariantSelectorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VariantSelectorStateCopyWith<$Res> {
  factory $VariantSelectorStateCopyWith(VariantSelectorState value,
          $Res Function(VariantSelectorState) then) =
      _$VariantSelectorStateCopyWithImpl<$Res, VariantSelectorState>;
  @useResult
  $Res call(
      {String? selectedSize,
      String? selectedColor,
      ProductVariant? resolvedVariant,
      Product? product});
}

/// @nodoc
class _$VariantSelectorStateCopyWithImpl<$Res,
        $Val extends VariantSelectorState>
    implements $VariantSelectorStateCopyWith<$Res> {
  _$VariantSelectorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VariantSelectorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedSize = freezed,
    Object? selectedColor = freezed,
    Object? resolvedVariant = freezed,
    Object? product = freezed,
  }) {
    return _then(_value.copyWith(
      selectedSize: freezed == selectedSize
          ? _value.selectedSize
          : selectedSize // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedColor: freezed == selectedColor
          ? _value.selectedColor
          : selectedColor // ignore: cast_nullable_to_non_nullable
              as String?,
      resolvedVariant: freezed == resolvedVariant
          ? _value.resolvedVariant
          : resolvedVariant // ignore: cast_nullable_to_non_nullable
              as ProductVariant?,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VariantSelectorStateImplCopyWith<$Res>
    implements $VariantSelectorStateCopyWith<$Res> {
  factory _$$VariantSelectorStateImplCopyWith(_$VariantSelectorStateImpl value,
          $Res Function(_$VariantSelectorStateImpl) then) =
      __$$VariantSelectorStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? selectedSize,
      String? selectedColor,
      ProductVariant? resolvedVariant,
      Product? product});
}

/// @nodoc
class __$$VariantSelectorStateImplCopyWithImpl<$Res>
    extends _$VariantSelectorStateCopyWithImpl<$Res, _$VariantSelectorStateImpl>
    implements _$$VariantSelectorStateImplCopyWith<$Res> {
  __$$VariantSelectorStateImplCopyWithImpl(_$VariantSelectorStateImpl _value,
      $Res Function(_$VariantSelectorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of VariantSelectorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedSize = freezed,
    Object? selectedColor = freezed,
    Object? resolvedVariant = freezed,
    Object? product = freezed,
  }) {
    return _then(_$VariantSelectorStateImpl(
      selectedSize: freezed == selectedSize
          ? _value.selectedSize
          : selectedSize // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedColor: freezed == selectedColor
          ? _value.selectedColor
          : selectedColor // ignore: cast_nullable_to_non_nullable
              as String?,
      resolvedVariant: freezed == resolvedVariant
          ? _value.resolvedVariant
          : resolvedVariant // ignore: cast_nullable_to_non_nullable
              as ProductVariant?,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
    ));
  }
}

/// @nodoc

class _$VariantSelectorStateImpl extends _VariantSelectorState {
  const _$VariantSelectorStateImpl(
      {this.selectedSize,
      this.selectedColor,
      this.resolvedVariant,
      this.product})
      : super._();

  @override
  final String? selectedSize;
  @override
  final String? selectedColor;
  @override
  final ProductVariant? resolvedVariant;
  @override
  final Product? product;

  @override
  String toString() {
    return 'VariantSelectorState(selectedSize: $selectedSize, selectedColor: $selectedColor, resolvedVariant: $resolvedVariant, product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VariantSelectorStateImpl &&
            (identical(other.selectedSize, selectedSize) ||
                other.selectedSize == selectedSize) &&
            (identical(other.selectedColor, selectedColor) ||
                other.selectedColor == selectedColor) &&
            (identical(other.resolvedVariant, resolvedVariant) ||
                other.resolvedVariant == resolvedVariant) &&
            (identical(other.product, product) || other.product == product));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, selectedSize, selectedColor, resolvedVariant, product);

  /// Create a copy of VariantSelectorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VariantSelectorStateImplCopyWith<_$VariantSelectorStateImpl>
      get copyWith =>
          __$$VariantSelectorStateImplCopyWithImpl<_$VariantSelectorStateImpl>(
              this, _$identity);
}

abstract class _VariantSelectorState extends VariantSelectorState {
  const factory _VariantSelectorState(
      {final String? selectedSize,
      final String? selectedColor,
      final ProductVariant? resolvedVariant,
      final Product? product}) = _$VariantSelectorStateImpl;
  const _VariantSelectorState._() : super._();

  @override
  String? get selectedSize;
  @override
  String? get selectedColor;
  @override
  ProductVariant? get resolvedVariant;
  @override
  Product? get product;

  /// Create a copy of VariantSelectorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VariantSelectorStateImplCopyWith<_$VariantSelectorStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
