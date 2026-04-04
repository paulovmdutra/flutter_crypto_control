import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_crypto_control/shared/view_async.dart';

extension AsyncValueExtensions<T> on AsyncValue<T> {
  ViewAsync<T> toViewAsync() {
    return when(
      loading: () => ViewAsyncLoading<T>(),
      error: (err, stack) => ViewAsyncError<T>(err, stack),
      data: (data) => ViewAsyncData<T>(data),
    );
  }
}
