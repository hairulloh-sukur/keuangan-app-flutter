// {
//     "outlet_asal": "1",
//     "mata_uang": "IDR",
//     "jumlah": "3",
//     "Debet": "2200000000",
//     "Kredit": "1916959517"
// },

// outletAsal -> id nya outlet
// mataUang -> ctNama nya currency

class SaldoSum {
  String outletAsal;
  String mataUang;
  String jumlah;
  String debet;
  String kredit;

  SaldoSum({
    required this.outletAsal,
    required this.mataUang,
    required this.jumlah,
    required this.debet,
    required this.kredit,
  });
}

