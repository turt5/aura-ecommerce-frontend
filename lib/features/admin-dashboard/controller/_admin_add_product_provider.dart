import 'package:attira/features/admin-dashboard/model/_admin_product_add_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminAddProductProvider =
    ChangeNotifierProvider((ref) => AdminProductAddModel());
