/**
 * @author: jiangjunhui
 * @date: 2025/1/23
 */
import 'package:dio/dio.dart';

class LoadingInterceptor extends Interceptor {
  /// 是否显示loading
  final bool isShowLoading;
  /// 是否弹出错误信息
  final bool showErrorLoading;

  LoadingInterceptor({required this.isShowLoading, required this.showErrorLoading});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 在请求发起时显示加载提示
    if (isShowLoading) {
      _showLoading();
    }

    super.onRequest(options, handler);
  }
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // 在请求出错时隐藏加载提示
    if (isShowLoading) {
      _hideLoading();
    }
    // 网络错误弹窗提示
    if (showErrorLoading) {
      _showErrorLoading();
    }
    super.onError(err, handler);
  }


  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 在请求成功响应后隐藏加载提示
    if (isShowLoading) {
      _hideLoading();
    }

    super.onResponse(response, handler);
  }

  /// 弹窗
  void _showLoading() {


  }
  /// 隐藏弹窗
  void _hideLoading() {

  }
  /// 网络错误弹窗提示
  void _showErrorLoading() {

  }


}
 
 
 
 
 
 
 
 
 
 
 
 
 