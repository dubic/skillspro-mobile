import 'package:dio/dio.dart';

class Status {
  static const init = "initial";
  static const processing = "processing";
  static const success = "success";
  static const error = "error";
}

class HttpError {
  final String title;
  final String message;

  HttpError(this.title, this.message);
}

class HttpResponse<T> {
  T? data;
  HttpError? error;
  bool _success = false;

  HttpResponse(Response response, this.data) {
    _success = response.statusCode == 200 ? true : false;
    buildError(response);
  }

  HttpResponse.exception(DioException e) {
    var response = e.response;
    if (response == null) {
      error = HttpError('Error occurred', e.message ?? '');
      return;
    }
    buildError(response);
  }

  bool isSuccessful() {
    return _success;
  }

  String getStatus() {
    return _success == true ? Status.success : Status.error;
  }

  void buildError(Response<dynamic> response) {
    if (response.statusCode == 200) {
      return;
    }
    if (response.data != null) {
      error = HttpError(response.data['title'], response.data['detail']);
    } else {
      error = HttpError('Error occurred', response.statusMessage ?? '');
    }
  }
}
