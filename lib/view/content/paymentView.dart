import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: PaymentPage(),
    );
  }
}

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Subscribe', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          SizedBox(height: 24),
          _buildPriceInformation('Total', 'IDR. 750,000.00', isTotal: true),
          _buildPriceInformation('Basic package', 'IDR. 750,000.00'),
          _buildPriceInformation('Tax', '1% IDR. 7,500.00'),
          Divider(height: 24, thickness: 2),
          _buildPriceInformation('IDR. 757,500.00', '', isTotal: true),
          SizedBox(height: 24),
          _buildBankSelection(),
          SizedBox(height: 24),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: FloatingActionButton.extended(
          onPressed: _showPaymentSuccessDialog,
          label: Text(
            'Bayar',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          icon: Icon(Icons.payment),
          backgroundColor: Colors.blue,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () {}),
            IconButton(icon: Icon(Icons.chat), onPressed: () {}),
            IconButton(icon: Icon(Icons.credit_card), onPressed: () {}),
            IconButton(icon: Icon(Icons.info_outline), onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceInformation(String title, String price,
      {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isTotal ? 18.sp : 16.sp,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: isTotal ? 18.sp : 16.sp,
              fontWeight: FontWeight.bold,
              color: title == 'Tax' ? Colors.red : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih Pembayaran',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
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
              Navigator.of(context).pop();
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
            onChanged: (value) {
              setState(() {
                _selectedBank = value!;
              });
            },
          ),
          Expanded(
            child: ListTile(
              leading:
                  Image.asset('assets/LogoBank/BCA.png', width: 72, height: 72),
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
            onChanged: (value) {
              setState(() {
                _selectedBank = value!;
              });
            },
          ),
          Expanded(
            child: ListTile(
              leading:
                  Image.asset('assets/LogoBank/BNI.png', width: 72, height: 72),
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
            onChanged: (value) {
              setState(() {
                _selectedBank = value!;
              });
            },
          ),
          Expanded(
            child: ListTile(
              leading:
                  Image.asset('assets/LogoBank/BRI.png', width: 72, height: 72),
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
            onChanged: (value) {
              setState(() {
                _selectedBank = value!;
              });
            },
          ),
          Expanded(
            child: ListTile(
              leading: Image.asset('assets/LogoBank/BANK DIY.png',
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

void main() {
  runApp(
    MaterialApp(
      home: PaymentPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}