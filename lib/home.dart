import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:checkmate/services/item_service.dart';

import 'package:checkmate/schemas/item.dart';

class HomeScreen extends StatefulWidget {
  final ItemService itemService;

  const HomeScreen({Key? key, required this.itemService}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  late RealmResults<Item> allItems;

  @override
  void initState() {
    super.initState();
    allItems = widget.itemService.getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shopping List")),
      body: StreamBuilder(
        stream: allItems.changes,
        builder: (BuildContext context,
            AsyncSnapshot<RealmResultsChanges<Item>> snapshot) {
          List<Item> items = [];
          if (snapshot.hasData) {
            items = snapshot.data!.results.toList();
          }

          return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: items[index].done
                      ? Colors.green.shade50
                      : Colors.transparent,
                  minLeadingWidth: 50,
                  leading: IconButton(
                    icon: Icon(
                      items[index].done
                          ? Icons.close_outlined
                          : Icons.check_outlined,
                      color: items[index].done
                          ? Colors.grey.shade500
                          : Colors.green.shade500,
                      semanticLabel: "Mark done",
                    ),
                    onPressed: () {
                      widget.itemService.toggleStatus(items[index]);
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red.shade500,
                      semanticLabel: "Delete item",
                    ),
                    onPressed: () {
                      widget.itemService.delete(items[index]);
                    },
                  ),
                  title: Text(items[index].text),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                    height: 0, thickness: 1, color: Colors.grey.shade400);
              },
              itemCount: items.length);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: dialogBuilder);
        },
        tooltip: "Add item",
        child: const Icon(
          Icons.add,
          size: 50,
        ),
      ),
    );
  }

  Widget dialogBuilder(BuildContext context) {
    late String itemName;

    return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(10),
          child: Wrap(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...createTextFormField("Item name",
                          placeholder: "Enter item name",
                          isRequired: true, onSaved: (value) {
                        itemName = value!;
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(10)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                if (kDebugMode) {
                                  print(itemName);
                                }
                                widget.itemService.add(itemName);

                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              "Add",
                              style: TextStyle(fontSize: 20),
                            )),
                      )
                    ],
                  )),
            ],
          ),
        ));
  }

  List<Widget> createTextFormField(String label,
      {String? placeholder,
      bool isRequired = false,
      Function(String?)? onSaved}) {
    return [
      Text(label, style: const TextStyle(fontSize: 20)),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
        onSaved: onSaved,
        validator: (value) {
          return isRequired && (value == null || value.isEmpty)
              ? "$label is required"
              : null;
        },
        decoration: InputDecoration(hintText: placeholder),
      )
    ];
  }
}
