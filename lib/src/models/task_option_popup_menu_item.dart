import 'package:flutter/material.dart';

import 'task_option.dart';

final PopupMenuItem<TaskOption> popupMenuItemEdit =
    const PopupMenuItem<TaskOption>(
  value: TaskOption.edit,
  child: Text('Edit task'),
);

final PopupMenuItem<TaskOption> popupMenuItemDelete =
    const PopupMenuItem<TaskOption>(
  value: TaskOption.delete,
  child: Text('Delete task'),
);

final PopupMenuItem<TaskOption> popupMenuItemCopy =
    const PopupMenuItem<TaskOption>(
  value: TaskOption.copy,
  child: Text('Copy task'),
);
