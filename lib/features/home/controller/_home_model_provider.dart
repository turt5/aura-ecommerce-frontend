import 'package:attira/features/home/model/_home_model_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeModelProvider = ChangeNotifierProvider((ref) => HomeModelRiverpod());
