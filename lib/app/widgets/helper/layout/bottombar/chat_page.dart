import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyContactsScreen extends StatefulWidget {
  const MyContactsScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyContactsScreenState createState() => _MyContactsScreenState();
}

class _MyContactsScreenState extends State<MyContactsScreen> {
  List<Contact> selectedContacts = [];
  bool _hasPermission = false;
  Set<Contact> selectedContactsSet = <Contact>{};

  @override
  void initState() {
    super.initState();
    _loadSelectedContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFCFE),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "SOS Contacts",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Image(image: AssetImage("assets/images/add_pic.png")),
          onPressed: () {},
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              if (selectedContactsSet.isNotEmpty) {
                await _saveSelectedContacts();
                setState(() {
                  selectedContactsSet.clear();
                  selectedContacts.clear(); // Clear the displayed contacts list
                });
                Get.snackbar('Contacts saved', 'Successfully saved');
              } else {
                Get.snackbar(
                    'Contacts not saved', 'Please select at least one contact');
              }
            },
            heroTag: null,
            child: const Icon(Icons.save),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () async {
              if (!_hasPermission) {
                var status = await Permission.contacts.request();
                if (status.isGranted) {
                  setState(() {
                    _hasPermission = true;
                  });
                  await _loadSelectedContacts();
                  await _getContacts();
                }
              } else {
                await _getContacts();
              }
            },
            heroTag: null,
            child: const Icon(Icons.contacts),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                ),
                Text("Your Contacts"),
                Expanded(
                  child: Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedContacts.length,
              itemBuilder: (context, index) {
                Contact currentContact = selectedContacts[index];
                bool isSelected = selectedContactsSet.contains(currentContact);

                return Container(
                  color: isSelected ? Colors.greenAccent : Colors.white,
                  child: ListTile(
                    title: Text(currentContact.displayName ?? "No Name"),
                    subtitle: Text(
                      currentContact.phones?.isNotEmpty ?? false
                          ? currentContact.phones!.first.value!
                          : "No Contact",
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        isSelected ? Icons.check : Icons.save,
                        color: isSelected ? Colors.green : null,
                      ),
                      onPressed: () {
                        setState(() {
                          if (isSelected) {
                            selectedContactsSet.remove(currentContact);
                          } else {
                            selectedContactsSet.add(currentContact);
                          }
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Future<void> _getContacts() async {
    if (_hasPermission) {
      Iterable<Contact> contacts = await ContactsService.getContacts(
        withThumbnails: false,
        photoHighResolution: false,
      );
      setState(() {
        selectedContacts = contacts.toList();
      });
    }
  }

  Future<void> _saveSelectedContacts() async {
    List<String> selectedContactStrings = selectedContactsSet
        .map((contact) =>
            "${contact.displayName}: ${contact.phones?.isNotEmpty ?? false ? contact.phones!.first.value! : 'No Contact'}")
        .toList();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("selectedContacts", selectedContactStrings);
  }

  Future<void> _loadSelectedContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> selectedContactStrings =
        prefs.getStringList("selectedContacts") ?? [];

    selectedContactsSet = selectedContactStrings.map((contactString) {
      List<String> parts = contactString.split(': ');
      String name = parts[0];
      String phone = parts[1];
      Contact contact = Contact(displayName: name);
      if (phone != 'No Contact') {
        contact.phones = [Item(label: 'mobile', value: phone)];
      }
      return contact;
    }).toSet();
  }
}
