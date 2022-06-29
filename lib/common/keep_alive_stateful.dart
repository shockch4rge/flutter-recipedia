import 'package:flutter/material.dart';

abstract class KeepAliveStateful extends StatefulWidget {
  const KeepAliveStateful({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KeepAliveStatefulState();
}

class _KeepAliveStatefulState extends State<KeepAliveStateful>
    with AutomaticKeepAliveClientMixin<KeepAliveStateful> {
  @override
  bool get wantKeepAlive => true;
}
