class NotificationItemJson {
  final String notificationId;
  final String orderId;
  final String message;
  final bool read;
  final DateTime dateTime;
  final bool opened;

  const NotificationItemJson({
    required this.notificationId,
    required this.orderId,
    required this.message,
    this.read = false,
    required this.dateTime,
    this.opened = false,
  });

  NotificationItemJson copyWith(
      {
        String? notificationId,
        String? orderId,
        String? message,
        bool? read,
        DateTime? dateTime,
        bool? opened}
      ) =>
      NotificationItemJson(
        notificationId: notificationId ?? this.notificationId,
        orderId: orderId ?? this.orderId,
        message: message ?? this.message,
        read: read ?? this.read,
        dateTime: dateTime ?? this.dateTime,
        opened: opened ?? this.opened,
      );

  static NotificationItemJson fromJson(Map<String, dynamic> json) => NotificationItemJson(
    notificationId: json["notificationId"],
    orderId: json["orderId"] as String? ?? '',
    message: json["message"] as String? ?? '',
    read: json["read"] as bool? ?? false,
    dateTime: json["dateTime"].toDate() as DateTime? ?? DateTime.now(),
    opened: json["opened"] as bool? ?? false,
  );

  Map<String, dynamic> toJson() => {
    "notificationId": notificationId,
    "orderId": orderId,
    "message": message,
    "read": read,
    "dateTime": dateTime,
    "opened": opened,
  };
}