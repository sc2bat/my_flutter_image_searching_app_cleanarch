import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeViewModel extends ChangeNotifier with WidgetsBindingObserver {
  final supabase = Supabase.instance.client;
}
