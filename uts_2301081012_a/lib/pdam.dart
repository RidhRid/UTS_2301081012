// NAMA    : RIDHO FERNANDO
// NIM     : 2301081012
// KELAS   : TK2B

class Pdam {
  String kodePembayaran;
  String namaPelanggan;
  String jenisPelanggan;
  DateTime tglMasuk;
  int meterBulanIni;
  int meterBulanLalu;
  int meterPakai;
  int totalBayar;

  Pdam({
    required this.kodePembayaran,
    required this.namaPelanggan,
    required this.jenisPelanggan,
    required this.tglMasuk,
    required this.meterBulanIni,
    required this.meterBulanLalu,
  }) : meterPakai = 0,
       totalBayar = 0;

  void calculateMeterPakai() {
    meterPakai = meterBulanIni - meterBulanLalu;
  }

  void calculateTotalBayar() {
    int biayaPerMeter = 0;

    if (jenisPelanggan == 'GOLD') {
      if (meterPakai <= 10) biayaPerMeter = 5000;
      else if (meterPakai <= 20) biayaPerMeter = 10000;
      else biayaPerMeter = 20000;
    } else if (jenisPelanggan == 'SILVER') {
      if (meterPakai <= 10) biayaPerMeter = 4000;
      else if (meterPakai <= 20) biayaPerMeter = 8000;
      else biayaPerMeter = 10000;
    } else if (jenisPelanggan == 'UMUM') {
      if (meterPakai <= 10) biayaPerMeter = 2000;
      else if (meterPakai <= 20) biayaPerMeter = 3000;
      else biayaPerMeter = 5000;
    }

    totalBayar = meterPakai * biayaPerMeter;
  }
}
