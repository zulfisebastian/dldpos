import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future logScreens({
    required String name,
  }) async {
    _analytics.logScreenView(screenName: name);
  }

  Future logEventParams({
    required String eventName,
    Map<String, Object>? eventParams,
  }) async {
    _analytics.logEvent(name: eventName, parameters: eventParams);
  }
}
