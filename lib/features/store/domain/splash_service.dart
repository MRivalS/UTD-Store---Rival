class SplashService {
  Future<void> startAppDelay() async {
    await Future.delayed(const Duration(seconds: 6));
  }
}
