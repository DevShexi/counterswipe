import "package:flutter/material.dart";

class SubmitButton extends StatelessWidget {
  final String label;
  final Function submitAction;
  SubmitButton({@required this.label, @required this.submitAction});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        color: Colors.blue,
        child: Text(
          label,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        onPressed: submitAction,
      ),
    );
  }
}
