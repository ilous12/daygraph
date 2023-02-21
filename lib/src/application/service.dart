import 'package:flutter_riverpod/flutter_riverpod.dart';

/// App Service class for the Application Layer
/// Do not use for this app.
class AppService {
  AppService(this.ref);

  final Ref ref;
}

final appServiceProvider = Provider<AppService>((ref) {
  return AppService(ref);
});
