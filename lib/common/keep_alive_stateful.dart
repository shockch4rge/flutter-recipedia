import 'package:flutter/material.dart';

abstract class KeepAliveStateful extends StatefulWidget {
  const KeepAliveStateful({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => KeepAliveState();
}

class KeepAliveState extends State<KeepAliveStateful>
    with AutomaticKeepAliveClientMixin<KeepAliveStateful> {
  @override
  bool get wantKeepAlive => true;
}
