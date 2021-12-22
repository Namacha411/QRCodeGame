import 'package:flutter/material.dart';

class QRCell extends StatefulWidget {
  const QRCell({Key? key, required this.cellSize, required this.isBlack}) : super(key: key);

  final double cellSize;
  final bool isBlack;

  @override
  State<QRCell> createState() => _QRCellState();
}

class _QRCellState extends State<QRCell> {
  bool? _isBlack;

  Color primaryColor() {
    if (_isBlack == null) {
      if (widget.isBlack) {
        _isBlack = true;
        return Colors.black;
      }
      _isBlack = false;
      return Colors.white;
    }
    if (_isBlack!) return Colors.black;
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.cellSize,
        height: widget.cellSize,
        child: ElevatedButton(
          onPressed: () => setState(() => _isBlack = !_isBlack!),
          style: ElevatedButton.styleFrom(
              primary: primaryColor(),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0))),
          child: const Text(""),
        ));
  }
}
