import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

int _hitungPajakIsolate(int jumlahLoop) {
  int hasil = 0;
  for (int i = 0; i < jumlahLoop; i++) {
    hasil += i;
  }
  return (hasil % 1000000);
}

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  WebSocketChannel? _channel;
  String _btcPrice = 'Memuat...';
  bool _isCalculating = false;
  String _taxResult = '';
  StreamSubscription? _subscription;

  static const int _loopCount = 6 * 10000000;

  @override
  void initState() {
    super.initState();
    _connectWebSocket();
  }

  void _connectWebSocket() {
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse('wss://ws.coincap.io/prices?assets=bitcoin'),
      );
      _subscription = _channel!.stream.listen(
        (data) {
          final decoded = jsonDecode(data as String) as Map<String, dynamic>;
          final price = decoded['bitcoin'];
          if (price != null && mounted) {
            setState(() {
              final priceDouble = double.tryParse(price.toString()) ?? 0.0;
              _btcPrice = '\$${priceDouble.toStringAsFixed(2)}';
            });
          }
        },
        onError: (_) {
          if (mounted) setState(() => _btcPrice = 'Koneksi error');
        },
        onDone: () {
          Future.delayed(const Duration(seconds: 3), _connectWebSocket);
        },
      );
    } catch (_) {
      if (mounted) setState(() => _btcPrice = 'Gagal konek');
    }
  }

  Future<void> _hitungPajak() async {
    if (_isCalculating) return;
    setState(() {
      _isCalculating = true;
      _taxResult = '';
    });

    final hasil = await compute(_hitungPajakIsolate, _loopCount);

    if (mounted) {
      setState(() {
        _isCalculating = false;
        _taxResult = 'Simulasi Pajak Selesai!\n'
            'Berdasarkan Loop: ${_loopCount ~/ 1000000} Juta Iterasi\n'
            'Hasil Estimasi: \$$hasil';
      });
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _channel?.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F9FA), 
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.black, size: 20),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Crypto Market',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 22),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7931A).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.currency_bitcoin,
                            color: Color(0xFFF7931A), size: 30),
                      ),
                      const SizedBox(width: 15),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bitcoin',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'BTC / USD',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.trending_up, color: Colors.green),
                    ],
                  ),
                  const SizedBox(height: 25),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      _btcPrice,
                      key: ValueKey(_btcPrice),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF2D3436),
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                            color: Colors.green, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Live Update',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Fitur Perhitungan (Isolate)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2D3436),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    'Simulasi Beban Kerja Isolate',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _isCalculating ? null : _hitungPajak,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 0,
                      ),
                      child: _isCalculating
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.black),
                            )
                          : const Text("Mulai Kalkulasi",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  if (_taxResult.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _taxResult,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 25),

            Center(
              child: Text(
                'NIM: 20123006 | Rival',
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
