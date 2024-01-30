import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';

class EditFieldController with ChangeNotifier {
  late TextEditingController textEditingController;

  void initialize(String? value) {
    textEditingController = TextEditingController(text: value);
  }
}

class EditFieldScreen extends StatelessWidget {
  final String label;
  final String? value;

  EditFieldScreen({required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    Provider.of<EditFieldController>(context, listen: false).initialize(value);

    return Consumer2<UserProvider, EditFieldController>(
      builder: (context, userProvider, editFieldController, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit ${label}'),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: editFieldController.textEditingController,
              decoration: InputDecoration(
                labelText: label,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.check),
            onPressed: () {
              print(' phone number is: ${editFieldController.textEditingController.text}');
              userProvider.updateProfile(label, editFieldController.textEditingController.text);
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
