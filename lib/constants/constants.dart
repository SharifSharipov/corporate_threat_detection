sealed class Constants {
  Constants._();
  static const String baseUrl = "https://tomubackend.tomu.uz/";
  static String? deviceId;
}

sealed class Urls {
  Urls._();
  static const String signIn = "api/auth/sign-in/users";
  static const String current = "api/auth/current";
  static const String forgotPassword = "api/auth/forgot-password";
  static const String registerStudents = "api/auth/register/students";
  static const String verifCode = "api/auth/verify-code";
  static const String sendSms = "api/auth/send-sms";
  static const String userUpdate = "api/user/update/";
  static const String course = "api/course";
  static const String useCourse = "api/user-course";
  static const String userCorse = "api/block/";
  static const String lessonProgress =
      "api/lesson-progress/get-videos?blockId=";
  static const String blocCourse = "api/block/course-lesson/";
  static const String grammar = "api/grammar/course/";
  static const String alphabet = "api/alphabet/by-course/";
  static const String homework = "api/homework-progress/get-videos?courseId=";
  static const String refresh = "api/auth/refresh?refresh_token=";
  static const String liveChat = "api/live-chat/create";
  static const String liveChatPrice = "api/livechat-price";
  static const String order = "api/orders/create";
  static const String courseTariff = "api/tariff/course";
  static const String sessions = "api/ai/chat/sessions";
  static const String voice = "api/ai/chat/voice";
  static const String aiLists = "api/ai/chat/courses";
  static const String payementCheck = "api/user-course/day/";
  static const String lessonProgressSee = "api/lesson-progress/";
  static const String homeworkProgress = "api/homework-progress/";
  static const String fcmRegisterToken = "api/notifications/register-token";
  static const String totalQueue = "api/homework-progress/total-queue-count";
  static const String allLessonCount =
      "api/homework-progress/total-queue-count";
  static const String lessonCount =
      "api/homework-progress/queue-count?courseId=";
  static const String meet = "api/user-livechats/user/";
}

enum Status { initial, loading, success, error }
