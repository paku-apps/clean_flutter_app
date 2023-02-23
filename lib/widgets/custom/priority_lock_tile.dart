

import 'package:clean_app/data/model/assign_child.dart';
import 'package:flutter/material.dart';

class IconCheckPriority extends StatelessWidget {

  AssignChildModel child;
  bool enabled;
  Function action;

  IconCheckPriority({
    Key? key,
    required this.child,
    required this.enabled,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: enabled ? const Icon(Icons.lock, size: 24) : const Icon(Icons.lock_open, size: 24),
        onTap: () { action(); },
      ),
    );
  }
}