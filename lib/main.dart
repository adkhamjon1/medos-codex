import 'package:flutter/material.dart';

void main() {
  runApp(const MedosApp());
}

class MedosApp extends StatelessWidget {
  const MedosApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF0F766E);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medos',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F8FA),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFD6DEE6)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFD6DEE6)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: seed, width: 1.6),
          ),
        ),
      ),
      home: const MedosHome(),
    );
  }
}

class MedosHome extends StatefulWidget {
  const MedosHome({super.key});

  @override
  State<MedosHome> createState() => _MedosHomeState();
}

class _MedosHomeState extends State<MedosHome> {
  int _tab = 0;

  final _weightController = TextEditingController(text: '18');
  final _ageController = TextEditingController(text: '5');
  final _doseController = TextEditingController(text: '10');
  final _frequencyController = TextEditingController(text: '3');
  final _patientController = TextEditingController(text: 'Bemor');
  final _drugController = TextEditingController(text: 'Paratsetamol');

  @override
  void dispose() {
    _weightController.dispose();
    _ageController.dispose();
    _doseController.dispose();
    _frequencyController.dispose();
    _patientController.dispose();
    _drugController.dispose();
    super.dispose();
  }

  double get _weight => _parse(_weightController.text);
  double get _dose => _parse(_doseController.text);
  double get _frequency => _parse(_frequencyController.text);
  double get _singleDoseMg => _weight * _dose;
  double get _dailyDoseMg => _singleDoseMg * _frequency;

  double _parse(String value) {
    return double.tryParse(value.replaceAll(',', '.').trim()) ?? 0;
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      CalculatorPage(
        weightController: _weightController,
        ageController: _ageController,
        doseController: _doseController,
        frequencyController: _frequencyController,
        onChanged: _refresh,
        singleDoseMg: _singleDoseMg,
        dailyDoseMg: _dailyDoseMg,
      ),
      PrescriptionPage(
        patientController: _patientController,
        drugController: _drugController,
        weightController: _weightController,
        ageController: _ageController,
        doseController: _doseController,
        frequencyController: _frequencyController,
        onChanged: _refresh,
        singleDoseMg: _singleDoseMg,
        dailyDoseMg: _dailyDoseMg,
      ),
      const ProtocolsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medos'),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'Ma\'lumot',
            icon: const Icon(Icons.info_outline),
            onPressed: () => showAboutDialog(
              context: context,
              applicationName: 'Medos',
              applicationVersion: '0.1.0',
              children: const [
                Text(
                  'Offline tibbiy yordamchi. Hisob-kitoblarni shifokor klinik holatga qarab tekshiradi.',
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(child: pages[_tab]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (value) => setState(() => _tab = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.calculate_outlined),
            selectedIcon: Icon(Icons.calculate),
            label: 'Hisob',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Retsept',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Protokol',
          ),
        ],
      ),
    );
  }
}

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({
    required this.weightController,
    required this.ageController,
    required this.doseController,
    required this.frequencyController,
    required this.onChanged,
    required this.singleDoseMg,
    required this.dailyDoseMg,
    super.key,
  });

  final TextEditingController weightController;
  final TextEditingController ageController;
  final TextEditingController doseController;
  final TextEditingController frequencyController;
  final VoidCallback onChanged;
  final double singleDoseMg;
  final double dailyDoseMg;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        const _Header(
          title: 'Doza hisoblash',
          subtitle: 'Vazn, mg/kg va qabul sonini kiriting.',
        ),
        const SizedBox(height: 12),
        _Panel(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _NumberField(
                      label: 'Vazn, kg',
                      controller: weightController,
                      onChanged: onChanged,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _NumberField(
                      label: 'Yosh',
                      controller: ageController,
                      onChanged: onChanged,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _NumberField(
                      label: 'Doza, mg/kg',
                      controller: doseController,
                      onChanged: onChanged,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _NumberField(
                      label: 'Kuniga marta',
                      controller: frequencyController,
                      onChanged: onChanged,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ResultTile(
                label: 'Bir martalik',
                value: '${_format(singleDoseMg)} mg',
                color: const Color(0xFF0F766E),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ResultTile(
                label: 'Kunlik jami',
                value: '${_format(dailyDoseMg)} mg',
                color: const Color(0xFF2563EB),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const _Notice(),
      ],
    );
  }
}

class PrescriptionPage extends StatelessWidget {
  const PrescriptionPage({
    required this.patientController,
    required this.drugController,
    required this.weightController,
    required this.ageController,
    required this.doseController,
    required this.frequencyController,
    required this.onChanged,
    required this.singleDoseMg,
    required this.dailyDoseMg,
    super.key,
  });

  final TextEditingController patientController;
  final TextEditingController drugController;
  final TextEditingController weightController;
  final TextEditingController ageController;
  final TextEditingController doseController;
  final TextEditingController frequencyController;
  final VoidCallback onChanged;
  final double singleDoseMg;
  final double dailyDoseMg;

  @override
  Widget build(BuildContext context) {
    final prescription = [
      'Bemor: ${patientController.text.trim()}',
      'Yosh: ${ageController.text.trim()} | Vazn: ${weightController.text.trim()} kg',
      'Dori: ${drugController.text.trim()}',
      'Doza: ${doseController.text.trim()} mg/kg',
      'Qabul: ${_format(singleDoseMg)} mg x ${frequencyController.text.trim()} marta/kun',
      'Kunlik jami: ${_format(dailyDoseMg)} mg',
    ].join('\n');

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        const _Header(
          title: 'Retsept',
          subtitle: 'Hisoblangan doza asosida qisqa yozuv.',
        ),
        const SizedBox(height: 12),
        _Panel(
          child: Column(
            children: [
              TextField(
                controller: patientController,
                onChanged: (_) => onChanged(),
                decoration: const InputDecoration(
                  labelText: 'Bemor ismi',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: drugController,
                onChanged: (_) => onChanged(),
                decoration: const InputDecoration(
                  labelText: 'Dori nomi',
                  prefixIcon: Icon(Icons.medication_outlined),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _Panel(
          child: SelectableText(
            prescription,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(height: 1.45),
          ),
        ),
      ],
    );
  }
}

class ProtocolsPage extends StatelessWidget {
  const ProtocolsPage({super.key});

  static const protocols = [
    ProtocolItem(
      title: 'Isitma',
      detail: 'Harorat, suyuqlik, umumiy ahvol va xavf belgilarini baholash.',
      accent: Color(0xFFDC2626),
      icon: Icons.thermostat,
    ),
    ProtocolItem(
      title: 'Yo\'tal',
      detail:
          'Nafas soni, auskultatsiya, saturatsiya va davomiylikni tekshirish.',
      accent: Color(0xFF7C3AED),
      icon: Icons.air,
    ),
    ProtocolItem(
      title: 'Diareya',
      detail: 'Suvsizlanish darajasi, ORS rejasi va kuzatuv mezonlari.',
      accent: Color(0xFF0891B2),
      icon: Icons.water_drop_outlined,
    ),
    ProtocolItem(
      title: 'Og\'riq',
      detail: 'Lokalizatsiya, intensivlik, davomiylik va red flag belgilar.',
      accent: Color(0xFFCA8A04),
      icon: Icons.healing_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        const _Header(
          title: 'Protokollar',
          subtitle: 'Tezkor klinik eslatmalar. Keyingi versiyada kengayadi.',
        ),
        const SizedBox(height: 12),
        for (final item in protocols) ...[
          _ProtocolTile(item: item),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class ProtocolItem {
  const ProtocolItem({
    required this.title,
    required this.detail,
    required this.accent,
    required this.icon,
  });

  final String title;
  final String detail;
  final Color accent;
  final IconData icon;
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF475569)),
          ),
        ],
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Padding(padding: const EdgeInsets.all(14), child: child),
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({
    required this.label,
    required this.controller,
    required this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (_) => onChanged(),
      decoration: InputDecoration(labelText: label),
    );
  }
}

class _ResultTile extends StatelessWidget {
  const _ResultTile({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white.withValues(alpha: 0.86),
              ),
            ),
            const SizedBox(height: 8),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.warning_amber_rounded, color: Color(0xFFB45309)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Hisob-kitob klinik qarorni almashtirmaydi. Doza, kontraindikatsiya va maksimal kunlik chegarani alohida tekshiring.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF713F12),
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProtocolTile extends StatelessWidget {
  const _ProtocolTile({required this.item});

  final ProtocolItem item;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: item.accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                width: 44,
                height: 44,
                child: Icon(item.icon, color: item.accent),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.detail,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF475569),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }
}

String _format(double value) {
  if (value == 0) {
    return '0';
  }
  if (value % 1 == 0) {
    return value.toStringAsFixed(0);
  }
  return value.toStringAsFixed(1);
}
