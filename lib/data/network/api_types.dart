/// HTTP methods supported by the API client.
enum ApiHTTPMethod {
  get,
  post,
  put,
  patch,
  delete,
}

/// Options for an API request (token, loader, etc.).
class ApiRequestOptions {
  const ApiRequestOptions({
    this.requireAuth = true,
    this.showLoader = false,
    this.sendAsJson = true,
    this.receiveTimeout,
    this.sendTimeout,
  });

  final bool requireAuth;
  final bool showLoader;
  final bool sendAsJson;
  final Duration? receiveTimeout;
  final Duration? sendTimeout;

  static const ApiRequestOptions defaults = ApiRequestOptions();
}
