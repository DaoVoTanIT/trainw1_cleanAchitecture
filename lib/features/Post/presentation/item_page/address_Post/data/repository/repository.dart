// import 'dart:convert';

// import 'package:clean_achitecture/features/Post/presentation/Item_Page/address/data/model/district_model.dart';
// import 'package:clean_achitecture/features/Post/presentation/item_page/address/data/service/addressAPI.dart';
// import 'package:clean_achitecture/features/Post/presentation/item_page/address/domain/entity/distric.dart';
// import 'package:clean_achitecture/features/Post/presentation/item_page/address/domain/repository/Repository.dart';
// import 'package:flutter/material.dart';

// class RepositoryData extends Repository {
//   late BuildContext context;
//   late District district;
//   @override
//   Future<District> chooseWard(String string) {
//     // TODO: implement chooseWard
//     throw UnimplementedError();
//   }

//   @override
//   Future<List<DistrictModel>> chooseDistrict() async {
//     final assetBundle = DefaultAssetBundle.of(context);
//     final data = await assetBundle.loadString('assets/district.json');
//     final body = json.decode(data);

//     return body.map<DistrictModel>(DistrictModel.fromJson).toList();
//   }
// }
