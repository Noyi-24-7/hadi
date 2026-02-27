import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/shipping/domain/entities/delivery_quote.dart';

class CheckoutState {
  // Items
  final String itemName;
  final double itemValue;
  final int itemQuantity;
  final double itemWeight;

  // Pickup
  final String pickupAddress;
  final String pickupCity;
  final String pickupState;
  final String pickupCountry;

  // Dropoff (Buyer Info)
  final String buyerName;
  final String buyerEmail;
  final String buyerPhoneNumber;
  final String deliveryAddress;
  final String state;
  final String lga;
  final String country;
  
  final DeliveryQuote? selectedDeliveryQuote;

  const CheckoutState({
    this.itemName = '',
    this.itemValue = 0.0,
    this.itemQuantity = 1,
    this.itemWeight = 0.0,
    this.pickupAddress = '',
    this.pickupCity = '',
    this.pickupState = '',
    this.pickupCountry = '',
    this.buyerName = '',
    this.buyerEmail = '',
    this.buyerPhoneNumber = '',
    this.deliveryAddress = '',
    this.state = '',
    this.lga = '',
    this.country = '',
    this.selectedDeliveryQuote,
  });

  CheckoutState copyWith({
    String? itemName,
    double? itemValue,
    int? itemQuantity,
    double? itemWeight,
    String? pickupAddress,
    String? pickupCity,
    String? pickupState,
    String? pickupCountry,
    String? buyerName,
    String? buyerEmail,
    String? buyerPhoneNumber,
    String? deliveryAddress,
    String? state,
    String? lga,
    String? country,
    DeliveryQuote? selectedDeliveryQuote,
  }) {
    return CheckoutState(
      itemName: itemName ?? this.itemName,
      itemValue: itemValue ?? this.itemValue,
      itemQuantity: itemQuantity ?? this.itemQuantity,
      itemWeight: itemWeight ?? this.itemWeight,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      pickupCity: pickupCity ?? this.pickupCity,
      pickupState: pickupState ?? this.pickupState,
      pickupCountry: pickupCountry ?? this.pickupCountry,
      buyerName: buyerName ?? this.buyerName,
      buyerEmail: buyerEmail ?? this.buyerEmail,
      buyerPhoneNumber: buyerPhoneNumber ?? this.buyerPhoneNumber,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      state: state ?? this.state,
      lga: lga ?? this.lga,
      country: country ?? this.country,
      selectedDeliveryQuote: selectedDeliveryQuote ?? this.selectedDeliveryQuote,
    );
  }
}

class CheckoutSession extends StateNotifier<CheckoutState> {
  CheckoutSession() : super(const CheckoutState());

  void updateItemDetails({
    required String name,
    required double value,
    required int quantity,
    required double weight,
  }) {
    state = state.copyWith(
      itemName: name,
      itemValue: value,
      itemQuantity: quantity,
      itemWeight: weight,
    );
  }

  void updatePickupAddress({
    required String address,
    required String city,
    required String state,
    required String country,
  }) {
    this.state = this.state.copyWith(
      pickupAddress: address,
      pickupCity: city,
      pickupState: state,
      pickupCountry: country,
    );
  }

  void updateBuyerInfo({
    String? name,
    String? email,
    String? phoneNumber,
  }) {
    state = state.copyWith(
      buyerName: name,
      buyerEmail: email,
      buyerPhoneNumber: phoneNumber,
    );
  }

  void updateDeliveryAddress({
    String? address,
    String? state,
    String? lga,
    String? country,
  }) {
    this.state = this.state.copyWith(
      deliveryAddress: address,
      state: state,
      lga: lga,
      country: country,
    );
  }

  void selectDeliveryQuote(DeliveryQuote quote) {
    state = state.copyWith(selectedDeliveryQuote: quote);
  }
}

final checkoutSessionProvider = StateNotifierProvider<CheckoutSession, CheckoutState>((ref) {
  return CheckoutSession();
});

