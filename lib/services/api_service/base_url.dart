class AppBaseUrl {
  static bool isLive = false;

  static String baseUrl =
      isLive ? "https://google.com" : "http://127.0.0.1:5000";
}
