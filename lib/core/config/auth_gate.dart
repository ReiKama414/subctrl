import 'package:subctrl/core/config/app_env.dart';
import 'package:subctrl/data/database/app_database.dart';

/// Whether the app may leave the login gate for this build + linked identities.
bool authGateSatisfied(List<LinkedIdentity> identities) {
  if (AppEnv.requireAccountLogin) {
    return identities.any((i) => i.provider == 'google' || i.provider == 'line');
  }
  return identities.isNotEmpty;
}
