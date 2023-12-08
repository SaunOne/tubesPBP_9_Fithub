import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:lottie/lottie.dart';
import 'package:ugd6_b_9/database/Client/BankClient.dart';
import 'package:ugd6_b_9/database/Client/JenisPaketClient.dart';
import 'package:ugd6_b_9/database/Client/SubscriptionClient.dart';
import 'package:ugd6_b_9/database/Client/UserClient.dart';
import 'package:ugd6_b_9/entity/model/bank.dart';
import 'package:ugd6_b_9/entity/model/jenisPaket.dart';
import 'package:ugd6_b_9/entity/model/subscription.dart';
import 'package:ugd6_b_9/entity/model/user.dart';
import 'package:ugd6_b_9/view/content/notaView.dart';
import 'package:ugd6_b_9/view/homePage.dart';

class PaymentPage extends StatefulWidget {
  final int id_paket;
  const PaymentPage({Key? key, required this.id_paket}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  double totalHarga = 0;
  String _selectedBank = 'BCA';
  int? id_paket, id_user, id_member;
  late User user;
  Bank? bank ;
  JenisPaket? jenis_paket;
  int? indexRadio;
  int? id_bank;

  void hitungTotalHarga(harga, pajak) {
    totalHarga = harga + pajak;
  }

  Future<void> fetchAll() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    id_user = localStorage.getInt('id');
    id_member = id_user;
    await Query().getByUserId(id_user!).then((value) {
      setState(() {
        user = User(id: id_user!, fullname: value.fullname, username: value.username, email: value.email, password: value.password, birthdate: value.birthdate, gender: value.gender, phone: value.phone, weight: value.weight, height: value.height, photo: value.photo, trainerId: value.trainerId, memberId: value.id);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAll();

    id_paket = widget.id_paket;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Subscribe',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<JenisPaket>(
        future: JenisPaketClient().getJenisPaketById(id_paket!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Tampilkan indikator loading jika masih menunggu data
          } else if (snapshot.hasError) {
            print(snapshot);
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Text('Tidak ada data.');
          } else {
            JenisPaket jenisPaket = snapshot.data!;
            jenis_paket = jenisPaket;
            double harga = jenisPaket.harga -
                (jenisPaket.harga * (jenisPaket.promo / 100));
            hitungTotalHarga(harga, (jenisPaket.harga * 0.01));
            // print('isi mengajar : ${trainer[1].namaTrainer}');
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(height: 0.04 * h),
                    Lottie.asset(
                      'assets/payment.json',
                      width: 600,
                      height: 200,
                    ),
                    SizedBox(height: 0.03 * h),
                    Text(
                      'Rp.${jenisPaket.harga}',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Color.fromARGB(255, 255, 0,
                            0), // Opsional, bisa dihilangkan jika tidak diperlukan
                        decorationThickness:
                            2.0, // Opsional, bisa dihilangkan jika tidak diperlukan
                      ),
                    ),
                    Text(
                      'Rp.${harga}',
                      style: StyleText().styleH1bWithColor,
                    ),
                    Text(
                      '${jenisPaket.namaMembership}',
                      style: StyleText().styleH3lWithColor,
                    ),
                    SizedBox(
                      height: 0.03 * h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Price',
                          style: StyleText().styleH3bWithColor,
                        ),
                        Spacer(),
                        Text(
                          'IDR. ${harga}',
                          style: StyleText().styleH3lWithColor,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Tax 1%',
                          style: StyleText().styleH3bWithColor,
                        ),
                        Spacer(),
                        Text(
                          'IDR.${jenisPaket.harga * 0.01}',
                          style: StyleText().styleH3lWithColor,
                        ),
                      ],
                    ),
                    Divider(height: 24, thickness: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: StyleText().styleH3bWithColor,
                        ),
                        Text(
                          'IDR. ${totalHarga}',
                          style: StyleText().styleH3lWithColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    _buildBankSelection(),
                  ],
                ),
              ),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: FloatingActionButton.extended(
          onPressed: () {
            if (id_bank == null) {
              showFailureSnackbar(
                  context, 'Pilih Metode Pembayran Terlebih Dahulu!!');
            } else {
              var data = {
                "bank_id": id_bank,
                "jenis_paket_id": id_paket,
                "user_id": user.id,
                "membership_id": user.id
              };
              _showPaymentSuccessDialog(data,user,bank!,jenis_paket!);
            }
          },
          label: Text(
            'Bayar',
            style: StyleText().styleH3bWithColor,
          ),
          icon: Icon(Icons.payment),
          backgroundColor: const Color.fromARGB(255, 0, 68, 170),
        ),
      ),
    );
  }

  Widget _buildBankSelection() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return FutureBuilder<List<Bank>>(
      future: BankClient().showAllBanks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Tampilkan indikator loading jika masih menunggu data
        } else if (snapshot.hasError) {
          print(snapshot);
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('Tidak ada data.');
        } else {
          List<Bank> listBank = snapshot.data!;
          print('isi data bank : ${listBank.length}');
          // print('isi mengajar : ${trainer[1].namaTrainer}');
          return Container(
            width: double.infinity,
            height: 0.3 * h,

            padding: EdgeInsets.all(
                16.0), // Tambahkan padding agar teks tidak terlalu dekat dengan tepi
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Ganti ke CrossAxisAlignment.start
              mainAxisAlignment:
                  MainAxisAlignment.start, // Ganti ke MainAxisAlignment.start
              children: [
                Text(
                  'Pilih Pembayaran',
                  style: StyleText().styleH3bWithColor,
                ),
                SizedBox(
                  height: 0.02 * h,
                ),
                Expanded(
                    // Tambahkan Expanded untuk memberi ruang kepada GridView
                    child: // Indeks bank yang dipilih

                        GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 2.0,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  children: List.generate(listBank.length, (index) {
                    return RadioListTile(
                      value: index,
                      groupValue: indexRadio,
                      onChanged: (value) {
                        setState(() {
                          indexRadio = value as int;
                          id_bank = listBank[(value as int)].id;
                          print('id bank : ${id_bank}');
                          bank = listBank[value];
                        });
                      },
                      title: Center(
                        child: Column(
                          children: [
                            Image.asset(
                                'assets/images/bank/${listBank[index].namaBank}.png'),
                          ],
                        ),
                      ),
                    );
                  }),
                )),
              ],
            ),
          );
        }
      },
    );
  }

  void showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void showFailureSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showPaymentSuccessDialog(data,User user,Bank bank,JenisPaket jenisPaekt) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Payment Success'),
        content: Text('Your payment has been processed successfully.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  Subscription? subscription;
                  SubscriptionClient().createSubscription(data);
                  return NotaPage(bank: bank,jensiPaket: jenis_paket!,user: user,id_subscription: user.id,);
                }),
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
