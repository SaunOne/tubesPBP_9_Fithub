import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd6_b_9/constant/colorCons.dart';
import 'package:ugd6_b_9/constant/styleText.dart';
import 'package:lottie/lottie.dart';
import 'package:ugd6_b_9/view/homePage.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final double hargaPaket = 750000.00;
  final double taxPercent = 0.01;
  String _selectedBank = 'BCA';

  @override
  Widget build(BuildContext context) {
    double taxAmount = hargaPaket * taxPercent;
    double total = hargaPaket + taxAmount;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Subscribe',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
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
                'Subscription',
                style: StyleText().styleH1bWithColor,
              ),
              Text(
                'Basic Package',
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
                    'IDR. 750.000,00',
                    style: StyleText().styleH3lWithColor,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Tax',
                    style: StyleText().styleH3bWithColor,
                  ),
                  Spacer(),
                  Text(
                    'IDR. 7.500,00 (1%)',
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
                    'IDR. 750.000,00',
                    style: StyleText().styleH3lWithColor,
                  ),
                ],
              ),
              SizedBox(height: 24),
              _buildBankSelection(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: FloatingActionButton.extended(
          onPressed: _showPaymentSuccessDialog,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih Pembayaran',
          style: StyleText().styleH3bWithColor,
        ),
        SizedBox(
          height: 0.02 * h,
        ),
        ..._buildPaymentOptions(),
      ],
    );
  }

  void _showPaymentSuccessDialog() {
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
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPaymentOptions() {
    return [
      Row(
        children: [
          Radio<String>(
            value: 'BCA',
            groupValue: _selectedBank,
            activeColor: ColorC().primaryColor1,
            onChanged: (value) {
              setState(() {
                _selectedBank = value!;
              });
            },
          ),
          Expanded(
            child: ListTile(
              leading:
                  Image.asset('assets/images/BCA.png', width: 72, height: 72),
              onTap: () {
                setState(() {
                  _selectedBank = 'BCA';
                });
              },
            ),
          ),
          Radio<String>(
            value: 'BNI',
            groupValue: _selectedBank,
            activeColor: ColorC().primaryColor1,
            onChanged: (value) {
              setState(() {
                _selectedBank = value!;
              });
            },
          ),
          Expanded(
            child: ListTile(
              leading:
                  Image.asset('assets/images/BNI.png', width: 72, height: 72),
              onTap: () {
                setState(() {
                  _selectedBank = 'BNI';
                });
              },
            ),
          ),
        ],
      ),
      Row(
        children: [
          Radio<String>(
            value: 'BRI',
            groupValue: _selectedBank,
            activeColor: ColorC().primaryColor1,
            onChanged: (value) {
              setState(() {
                _selectedBank = value!;
              });
            },
          ),
          Expanded(
            child: ListTile(
              leading:
                  Image.asset('assets/images/BRI.png', width: 72, height: 72),
              onTap: () {
                setState(() {
                  _selectedBank = 'BRI';
                });
              },
            ),
          ),
          Radio<String>(
            value: 'BPD DIY',
            groupValue: _selectedBank,
            activeColor: ColorC().primaryColor1,
            onChanged: (value) {
              setState(() {
                _selectedBank = value!;
              });
            },
          ),
          Expanded(
            child: ListTile(
              leading: Image.asset('assets/images/BANK DIY.png',
                  width: 92, height: 92),
              onTap: () {
                setState(() {
                  _selectedBank = 'BPD DIY';
                });
              },
            ),
          ),
        ],
      ),
    ];
  }
}
