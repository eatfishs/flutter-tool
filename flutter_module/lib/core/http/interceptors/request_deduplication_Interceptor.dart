/**
 * @author: jiangjunhui
 * @date: 2025/2/21
 */
import 'dart:async';
import 'dart:collection';

import 'package:dio/dio.dart';

enum MyRequestDeduplicationPolicy {
  /// 不做任何处理
  none,

  /// 我不想要任何返回结果，在请求发起阶段就被拦截,适用于一个界面，按钮被连续点击多次
  noResult,

  /// 不发起请求,复用上一个请求结果
  previousResult
}

class RequestDeduplicationInterceptor extends Interceptor {
  final Map<String, _PendingRequest> _pendingRequests = HashMap();
  final MyRequestDeduplicationPolicy _policy;

  RequestDeduplicationInterceptor(this._policy);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final key = generateRequestKey(options);

    if (_pendingRequests.containsKey(key)) {
      final pendingRequest = _pendingRequests[key]!;
      if (_policy == MyRequestDeduplicationPolicy.noResult) {
        // 拦截请求，不发送，也不返回结果
        return null; // 或者你可以抛出一个异常来通知调用者
      } else if (_policy == MyRequestDeduplicationPolicy.previousResult) {
        // 复用上一个请求的结果
        // 注意：这里我们不能直接返回结果，因为onRequest期望一个RequestOptions对象或者null（表示拦截请求）。
        // 我们需要一种方式来将结果传递给请求的调用者。
        // 一种方法是使用全局状态管理（如Provider、Riverpod等），但这超出了拦截器的范围。
        // 另一种方法是在dio的外部处理这个逻辑，而不是在拦截器内部。
        // 但为了演示，我们可以使用Completer来模拟这个结果传递（尽管这不是最佳实践，因为它可能导致内存泄漏）。
        final completer = Completer<Response>();
        pendingRequest.completers.add(completer);
        // 注意：这里的completer.future不应该直接返回给onRequest，因为onRequest需要RequestOptions或null。
        // 相反，你应该在dio请求的外部处理这个结果，例如通过注册一个回调或使用Future.any/Future.wait等方式。
        // 由于这个示例的局限性，我们不会在这里实现完整的解决方案，但会留下注释和思路。
        // 你可以考虑在dio请求被发送之前（在拦截器链的下一个拦截器调用之前）注册一个回调，当请求完成时触发该回调，并传递结果。
        // 然而，这通常涉及到更复杂的逻辑和状态管理，超出了这个简单示例的范围。
        // 因此，下面的代码仅用于演示目的，并不推荐在实际应用中使用。
        // completer.future.then((response) => {
        //   // 在这里处理复用结果
        // });

        // 由于我们不能直接返回结果，我们仍然需要拦截请求（通过返回null），
        // 并在dio请求的外部处理结果复用逻辑。
        return null;
      }
    } else {
      // 没有找到重复请求，添加一个新的待处理请求
      _pendingRequests[key] = _PendingRequest(completers: []);
    }

    // 继续处理请求（如果不被拦截）
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final key = generateRequestKey(response.requestOptions);
    if (_pendingRequests.containsKey(key)) {
      final pendingRequest = _pendingRequests[key]!;
      pendingRequest.completers
          .forEach((completer) => completer.complete(response));
      _pendingRequests.remove(key);
    }

    // 返回响应（如果需要修改响应，可以在这里处理）
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) {
    final key = generateRequestKey(error.requestOptions);

    if (_pendingRequests.containsKey(key)) {
      final pendingRequest = _pendingRequests[key]!;
      pendingRequest.completers
          .forEach((completer) => completer.completeError(error));
      _pendingRequests.remove(key);
    }

    // 返回错误（如果需要修改错误处理，可以在这里处理）
    super.onError(error, handler);
  }

  // 生成请求的唯一标识
  String generateRequestKey(RequestOptions options) {
    return '${options.method}-${options.uri}-${options.data?.toString() ?? ""}';
  }
}

class _PendingRequest {
  final List<Completer<Response>> completers;

  _PendingRequest({required this.completers});
}
