import 'package:flutter/material.dart';

class SearchBarApp extends StatefulWidget {
  final Function(String) onSubjectSelected;

  const SearchBarApp({Key? key, required this.onSubjectSelected})
      : super(key: key);

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            hintText: "Cari Mata Pelajaran",
            controller: controller,
            padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 10.0),
            ),
            onTap: () {
              controller.openView();
            },
            onChanged: (_) {
              controller.openView();
            },
            leading: const Icon(Icons.search),
            trailing: <Widget>[
              Tooltip(
                message: 'Change brightness mode',
                child: IconButton(
                  isSelected: isDark,
                  onPressed: () {
                    setState(() {
                      isDark = !isDark;
                    });
                  },
                  icon: const Icon(Icons.wb_sunny_outlined),
                  selectedIcon: const Icon(Icons.brightness_2_outlined),
                ),
              )
            ],
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return [
            "Matematika",
            "Bahasa Indonesia",
            "Bahasa Inggris",
          ].map((item) {
            return ListTile(
              title: Text(item),
              onTap: () {
                setState(() {
                  controller.closeView(item);
                  widget.onSubjectSelected(item);
                });
              },
            );
          }).toList();
        },
      ),
    );
  }
}
