import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pressWave/core/functions/chnage_user)name_function.dart';
import 'package:pressWave/core/functions/showed_scaffold_message.dart';
import 'package:pressWave/core/functions/validators.dart';
import 'package:pressWave/core/utilities/styles.dart';
import 'package:pressWave/core/widgets/second_custom_text_form_filed.dart';

class EditUserNameWidget extends StatefulWidget {
  const EditUserNameWidget({
    super.key,
  });

  @override
  State<EditUserNameWidget> createState() => _EditUserNameWidgetState();
}

class _EditUserNameWidgetState extends State<EditUserNameWidget> {
  late TextEditingController textEditingController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidate = AutovalidateMode.disabled;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      content: Form(
        key: formKey,
        autovalidateMode: autovalidate,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Edit Your Name',
              style: AppStyles.styleSemiBold18,
            ),
            SecondCustomTextFromField(
              controller: textEditingController,
              hint: 'Change Your Name',
              obscureText: false,
              validator: (value) {
                return Validators.nameValidator(value);
              },
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                onPressed: () {
                  context.pop();
                },
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    await changeUsrName(
                      newName: textEditingController.value.text,
                    );
                    setState(() {
                      context.pop();
                    });
                    if (context.mounted) {
                      showedScaffoldMessage(
                          context: context, message: 'updated successfully');
                    }
                  } else {
                    autovalidate = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
