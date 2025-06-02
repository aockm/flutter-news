import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DetailsPage extends StatefulWidget {
  final String? title;
  final String? url;
  const DetailsPage({super.key,this.title,this.url });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("aaa"),),
      body: Text("data ${widget.title} ${widget.url}"),
    );
  }
}
