import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/todo.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Todo> _todos = [
    Todo(id: '1', title: 'Buy groceries', isDone: false, category: 'Shopping'),
    Todo(id: '2', title: 'Finish design', isDone: true, category: 'Work'),
    Todo(id: '3', title: 'Call mom', isDone: false, category: 'Personal'),
    Todo(id: '4', title: 'Reply emails', isDone: false, category: 'Work'),
    Todo(id: '5', title: 'Team meeting', isDone: true, category: 'Work'),
  ];

  final List<String> _categories = ['All', 'Work', 'Personal', 'Shopping', 'Fitness'];
  int _selectedCategoryIndex = 0;

  final TextEditingController _taskController = TextEditingController();

  void _addTodo(String title, {String? category}) {
    if (title.isNotEmpty) {
      final selectedCategory = category ?? 
          (_categories[_selectedCategoryIndex] == 'All' ? 'Personal' : _categories[_selectedCategoryIndex]);
      
      setState(() {
        _todos.insert(0, Todo(
          id: DateTime.now().toString(),
          title: title,
          category: selectedCategory,
        ));
      });
      _taskController.clear();
      Navigator.pop(context);
    }
  }

  void _toggleTodo(Todo todo) {
    final index = _todos.indexOf(todo);
    if (index != -1) {
      setState(() {
        _todos[index].isDone = !_todos[index].isDone;
      });
    }
  }

  void _deleteTodo(Todo todo) {
    final index = _todos.indexOf(todo);
    if (index != -1) {
      setState(() {
        _todos.removeAt(index);
      });
    }
  }

  Future<String?> _showAddCategoryDialog() async {
    final TextEditingController categoryController = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        actionsPadding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          'New Category',
          style: GoogleFonts.dmSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E293B),
          ),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: categoryController,
            autofocus: true,
            style: GoogleFonts.dmSans(fontSize: 15),
            decoration: InputDecoration(
              hintText: 'Category name',
              hintStyle: GoogleFonts.dmSans(color: const Color(0xFF94A3B8), fontSize: 15),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 1.5),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.dmSans(
                color: const Color(0xFF64748B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, categoryController.text),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              'Add Category',
              style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddTaskSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        String selectedCategory = _categories[_selectedCategoryIndex] == 'All' 
            ? 'Personal' 
            : _categories[_selectedCategoryIndex];
            
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New Task',
                    style: GoogleFonts.dmSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _taskController,
                    autofocus: true,
                    style: GoogleFonts.dmSans(fontSize: 15),
                    decoration: InputDecoration(
                      hintText: 'What needs to be done?',
                      hintStyle: GoogleFonts.dmSans(color: const Color(0xFF94A3B8), fontSize: 15),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 1.5),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    onSubmitted: (value) => _addTodo(value, category: selectedCategory),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Category',
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    icon: const Icon(
                      cupertino.CupertinoIcons.chevron_down,
                      size: 18,
                      color: Color(0xFF64748B),
                    ),
                    dropdownColor: Colors.white,
                    elevation: 4,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 1.5),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    items: [
                      ..._categories.where((c) => c != 'All').map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(
                            category,
                            style: GoogleFonts.dmSans(
                              fontSize: 15,
                              color: const Color(0xFF1E293B),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        );
                      }),
                      DropdownMenuItem(
                        value: 'ADD_NEW_CATEGORY_SPECIAL_VALUE',
                        child: Row(
                          children: [
                            const Icon(cupertino.CupertinoIcons.add, size: 16, color: Color(0xFF3B82F6)),
                            const SizedBox(width: 8),
                            Text(
                              'New Category',
                              style: GoogleFonts.dmSans(
                                fontSize: 15,
                                color: const Color(0xFF3B82F6),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (value) async {
                      if (value == 'ADD_NEW_CATEGORY_SPECIAL_VALUE') {
                        final newCategory = await _showAddCategoryDialog();
                        if (newCategory != null && newCategory.isNotEmpty) {
                          setState(() {
                            if (!_categories.contains(newCategory)) {
                              _categories.add(newCategory);
                            }
                          });
                          setSheetState(() {
                            selectedCategory = newCategory;
                          });
                        }
                      } else if (value != null) {
                        setSheetState(() {
                          selectedCategory = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => _addTodo(_taskController.text, category: selectedCategory),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        'Add Task',
                        style: GoogleFonts.dmSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('EEEE, d MMMM').format(now);
    
    final filteredTodos = _selectedCategoryIndex == 0
        ? _todos
        : _todos.where((t) => t.category == _categories[_selectedCategoryIndex]).toList();
        
    final completedCount = filteredTodos.where((t) => t.isDone).length;
    final totalCount = filteredTodos.length;
    final progress = totalCount == 0 ? 0.0 : completedCount / totalCount;
    final percentage = (progress * 100).toInt();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Proportional Header (Increased padding, removed avatar)
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Checkly',
                    style: GoogleFonts.dmSans(
                      fontSize: 28, // Prominent greeting
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A), // Slate-900
                      letterSpacing: -0.5,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'You have $totalCount tasks to complete',
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B), // Slate-500
                    ),
                  ),
                ],
              ),
            ),

            // Large, Hero Stats Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6), // Brand Blue
                  borderRadius: BorderRadius.circular(24), // Larger radius for modern feel
                  // Subtle shadow only for depth, not heavy
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.25),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min, // Hug content
                      children: [
                        Text(
                          "Today's Progress",
                          style: GoogleFonts.dmSans(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '$completedCount',
                                style: GoogleFonts.dmSans(
                                  color: Colors.white,
                                  fontSize: 32, // Large number
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '/$totalCount',
                                style: GoogleFonts.dmSans(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Large Percentage Indicator
                    SizedBox(
                      height: 72, // Larger size
                      width: 72,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 8, // Thicker stroke
                            strokeCap: StrokeCap.round, // Rounded ends
                            backgroundColor: Colors.white.withValues(alpha: 0.15),
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                          Center(
                            child: Text(
                              "$percentage%",
                              style: GoogleFonts.dmSans(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16), // Good spacing

            // Categories (Proportional & Subtle)
            SizedBox(
              height: 32, // Compact height
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final isSelected = _selectedCategoryIndex == index;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF0F172A) : Colors.transparent, // Slate-900 for active
                        borderRadius: BorderRadius.circular(20),
                        border: isSelected
                            ? null
                            : Border.all(
                                color: const Color(0xFFE2E8F0), // Slate-200
                                width: 1,
                              ),
                      ),
                      child: Text(
                        _categories[index],
                        style: GoogleFonts.dmSans(
                          fontSize: 13, // Refined size
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : const Color(0xFF64748B), // Slate-500
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24), // Breathing room

            // Section Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4),
              child: Row(
                children: [
                  Text(
                    'Your Tasks',
                    style: GoogleFonts.dmSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    formattedDate,
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      color: const Color(0xFF94A3B8), // Slate-400
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Task List (Full width, clean)
            Expanded(
              child: filteredTodos.isEmpty
                  ? Center(
                      child: Text(
                        'No tasks for today',
                        style: GoogleFonts.dmSans(
                          color: const Color(0xFF94A3B8),
                          fontSize: 14,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4), // Consistent padding
                      itemCount: filteredTodos.length,
                      itemBuilder: (context, index) {
                        return TaskTile(
                          todo: filteredTodos[index],
                          onToggle: () => _toggleTodo(filteredTodos[index]),
                          onDelete: () => _deleteTodo(filteredTodos[index]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 48,
        height: 48,
        child: FloatingActionButton(
          onPressed: _showAddTaskSheet,
          backgroundColor: const Color(0xFF3B82F6),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: const CircleBorder(),
          child: const Icon(cupertino.CupertinoIcons.add, size: 24),
        ),
      ),
    );
  }
}
