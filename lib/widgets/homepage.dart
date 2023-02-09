import 'package:catatanku/widgets/list_page.dart';
import 'package:catatanku/widgets/note_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    NotePage(),
    ListPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget _tabItem(Widget child, String label, {bool isSelected = false}) {
    return AnimatedContainer(
      margin: const EdgeInsets.all(8),
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          child,
          Text(
            label,
            style: const TextStyle(fontSize: 8),
          ),
        ],
      ),
    );
  }

  final List<String> _labels = ['Note', 'List'];

  @override
  Widget build(BuildContext context) {
    List<Widget> icons = const [
      Icon(Icons.note),
      Icon(Icons.list),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('NoteKu'),
        backgroundColor: const Color(0xff3F3B6C),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            color: const Color(0xff3F3B6C),
            child: TabBar(
              onTap: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              labelColor: Colors.white,
              unselectedLabelColor: const Color(0xff624F82),
              indicator:
                  const UnderlineTabIndicator(borderSide: BorderSide.none),
              tabs: [
                for (int i = 0; i < icons.length; i++)
                  _tabItem(
                    icons[i],
                    _labels[i],
                    isSelected: i == _selectedIndex,
                  ),
              ],
              controller: _tabController,
            ),
          ),
        ),
      ),
    );
  }
}
