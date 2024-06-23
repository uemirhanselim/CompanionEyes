// ignore: constant_identifier_names
enum CallStatus { WAITING, ACCEPTED, DECLINED }

class VideoCallModel {
  final String id;
  final String callerId;
  final String recieverId;
  final CallStatus callStatus;
  final DateTime? callTime;

  VideoCallModel(
      {required this.id,
      required this.callerId,
      required this.recieverId,
      required this.callStatus,
      this.callTime});
}
