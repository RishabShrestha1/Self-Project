import 'package:flutter/material.dart';

class ReportTile extends StatelessWidget {
  final Map<String, dynamic> profession;
  const ReportTile({super.key, required this.profession});

  @override
  Widget build(BuildContext context) {
    final type = profession['type'];
    final isAcademic = type == 'ACSRL';
    final isWork = type == 'CDR';

    return ListTile(
      title: Text(profession['profession']),
      subtitle: Text('ANZSCO ${profession['code']}'),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isAcademic) const Icon(Icons.school),
          if (isWork) const Icon(Icons.work),
        ],
      ),
    );
  }
}
