import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/_account_model.dart';

final accountProvider = ChangeNotifierProvider((ref)=> AccountModel()); 