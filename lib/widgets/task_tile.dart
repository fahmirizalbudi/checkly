import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/todo.dart';

class TaskTile extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6), // Tight vertical rhythm
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // Modern, slightly rounded
        border: Border.all(
          color: const Color(0xFFE2E8F0), // Subtle Slate-200
          width: 0.5,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onToggle,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Very compact
          child: Row(
            children: [
              // Minimal Checkbox
              Container(
                width: 18, // Smaller hit target
                height: 18,
                decoration: BoxDecoration(
                  color: todo.isDone ? const Color(0xFF3B82F6) : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: todo.isDone ? const Color(0xFF3B82F6) : const Color(0xFFCBD5E1),
                    width: 1.5,
                  ),
                ),
                child: todo.isDone
                    ? const Icon(
                        Icons.check,
                        size: 10,
                        color: Colors.white,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              // Compact Text
              Expanded(
                child: Text(
                  todo.title,
                  style: GoogleFonts.dmSans(
                    fontSize: 13, // Smaller font for density
                    fontWeight: FontWeight.w500,
                    color: todo.isDone ? const Color(0xFF94A3B8) : const Color(0xFF334155), // Slate-700
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                    decorationColor: const Color(0xFF94A3B8),
                  ),
                ),
              ),
              // Subtle Delete
              IconButton(
                icon: const Icon(
                  Icons.close_rounded, // Simple close icon
                  size: 16,
                  color: Color(0xFFCBD5E1),
                ),
                onPressed: onDelete,
                splashRadius: 16,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
