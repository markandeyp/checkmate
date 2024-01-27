import 'package:realm/realm.dart';
part 'item.g.dart';

@RealmModel()
@MapTo("Items")
class _Item {
  @PrimaryKey()
  @MapTo("_id")
  late ObjectId id;
  late String text;
  late bool done;
  @MapTo("user_id")
  late String userId;
  @MapTo("shared_with")
  late List<String> sharedWith;
}
