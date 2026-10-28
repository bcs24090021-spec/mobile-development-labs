import 'package:flutter/cupertino.dart'
    show
        CupertinoColors,
        showCupertinoModalPopup,
        CupertinoDatePicker,
        CupertinoDatePickerMode,
        CupertinoPicker,
        FixedExtentScrollController;
import 'package:flutter/material.dart';

void main() {
  runApp(const StudentInfoApp());
}

class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSS3344 Lab 02',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const StudentProfileScreen(),
    );
  }
}

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? _buildPortraitView()
                : _buildLandscapeView();
          },
        ),
      ),
    );
  }

  Widget _buildPortraitView() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 8,
          color: Colors.white.withValues(alpha: 0.92),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                StudentDetailsSection(),
                Divider(height: 32, thickness: 1),
                LocationDetailsSection(),
                Divider(height: 32, thickness: 1),
                PickersSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLandscapeView() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 8,
          color: Colors.white.withValues(alpha: 0.92),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(
                  child: StudentDetailsSection(),
                ),
                SizedBox(width: 24),
                IntrinsicHeight(
                  child: VerticalDivider(width: 1, thickness: 1),
                ),
                SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LocationDetailsSection(),
                      Divider(height: 32, thickness: 1),
                      PickersSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StudentDetailsSection extends StatelessWidget {
  const StudentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/profile.png'),
        ),
        SizedBox(height: 20),
        Text(
          'ANGELA NGUI XUE LING',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Student ID: BCS24090021',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        Divider(height: 32, thickness: 1),
        Text(
          'Personal Life Goal / Quote:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '"KEEP GOING ON!"',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontStyle: FontStyle.italic,
            color: Colors.indigo,
          ),
        ),
      ],
    );
  }
}

class LocationDetailsSection extends StatelessWidget {
  const LocationDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Location Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        TitleSection(
          name: 'University of Technology Sarawak (UTS)',
          location: 'Sibu, Sarawak, Malaysia',
          starCount: 41,
        ),
        SizedBox(height: 12),
        ImageSection(imagePath: 'assets/uts.jpg'),
      ],
    );
  }
}

class ImageSection extends StatelessWidget {
  final String imagePath;
  const ImageSection({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        imagePath,
        width: double.infinity,
        height: 180,
        fit: BoxFit.cover,
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  final String name;
  final String location;
  final int starCount;

  const TitleSection({
    super.key,
    required this.name,
    required this.location,
    required this.starCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Icon(Icons.star, color: Colors.indigo[400]),
          const SizedBox(width: 4),
          Text('$starCount'),
        ],
      ),
    );
  }
}

class PickersSection extends StatefulWidget {
  const PickersSection({super.key});

  @override
  State<PickersSection> createState() => _PickersSectionState();
}

class _PickersSectionState extends State<PickersSection> {
  DateTime _selectedDate = DateTime.now();
  String _selectedRole = 'Student';

  // 1. Material Date Picker
  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // 2. Cupertino Date Picker (Modal Sheet)
  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 240,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: _selectedDate,
          onDateTimeChanged: (DateTime newDate) {
            setState(() => _selectedDate = newDate);
          },
        ),
      ),
    );
  }

  // 4. Cupertino Picker (Wheel)
  void _showCupertinoRolePicker(BuildContext context) {
    final List<String> roles = ['Student', 'Developer', 'Designer'];
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 200,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoPicker(
          itemExtent: 32,
          scrollController: FixedExtentScrollController(
            initialItem: roles.indexOf(_selectedRole),
          ),
          onSelectedItemChanged: (int index) {
            setState(() => _selectedRole = roles[index]);
          },
          children: roles.map((role) => Center(child: Text(role))).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pickers: Material vs. Cupertino',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selected Date: $formattedDate',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                'Selected Role: $_selectedRole',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Date Pickers:',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton.icon(
              onPressed: () => _selectMaterialDate(context),
              icon: const Icon(Icons.date_range),
              label: const Text('Material Date'),
            ),
            OutlinedButton.icon(
              onPressed: () => _showCupertinoDatePicker(context),
              icon: const Icon(Icons.calendar_today),
              label: const Text('Cupertino Date'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Selection Pickers:',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          runSpacing: 8,
          children: [
            // 3. Material DropdownButton
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Material: '),
                DropdownButton<String>(
                  value: _selectedRole,
                  items: ['Student', 'Developer', 'Designer'].map((String role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() => _selectedRole = newValue);
                    }
                  },
                ),
              ],
            ),
            // 4. Cupertino Role Wheel Picker
            OutlinedButton.icon(
              onPressed: () => _showCupertinoRolePicker(context),
              icon: const Icon(Icons.unfold_more),
              label: const Text('Cupertino Wheel'),
            ),
          ],
        ),
      ],
    );
  }
}
