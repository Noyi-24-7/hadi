import 'package:fpdart/fpdart.dart';
import 'package:flutter/material.dart';

/// Extension methods for Either type from fpdart.
/// Provides convenient helpers for working with Either<Failure, Success>.
extension EitherExtensions<L, R> on Either<L, R> {
  /// Get the right value (success case).
  /// Throws if this is a Left.
  R getRight() => (this as Right<L, R>).value;

  /// Get the left value (failure case).
  /// Throws if this is a Right.
  L getLeft() => (this as Left<L, R>).value;

  /// Check if this is a Right (success).
  bool get hasRight => fold((_) => false, (_) => true);

  /// Check if this is a Left (failure).
  bool get hasLeft => fold((_) => true, (_) => false);

  /// Map the right value to a widget, or show failure widget.
  Widget when({
    required Widget Function(L failure) failure,
    required Widget Function(R data) success,
  }) {
    return fold(
      (l) => failure(l),
      (r) => success(r),
    );
  }

  /// Flat map for chaining Either operations.
  Either<L, T> flatMap<T>(Either<L, T> Function(R r) f) {
    return fold(
      (l) => Left(l),
      (r) => f(r),
    );
  }

  /// Get the right value or return a default.
  R getOrElse(R Function() defaultValue) {
    return fold(
      (_) => defaultValue(),
      (r) => r,
    );
  }

  /// Get the right value or null.
  R? getOrNull() {
    return fold(
      (_) => null,
      (r) => r,
    );
  }
}
