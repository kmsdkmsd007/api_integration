import 'package:flutter/material.dart';

class EmailWidget extends StatefulWidget {
  const EmailWidget({super.key, required this.text});
  final String text;

  @override
  EmailWidgetState createState() => EmailWidgetState();
}

class EmailWidgetState extends State<EmailWidget> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        print('TextField gained focus');
      } else {
        print('TextField lost focus');
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            labelText: widget.text,
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                FocusScope.of(context).requestFocus(_focusNode);
              },
            ),
          ),
        ),
      ),
    );
  }
}
