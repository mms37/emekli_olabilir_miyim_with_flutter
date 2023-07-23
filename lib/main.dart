import 'package:flutter/material.dart';

void main() => runApp(EmekliOlabilirimApp());

class EmekliOlabilirimApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EmekliOlabilirimScreen(),
    );
  }
}

class EmekliOlabilirimScreen extends StatefulWidget {
  @override
  _EmekliOlabilirimScreenState createState() => _EmekliOlabilirimScreenState();
}

class _EmekliOlabilirimScreenState extends State<EmekliOlabilirimScreen> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _workYearsController = TextEditingController();
  final TextEditingController _primDaysController = TextEditingController();

  String _gender = 'Erkek';
  int _age = 0;
  int _workYears = 0;
  int _primDays = 0;

  void _checkEligibility() {
    setState(() {
      _age = int.tryParse(_ageController.text) ?? 0;
      _workYears = int.tryParse(_workYearsController.text) ?? 0;
      _primDays = int.tryParse(_primDaysController.text) ?? 0;

      bool isEligible = (_gender == 'Kadın' && _age >= 58 && _workYears >= 20 && _primDays >= 7200) ||
          (_gender == 'Erkek' && _age >= 60 && _workYears >= 25 && _primDays >= 7200);

      if (isEligible) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Emekli Olabilirsiniz'),
            content: Text('Tebrikler, emekli olabilirsiniz!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Tamam'),
              ),
            ],
          ),
        );
      } else {
        int remainingAge = (_gender == 'Kadın') ? (58 - _age) : (60 - _age);
        int remainingWorkYears = (_gender == 'Kadın') ? (20 - _workYears) : (25 - _workYears);
        int remainingPrimDays = 7200 - _primDays;

        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Emekli Olamazsınız'),
            content: Text('Kalan yaş: $remainingAge, Kalan çalışma yılı: $remainingWorkYears, Kalan prim günü: $remainingPrimDays'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Tamam'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Normal Şartlarda Ne Zaman Emekli Olabilirim?'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField(
              value: _gender,
              onChanged: (newValue) {
                setState(() {
                  _gender = newValue.toString();
                });
              },
              items: ['Erkek', 'Kadın'].map((gender) {
                return DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Yaşınız'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _workYearsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Çalışma Yılınız'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _primDaysController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Prim Gününüz'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _checkEligibility,
              child: Text('Emekli Olabilir miyim?'),
            ),
          ],
        ),
      ),
    );
  }
}
