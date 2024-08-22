import 'package:attira/features/admin-dashboard/model/_admin_home_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminHomeProvider = ChangeNotifierProvider<AdminHomeModel>((ref)=>AdminHomeModel());