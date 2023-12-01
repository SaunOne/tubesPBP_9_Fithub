import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PembayaranSubsPage extends StatelessWidget {
  final double hargaPaket = 750000.00;
  final double tax = 0.10;

  @override
  Widget build(BuildContext context) {
    double taxAmount = hargaPaket * tax;
    double total = hargaPaket + taxAmount;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pembelian'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Basic package IDR ${hargaPaket.toStringAsFixed(2)}'),
                Text('Tax IDR ${taxAmount.toStringAsFixed(2)}'),
                SizedBox(height: 8),
                Text('IDR ${total.toStringAsFixed(2)}',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(height: 24),
          Text('Pilih Pembayaran',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ListTile(
            leading: Icon(FontAwesomeIcons.ccVisa),
            title: Text('BCA'),
            trailing: Icon(Icons.radio_button_off),
            onTap: () {
              // Handle BCA payment option
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.ccMastercard),
            title: Text('BNI'),
            trailing: Icon(Icons.radio_button_off),
            onTap: () {
              // Handle BNI payment option
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.ccAmex),
            title: Text('BRI'),
            trailing: Icon(Icons.radio_button_off),
            onTap: () {
              // Handle BRI payment option
            },
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // Handle pay action
            },
            child: Text('Bayar'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(
                  double.infinity, 50), // Set the button to match parent width
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.comments),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.wallet),
            label: 'Subscribe',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.grip),
            label: 'Guide',
          ),
        ],
      ),
    );
  }
}
