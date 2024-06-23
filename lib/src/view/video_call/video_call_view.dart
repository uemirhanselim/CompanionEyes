import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/viewmodel/video_call/video_call_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class VideoCallView extends StatelessWidget {
  const VideoCallView({super.key, required this.pRoomId, this.helpDefinition});
  final String? pRoomId;
  final String? helpDefinition;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoCallViewModel(context, pRoomId, helpDefinition!),
      child: Consumer<VideoCallViewModel>(builder: (context, viewmodel, _) {
        return Scaffold(
          body: viewmodel.isPageLoaded
              ? Stack(
                  children: [
                    viewmodel.currentUser!.isVolunteer
                        ? viewmodel.remoteView ?? Container()
                        : viewmodel.localView ?? Container(),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height / 20,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                viewmodel.logoutRoom().then((value) {
                                  Navigator.pop(context);
                                });
                              },
                              child: const Center(
                                  child: Icon(Icons.call_end, size: 32)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        );
      }),
    );
  }
}
