import 'package:attira/features/user-dashboard/model/_product_details_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsDetailsProvider = ChangeNotifierProvider((ref)=>ProductDetailsModel());