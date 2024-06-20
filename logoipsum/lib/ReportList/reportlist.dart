//
import 'package:flutter/material.dart';
import 'package:logoipsum/ReportList/Domain/datasource/local/profession.dart';
import 'package:logoipsum/ReportList/widgets/reporttile.dart';

class ReportList extends StatefulWidget {
  final String reportType;

  const ReportList({super.key, required this.reportType});

  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  List<dynamic> filteredProfessions = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProfessions = professionsData['professions']
        .where((profession) => profession['type'] == widget.reportType)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Profession',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by Profession or ANZSCO Code',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  filteredProfessions = professionsData['professions']
                      .where((profession) =>
                          profession['type'] == widget.reportType &&
                          (profession['profession']
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              profession['code'].toString().contains(value)))
                      .toList();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProfessions.length,
              itemBuilder: (context, index) {
                final profession = filteredProfessions[index];
                return ReportTile(profession: profession);
              },
            ),
          ),
        ],
      ),
    );
  }
}
