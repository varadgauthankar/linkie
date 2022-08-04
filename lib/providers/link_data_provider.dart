import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:linkie/constants/dio.dart';
import 'package:linkie/models/link_data.dart';

enum LinkDataState {
  initial,
  loading,
  complete,
  error,
}

class LinkDataProvider extends ChangeNotifier {
  LinkDataState _state = LinkDataState.initial;
  LinkDataState get state => _state;
  LinkData? linkData;

  void fetchLinkData(String url) async {
    _setLinkDataState(LinkDataState.loading);
    try {
      Dio dio = await MyDio.provideDio();
      final response = await dio.post('/get-url-data', data: {'url': url});
      linkData = LinkData.fromJson(response.data['data']);
      print(linkData?.image);
      _setLinkDataState(LinkDataState.complete);
    } on DioError catch (e) {
      _setLinkDataState(LinkDataState.error);
      print(e.response?.data['error']);
    }
  }

  void _setLinkDataState(LinkDataState state) {
    _state = state;
    notifyListeners();
  }
}
