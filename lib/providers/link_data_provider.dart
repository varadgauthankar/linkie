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

  LinkData? _linkData;
  LinkData? get linkData => _linkData;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  final TextEditingController _urlController = TextEditingController();
  TextEditingController get urlController => _urlController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  bool navigated = false;

  void setNavigated() {
    navigated = true;
    notifyListeners();
  }

  void fetchLinkData() async {
    navigated = false;
    if (formKey.currentState!.validate()) {
      _setLinkDataState(LinkDataState.loading);
      try {
        Dio dio = await MyDio.provideDio();
        final response = await dio.post('/get-url-data', data: {
          'url': _urlController.text.trim(),
        });
        _linkData = LinkData.fromJson(response.data['data']);

        _setLinkDataState(LinkDataState.complete);
      } on DioError catch (e) {
        _errorMessage = e.response?.data['error'];
        _setLinkDataState(LinkDataState.error);
      }
    }
  }

  void _setLinkDataState(LinkDataState state) {
    _state = state;
    notifyListeners();
  }
}
