import 'package:flutter/material.dart';
import 'package:front/helpers/Task_helper.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/helpers/auth_helper.dart';
import 'package:front/models/response/auth/user.dart';
/*
class MemberDropdown extends StatefulWidget {
  final TextEditingController controller;
  final Future<List<String>> membersFuture;
  final String id_task;

  MemberDropdown(this.controller, this.membersFuture, this.id_task);

  @override
  _MemberDropdown createState() => _MemberDropdown();
}

class _MemberDropdown extends State<MemberDropdown> {
  String? _selectedMember;
  Map<String, String> memberIdNameMap = {};
  List<String> _remainingMemberIds = [];

  @override
  void initState() {
    super.initState();
    widget.membersFuture.then((members) {
      setState(() {
        _remainingMemberIds = members;
      });
    });
  }

  Future<String> _getMemberNameById(String id) async {
    UserModel? user = await AuthHelper.getUserById(id);
    return user?.username ?? 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: Future.wait(_remainingMemberIds.map((id) async {
        String name = await _getMemberNameById(id);
        memberIdNameMap[id] = name;
        return name;
      }).toList()),
      builder: (context, memberNamesSnapshot) {
        if (memberNamesSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (memberNamesSnapshot.hasError) {
          return Text('Error: ${memberNamesSnapshot.error}');
        } else if (!memberNamesSnapshot.hasData || memberNamesSnapshot.data!.isEmpty) {
          return Text('No members found');
        } else {
          return DropdownButtonFormField<String>(
            value: _selectedMember,
            items: _remainingMemberIds.map((id) {
              return DropdownMenuItem(
                value: id,
                child: Text(memberIdNameMap[id]!),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  _selectedMember = value;
                  widget.controller.text = value;

                  // إضافة العضو إلى المهمة باستخدام الـ ID
                  TaskHelper.addMember(widget.controller.text, widget.id_task);

                  // إزالة العضو من القائمة بعد إضافته
                  _remainingMemberIds.remove(value);
                  _selectedMember = null; // إعادة تعيين القيمة المختارة
                }
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFFAF0E6), // Background color
              hintText: 'Add member', // Hint text
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
            style: TextStyle(
              color: Colors.black, // Change the text color
              fontSize: 16.0, // Adjust font size
            ),
          );
        }
      },
    );
  }
}
*/


import 'package:flutter/material.dart';
import 'package:front/helpers/Task_helper.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/helpers/auth_helper.dart';
import 'package:front/models/response/auth/user.dart';

class MemberDropdown extends StatefulWidget {
  final TextEditingController controller;
  final Future<List<String>> membersFuture;
  final String id_task;

  MemberDropdown(this.controller, this.membersFuture, this.id_task);

  @override
  _MemberDropdown createState() => _MemberDropdown();
}

class _MemberDropdown extends State<MemberDropdown> {
  String? _selectedMember;
  Map<String, String> memberIdNameMap = {};
  List<String> _remainingMemberIds = [];

  @override
  void initState() {
    super.initState();
    widget.membersFuture.then((members) {
      setState(() {
        _remainingMemberIds = members;
      });
    });
  }

  Future<String> _getMemberNameById(String id) async {
    UserModel? user = await AuthHelper.getUserById(id);
    return user?.username ?? 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: Future.wait(_remainingMemberIds.map((id) async {
        String name = await _getMemberNameById(id);
        memberIdNameMap[id] = name;
        return name;
      }).toList()),
      builder: (context, memberNamesSnapshot) {
        if (memberNamesSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (memberNamesSnapshot.hasError) {
          return Text('Error: ${memberNamesSnapshot.error}');
        } else if (!memberNamesSnapshot.hasData || memberNamesSnapshot.data!.isEmpty) {
          return Text('No members found');
        } else {
          return DropdownButtonFormField<String>(
            value: _selectedMember,
            items: _remainingMemberIds.map((id) {
              return DropdownMenuItem(
                value: id,
                child: Text(memberIdNameMap[id]!),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  _selectedMember = value;
                  widget.controller.text = value;

                  // إضافة العضو إلى المهمة باستخدام الـ ID
                  TaskHelper.addMember( widget.id_task, widget.controller.text);

                  // إزالة العضو من القائمة بعد إضافته
                  _remainingMemberIds.remove(value);
                  _selectedMember = null; // إعادة تعيين القيمة المختارة
                }
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFFAF0E6), // Background color
              hintText: 'Add member', // Hint text
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
            style: TextStyle(
              color: Colors.black, // Change the text color
              fontSize: 16.0, // Adjust font size
            ),
          );
        }
      },
    );
  }
}
