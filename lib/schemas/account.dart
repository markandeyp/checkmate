import 'package:realm/realm.dart';

part 'account.g.dart';

@RealmModel()
@MapTo("Users")
class _Account {
  @PrimaryKey()
  @MapTo("_id")
  late ObjectId id;
  late String email;
}
