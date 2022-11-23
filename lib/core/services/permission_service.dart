
import 'package:permission_handler/permission_handler.dart';

/// It's a class that can't be instantiated, but can be extended
abstract class Permissions {
  /// abstract method to get permission status
  Future<PermissionStatus> getPermissionStatus(Permission permission);

  
}

/// It's a Dart class that extends the Permissions class
class PermissionService extends Permissions {
  @override
  Future<PermissionStatus> getPermissionStatus(Permission permission) async {
    return permission.status;
  }
}


//  cameraPermission() async {
//     final status = await Permission.camera.status;
//     final request = Permission.camera;

//     if (status.isDenied) {
//       await request.request();
//     }
//     if (status.isGranted) {}
    
//     if (status.isRestricted) {
//       await request.request();
//     }
//     if (status.isPermanentlyDenied) {
//       openAppSettings();
//     }
//   }