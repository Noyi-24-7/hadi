// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:http/http.dart' as http;

Future<int> getRemoteFileSizeBytes(String url) async {
  final u = url.trim();
  if (u.isEmpty) return 0;

  final uri = Uri.tryParse(u);
  if (uri == null) return 0;

  // Try HEAD first (fastest)
  try {
    final headRes = await http.head(uri);
    final len = headRes.headers['content-length'];
    final parsed = int.tryParse(len ?? '');
    if (parsed != null && parsed > 0) return parsed;
  } catch (_) {}

  // Fallback: GET only first byte using Range (still lightweight)
  try {
    final getRes = await http.get(uri, headers: {'Range': 'bytes=0-0'});
    final cr = getRes.headers['content-range']; // e.g. "bytes 0-0/12345"
    if (cr != null && cr.contains('/')) {
      final totalStr = cr.split('/').last;
      final total = int.tryParse(totalStr);
      if (total != null && total > 0) return total;
    }
  } catch (_) {}

  return 0;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
