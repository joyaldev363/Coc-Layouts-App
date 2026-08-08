import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/supabase_provider.dart';
import '../models/layout_model.dart';
import '../models/banner_model.dart';
import '../models/category_model.dart';
import '../../townhall/models/townhall_model.dart';

final layoutsProvider = FutureProvider<List<LayoutModel>>((ref) async {
  final supabase = ref.watch(supabaseClientProvider);
  try {
    final response = await supabase
        .from('layouts')
        .select('*')
        .order('created_at', ascending: false);
    
    final List<dynamic> data = response as List<dynamic>;
    return data.map((json) => LayoutModel.fromJson(json)).toList();
  } catch (e) {
    print('Error fetching layouts from Supabase: $e');
    return [];
  }
});

final activeBannersProvider = FutureProvider<List<BannerModel>>((ref) async {
  final supabase = ref.watch(supabaseClientProvider);
  try {
    final response = await supabase
        .from('banners')
        .select('*')
        .eq('is_active', true)
        .order('sort_order', ascending: true);
    
    final List<dynamic> data = response as List<dynamic>;
    return data.map((json) => BannerModel.fromJson(json)).toList();
  } catch (e) {
    print('Error fetching banners from Supabase: $e');
    return [];
  }
});

final activeCategoriesProvider = FutureProvider<List<CategoryModel>>((ref) async {
  final supabase = ref.watch(supabaseClientProvider);
  try {
    final response = await supabase
        .from('categories')
        .select('*')
        .eq('is_active', true)
        .order('created_at', ascending: false);
        
    final List<dynamic> data = response as List<dynamic>;
    return data.map((json) => CategoryModel.fromJson(json)).toList();
  } catch (e) {
    print('Error fetching categories from Supabase: $e');
    return [];
  }
});

final townhallsProvider = FutureProvider<List<TownhallModel>>((ref) async {
  final supabase = ref.watch(supabaseClientProvider);
  try {
    final response = await supabase
        .from('townhalls')
        .select('*')
        .order('created_at', ascending: false);
        
    final List<dynamic> data = response as List<dynamic>;
    return data.map((json) => TownhallModel.fromJson(json)).toList();
  } catch (e) {
    print('Error fetching townhalls from Supabase: $e');
    return [];
  }
});
