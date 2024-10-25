// NAMA    : RIDHO FERNANDO
// NIM     : 2301081012
// KELAS   : TK2B
import 'package:flutter/material.dart';
import 'pdam.dart';

void main() {
  runApp(PdamApp());
}

class PdamApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDAM',
      theme: ThemeData(primarySwatch: Colors.red),
      home: PdamForm(),
    );
  }
}

class PdamForm extends StatefulWidget {
  @override
  _PdamFormState createState() => _PdamFormState();
}

class _PdamFormState extends State<PdamForm> {
  final _formKey = GlobalKey<FormState>();
  final _kodeController = TextEditingController();
  final _namaController = TextEditingController();
  final _meterBulanIniController = TextEditingController();
  final _meterBulanLaluController = TextEditingController();
  final _tglMasukController = TextEditingController(); // Controller for date input as text
  String? _jenisPelanggan;
  DateTime? tglMasuk;
  int? _totalBayar;

  void _calculate() {
    if (_formKey.currentState?.validate() ?? false) {
     
      try {
        tglMasuk = DateTime.parse(_tglMasukController.text);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid date format. Use yyyy-mm-dd')),
        );
        return;
      }

      final pdam = Pdam(
        kodePembayaran: _kodeController.text,
        namaPelanggan: _namaController.text,
        jenisPelanggan: _jenisPelanggan!,
        tglMasuk: tglMasuk!,
        meterBulanIni: int.parse(_meterBulanIniController.text),
        meterBulanLalu: int.parse(_meterBulanLaluController.text),
      );

      pdam.calculateMeterPakai();
      pdam.calculateTotalBayar();

      setState(() {
        _totalBayar = pdam.totalBayar;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDAM Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _kodeController,
                decoration: InputDecoration(labelText: 'Kode Pembayaran'),
                validator: (value) => value == null || value.isEmpty ? 'Field is required' : null,
              ),
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama Pelanggan'),
                validator: (value) => value == null || value.isEmpty ? 'Field is required' : null,
              ),
              DropdownButtonFormField<String>(
                value: _jenisPelanggan,
                items: ['GOLD', 'SILVER', 'UMUM']
                    .map((jenis) => DropdownMenuItem(value: jenis, child: Text(jenis)))
                    .toList(),
                decoration: InputDecoration(labelText: 'Jenis Pelanggan'),
                onChanged: (value) => setState(() => _jenisPelanggan = value),
                validator: (value) => value == null ? 'Field is required' : null,
              ),
              TextFormField(
                controller: _tglMasukController,
                decoration: InputDecoration(labelText: 'Tanggal Masuk (yyyy-mm-dd)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field is required';
                  }
                  
                  try {
                    DateTime.parse(value);
                  } catch (e) {
                    return 'Invalid date format. Use yyyy-mm-dd';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _meterBulanIniController,
                decoration: InputDecoration(labelText: 'Meter Bulan Ini'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Field is required' : null,
              ),
              TextFormField(
                controller: _meterBulanLaluController,
                decoration: InputDecoration(labelText: 'Meter Bulan Lalu'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Field is required' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculate,
                child: Text('hasil'),
              ),
              if (_totalBayar != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Total Bayar: $_totalBayar', style: TextStyle(fontSize: 18)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
