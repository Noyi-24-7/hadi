import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

int totalQtyFromSizes(List<SizeEntryStruct>? sizes) {
  if (sizes == null) return 0;

  int total = 0;

  for (final s in sizes) {
    total += s.qty; // qty is an int on your struct
  }

  return total;
}

List<String> qtyOptionsForSizeLabel(
  String? sizeLabel,
  List<SizeEntryStruct>? sizes,
) {
  if (sizeLabel == null || sizeLabel.isEmpty) return [];

  final match = (sizes ?? []).where((s) => s.label == sizeLabel).toList();
  if (match.isEmpty) return [];

  final maxQty = match.first.qty ?? 0;
  if (maxQty <= 0) return [];

  return List.generate(maxQty, (i) => '${i + 1}');
}

int parseIntSafe(String? value) {
  if (value == null) return 0;
  final v = value.trim();
  if (v.isEmpty) return 0;
  return int.tryParse(v) ?? 0;
}

int kgToGrams(String? kgText) {
  if (kgText == null) return 0;
  final v = kgText.trim();
  if (v.isEmpty) return 0;
  final kg = double.tryParse(v);
  if (kg == null) return 0;
  return (kg * 1000).round();
}

bool isVideoFromName(String? nameOrUrl) {
  if (nameOrUrl == null) return false;
  final s = nameOrUrl.toLowerCase().trim();

  // If it's a URL, last segment might contain extension
  final last = s.split('?').first.split('#').first;

  return last.endsWith('.mp4') ||
      last.endsWith('.mov') ||
      last.endsWith('.m4v') ||
      last.endsWith('.webm') ||
      last.endsWith('.mkv') ||
      last.endsWith('.avi');
}

String formatBytes(int? bytes) {
  final b = bytes ?? 0;
  if (b <= 0) return '0 B';

  const k = 1024;
  if (b < k) return '$b B';

  final kb = b / k;
  if (kb < k) return '${kb.toStringAsFixed(1)} KB';

  final mb = kb / k;
  if (mb < k) return '${mb.toStringAsFixed(1)} MB';

  final gb = mb / k;
  return '${gb.toStringAsFixed(1)} GB';
}

String urlToImagePath(String url) {
  if (url.isEmpty) {
    return '';
  }

  // Optional: validate it's an image URL
  final lower = url.toLowerCase();
  if (lower.endsWith('.jpg') ||
      lower.endsWith('.jpeg') ||
      lower.endsWith('.png') ||
      lower.endsWith('.gif') ||
      lower.endsWith('.webp')) {
    return url;
  }

  // If it's not an image, still return it (FlutterFlow will try to render it)
  return url;
}

String urlToVideoPath(String url) {
  if (url.isEmpty) {
    return '';
  }

  // Optional: validate it's a video URL
  final lower = url.toLowerCase();
  if (lower.endsWith('.mp4') ||
      lower.endsWith('.mov') ||
      lower.endsWith('.webm') ||
      lower.endsWith('.mkv') ||
      lower.endsWith('.avi')) {
    return url;
  }

  return url;
}

String getFileNameFromUrl(String url) {
  final u = url.trim();
  if (u.isEmpty) return '';

  final uri = Uri.tryParse(u);
  if (uri == null) return '';

  // last segment of the path
  if (uri.pathSegments.isEmpty) return '';
  return uri.pathSegments.last;
}

bool isVideoUrl(String url) {
  final u = url.trim().toLowerCase();
  if (u.isEmpty) return false;

  // ignore query params
  final clean = u.split('?').first;

  return clean.endsWith('.mp4') ||
      clean.endsWith('.mov') ||
      clean.endsWith('.m4v') ||
      clean.endsWith('.webm') ||
      clean.endsWith('.mkv') ||
      clean.endsWith('.avi');
}

int fileSizeBytesFromFile(FFUploadedFile? file) {
  final bytes = file?.bytes;
  if (bytes == null) return 0;
  return bytes.length;
}

String buildStoragePath(
  String productId,
  String fileName,
) {
  final pid = productId.trim();
  final fn = fileName.trim();
  if (pid.isEmpty || fn.isEmpty) return '';
  return 'products/$pid/$fn';
}

int priceForSizeLabel(
  String? sizeLabel,
  List<SizeEntryStruct>? sizes,
  int fallbackPrice,
) {
  if (sizeLabel == null || sizeLabel.trim().isEmpty) return fallbackPrice;
  final wanted = sizeLabel.trim();

  for (final s in (sizes ?? const [])) {
    final lbl = (s?.label ?? '').trim();
    if (lbl != wanted) continue;

    final p = s?.price;
    if (p == null) return fallbackPrice;

    // price might be int/double/num depending on your SizeEntry field type
    if (p is int) return p;
    if (p is double) return p.round();
    if (p is num) return p.round();

    // last fallback if FF ever stores it as String
    return int.tryParse(p.toString()) ?? fallbackPrice;
  }

  return fallbackPrice;
}

String getInitials(String text) {
  final cleaned = text.trim();
  if (cleaned.isEmpty) return '';
  final parts =
      cleaned.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
  if (parts.isEmpty) return '';
  final first = parts.first[0];
  final second = parts.length > 1
      ? parts[1][0]
      : (parts.first.length > 1 ? parts.first[1] : '');
  return (first + second).toUpperCase();
}
