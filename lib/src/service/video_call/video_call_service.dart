import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companioneyes/src/model/auth/new_user.dart';
import 'package:companioneyes/src/model/video_call/video_call_model.dart';

class VideoCallService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final CollectionReference _videoCalls =
      _firestore.collection('videoCalls');

  Future<void> createVideoCall({
    required VideoCallModel videoCallModel,
  }) async {
    await _videoCalls.doc(videoCallModel.id).set({
      'id': videoCallModel.id,
      'callerId': videoCallModel.callerId,
      'recieverId': videoCallModel.recieverId,
      'callStatus': videoCallModel.callStatus.toString().split('.').last,
      'callTime': videoCallModel.callTime?.toIso8601String(),
    });
  }

  Future<void> updateVideoCall({
    required VideoCallModel videoCallModel,
  }) async {
    await _videoCalls.doc(videoCallModel.id).update({
      'callStatus': videoCallModel.callStatus.toString().split('.').last,
    });
  }

  Future<List<QueryDocumentSnapshot>> getAllVolunteers() async {
    QuerySnapshot<Object?> querySnapshot = await _firestore
        .collection("volunteer")
        // .where("status", isEqualTo: UserStatusEnum.available.toString()) //TODO: uncomment this line
        .get();
    return querySnapshot.docs;
  }
}
