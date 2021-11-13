import 'package:clean_achitecture/features/Post/presentation/item_page/address_Post/domain/entity/distric.dart';

abstract class Repository {
  Future<District> chooseDistrict();
  Future<District> chooseWard(String string);
}
