import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/todo.dart';

class AddTodoPage extends StatefulWidget {
  final Todo? todo;
  final Function(Todo) onSave;

  const AddTodoPage({super.key, this.todo, required this.onSave});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late DateTime _deadline;
  late String _category;
  late bool _isDone;

  final List<String> _categories = ['Umum', 'Pekerjaan', 'Pribadi', 'Urgent'];

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    _titleController = TextEditingController(text: todo?.title ?? '');
    _descController = TextEditingController(text: todo?.description ?? '');
    _deadline = todo?.deadline ?? DateTime.now();
    _category = todo?.category ?? 'Umum';
    _isDone = todo?.isDone ?? false;
  }

  Future<void> _pickDeadline() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _deadline,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _deadline = picked);
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final todo = Todo(
        id: widget.todo?.id,
        title: _titleController.text,
        description: _descController.text,
        deadline: _deadline,
        category: _category,
        isDone: _isDone,
      );
      widget.onSave(todo);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.todo != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Tugas' : 'Tambah Tugas',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: const Color.fromARGB(255, 215, 123, 233),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Judul'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Judul tidak boleh kosong'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickDeadline,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Deadline',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    controller: TextEditingController(
                      text: _deadline.toLocal().toString().split(' ')[0],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Kategori'),
                value: _category,
                items: _categories
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _category = value);
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Tugas Selesai?'),
                value: _isDone,
                onChanged: (value) => setState(() => _isDone = value),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: Icon(isEditing ? Icons.edit : Icons.save),
                label: Text(isEditing ? 'Perbarui' : 'Simpan'),
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: GoogleFonts.poppins(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
