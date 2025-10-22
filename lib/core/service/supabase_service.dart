// ignore_for_file: depend_on_referenced_packages

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SupabaseService {
  SupabaseService._();
  static final SupabaseService instance = SupabaseService._();
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<String>> getImageUrls() async {
    try {
      // Fetch the JSON list
      final jsonUrl = _supabase.storage
          .from('Sketch-Images')
          .getPublicUrl('sketches/image_list.json');

      final response = await http.get(Uri.parse(jsonUrl));
      final data = json.decode(response.body);
      final List<String> imageNames = List<String>.from(data['images']);

      // Convert to full URLs
      final urls = imageNames.map((fileName) {
        return _supabase.storage
            .from('Sketch-Images')
            .getPublicUrl('sketches/$fileName');
      }).toList();

      debugPrint('✅ Loaded ${urls.length} images');
      return urls;
    } catch (e) {
      debugPrint('❌ Error: $e');
      return [];
    }
  }
}
