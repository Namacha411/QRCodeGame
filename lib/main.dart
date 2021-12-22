import 'package:flutter/material.dart';
import 'package:qr_code_game/qr_cell.dart';

import 'package:qr/qr.dart';
import 'package:tuple/tuple.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "QR Code Game",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: "QR Code Game"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Tuple2<QrImage, int> makeQRCode(String data) {
    QrCode qrCode = QrCode(3, QrErrorCorrectLevel.M);
    qrCode.addData(data);
    return Tuple2(QrImage(qrCode), qrCode.moduleCount);
  }

  var _qr = Tuple2(QrImage(QrCode(1, QrErrorCorrectLevel.L)), 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(flex: 1),
            SizedBox(
                width: 500,
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "QR code data"),
                  onFieldSubmitted: (String? str) {
                    debugPrint(str);
                    if (str == null) return;
                    setState(() {
                      _qr = makeQRCode(str);
                    });
                  },
                )),
            const Spacer(flex: 1),
            for (var y = 0; y < _qr.item2; y++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var x = 0; x < _qr.item2; x++)
                    QRCell(
                      cellSize: 20.0,
                      isBlack: _qr.item1.isDark(y, x),
                    )
                ],
              ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
