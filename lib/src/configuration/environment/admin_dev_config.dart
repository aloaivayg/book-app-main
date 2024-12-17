import 'package:injectable/injectable.dart';

import 'build_config.dart';

@Injectable(as: BuildConfig, env: [CustomEnv.adminDev])
class BuildConfigBeta extends BuildConfig {
  @override
  String get host => '';
}
