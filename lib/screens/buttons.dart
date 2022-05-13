import 'package:flutter/material.dart';
import 'package:transaction_app/constants.dart';
import 'package:transaction_app/functions/functions.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class Buttons extends StatefulWidget {
  const Buttons({Key? key}) : super(key: key);

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  late int value;

  Future<dynamic> dialog(String name, Future<String> function) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(name),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  value = value;
                });
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  function;
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    Functions().initital();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Button('Send'),
            onTap: () {
              dialog('Enter the amount for send',
                  Functions().sendWithdrawBalance(20, 'sendBalance'));
            },
          ),
          Button('Balance'),
          Button('WithDraw'),
        ],
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget Button(String text) {
  return Container(
    height: 40,
    width: 100,
    decoration: BoxDecoration(
        color: Colors.amber,
        border: Border.all(),
        borderRadius: BorderRadius.circular(10)),
    child: Center(child: Text(text)),
  );
}
