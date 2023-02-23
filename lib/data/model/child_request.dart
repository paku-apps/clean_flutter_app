

import 'package:clean_app/data/model/assign_child.dart';

List<dynamic> requestChildPriorityToJson(List<AssignChildModel> data) => List<dynamic>.from(data.map((x) => x.toJsonRequestPriority()));