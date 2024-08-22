import 'package:attira/features/user-dashboard/model/_home_model_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeModelProvider = ChangeNotifierProvider((ref) => HomeModelRiverpod());
