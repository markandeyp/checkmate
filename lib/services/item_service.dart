import 'package:checkmate/schemas/item.dart';
import 'package:realm/realm.dart';

class ItemService {
  final User user;
  late final Realm realm;

  ItemService(this.user) {
    realm = openRealm();
  }

  Realm openRealm() {
    var realmConfig = Configuration.flexibleSync(user, [Item.schema]);
    var realm = Realm(realmConfig);
    realm.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.add(realm.all<Item>());
    });
    return realm;
  }

  RealmResults<Item> getItems() {
    return realm.query<Item>("userId == '${user.id}'");
  }

  add(String text) {
    realm
        .write(() => {realm.add<Item>(Item(ObjectId(), text, false, user.id))});
  }

  toggleStatus(Item item) {
    realm.write(() => {item.done = !item.done});
  }

  delete(Item item) {
    realm.write(() => {realm.delete(item)});
  }
}
