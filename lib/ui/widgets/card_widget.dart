import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardWidget extends ConsumerWidget {
  final String? title;
  final String? body;

  const CardWidget({
    Key? key,
    this.title,
    this.body
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Text(title ?? "", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            const Divider(thickness: 2,),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(body ?? ""),
            ),
          ],
        ),
      ),
    );
  }
}