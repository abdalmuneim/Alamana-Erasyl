import 'dart:convert';

import 'package:alamanaelrasyl/features/bottom_nav_bar/tazkiyah_al-nafs/data/models/azkar_model.dart';
import 'package:flutter/services.dart';

abstract class AzkarLocaleDataSource {
  Future<List<AzkarModel>> getAzkar(String zekrType);
}

class AzkarLocaleDataSourceImp implements AzkarLocaleDataSource {
  @override
  Future<List<AzkarModel>> getAzkar(String zekrType) async {
    try {
      final data = await rootBundle.loadString("assets/data/$zekrType");

      List<dynamic> json = jsonDecode(data);

      final List<AzkarModel> azkar = List<AzkarModel>.from(
          json.map((e) => AzkarModel.fromMap(e)).toList());
      return azkar;
    } catch (e) {
      print('error => $e');
      rethrow;
    }
  }
}


/* 
import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/dataModel.dart';

class DataService {
  Future<List<Specialty>?>? getExploreData() async {
    final DataModel? getListData = await _getData();
    return getListData?.specialties;
  }

  Future<DataModel?> _getData() async {
    try {
      final dataString = await _loadAsset('assets/json_data/data.json');
      final json = jsonDecode(dataString);
      if (json['specialties'] != null) {
        final DataModel data = dataModelFromMap(dataString);
        return data;
      } else {}
    } catch (e) {
      print('error => ${e}');
    }
    return null;
  }

  Future<String> _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }
}
 */
