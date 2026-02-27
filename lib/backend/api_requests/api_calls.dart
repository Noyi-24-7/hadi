import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class CreateOrderAuthCall {
  static Future<ApiCallResponse> call() async {
    final ffApiRequestBody = '''
{
  "store_id": "string",
  "buyer": {
    "name": "string",
    "phone": "string (optional)",
    "email": "string (optional)"
  },
  "items": [
    {
      "product_id": "string",
      "variant_id": "string (optional)",
      "quantity": "number",
      "unit_price": "number"
    }
  ],
  "delivery_fee": "number (optional)"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CreateOrderAuth',
      apiUrl:
          'https://cdkbwqzduobjayxnuhcz.supabase.co/functions/v1/orders-create',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNka2J3cXpkdW9iamF5eG51aGN6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU1MjY3NTgsImV4cCI6MjA4MTEwMjc1OH0.hVPF8RRY4IfD0DUFB564nKWGFq1ukZQwyakkhcCdbas',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class VerifyBankAccountCall {
  static Future<ApiCallResponse> call() async {
    final ffApiRequestBody = '''
{
  "bank_code": "string",
  "account_number": "string"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Verify Bank Account',
      apiUrl:
          'https://cdkbwqzduobjayxnuhcz.supabase.co/functions/v1/merchant-verify-bank',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateDeliveryCall {
  static Future<ApiCallResponse> call() async {
    final ffApiRequestBody = '''
{
  "order_id": "string",
  "pickup": {
    "address": "string",
    "phone": "string"
  },
  "dropoff": {
    "address": "string",
    "phone": "string"
  },
  "package": {
    "weight_kg": "number (optional)"
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Create Delivery',
      apiUrl:
          'https://cdkbwqzduobjayxnuhcz.supabase.co/functions/v1/deliveries-create',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class OtpSendCall {
  static Future<ApiCallResponse> call({
    String? phone = '',
    String? channel = '',
  }) async {
    final ffApiRequestBody = '''
{
  "phone": "${escapeStringForJson(phone)}",
  "channel": "${escapeStringForJson(channel)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'otpSend',
      apiUrl: 'https://cdkbwqzduobjayxnuhcz.supabase.co/functions/v1/otp-send',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNka2J3cXpkdW9iamF5eG51aGN6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU1MjY3NTgsImV4cCI6MjA4MTEwMjc1OH0.hVPF8RRY4IfD0DUFB564nKWGFq1ukZQwyakkhcCdbas',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class OtpCheckCall {
  static Future<ApiCallResponse> call({
    String? phone = '',
    String? code = '',
  }) async {
    final ffApiRequestBody = '''
{
  "phone": "${escapeStringForJson(phone)}",
  "code": "${escapeStringForJson(code)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'otpCheck',
      apiUrl: 'https://cdkbwqzduobjayxnuhcz.supabase.co/functions/v1/otp-check',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNka2J3cXpkdW9iamF5eG51aGN6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU1MjY3NTgsImV4cCI6MjA4MTEwMjc1OH0.hVPF8RRY4IfD0DUFB564nKWGFq1ukZQwyakkhcCdbas',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class MonoBanksCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'MonoBanks',
      apiUrl:
          'https://cdkbwqzduobjayxnuhcz.supabase.co/functions/v1/mono-banks',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNka2J3cXpkdW9iamF5eG51aGN6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU1MjY3NTgsImV4cCI6MjA4MTEwMjc1OH0.hVPF8RRY4IfD0DUFB564nKWGFq1ukZQwyakkhcCdbas',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class MonoNameEnquiryCall {
  static Future<ApiCallResponse> call({
    String? accountNumber = '0000000',
    String? bankCode = '000013',
  }) async {
    final ffApiRequestBody = '''
{
  "account_number": "${escapeStringForJson(accountNumber)}",
  "bank_code": "${escapeStringForJson(bankCode)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'MonoNameEnquiry',
      apiUrl:
          'https://cdkbwqzduobjayxnuhcz.supabase.co/functions/v1/mono-name-enquiry',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNka2J3cXpkdW9iamF5eG51aGN6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU1MjY3NTgsImV4cCI6MjA4MTEwMjc1OH0.hVPF8RRY4IfD0DUFB564nKWGFq1ukZQwyakkhcCdbas',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
