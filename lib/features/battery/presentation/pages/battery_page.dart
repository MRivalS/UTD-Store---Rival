import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  static const _channel = MethodChannel('com.example.utd_store_rival/device');

  String _batteryLevel = '-';
  bool _isLoading = false;

  Future<void> _getBatteryLevel() async {
    setState(() => _isLoading = true);
    try {
      final int level = await _channel.invokeMethod('getBatteryLevel');
      if (mounted) setState(() => _batteryLevel = '$level%');
    } on PlatformException catch (e) {
      if (mounted) setState(() => _batteryLevel = 'Error: ${e.message}');
    } catch (_) {
      if (mounted) {
        setState(() => _batteryLevel = 'Tidak tersedia di platform ini');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _showNativeToast() async {
    try {
      await _channel.invokeMethod('showToast', {
        'message': 'Halo dari Flutter via Native Toast!',
      });
    } on PlatformException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Toast error: ${e.message}')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Native Toast hanya tersedia di Android'),
        ),
      );
    }
  }

  Color _batteryColor(String level) {
    final num = int.tryParse(level.replaceAll('%', '')) ?? -1;
    if (num < 0) return Colors.grey;
    if (num <= 20) return Colors.red;
    if (num <= 50) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Info Device',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1565C0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.07),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.battery_charging_full_rounded,
                    size: 80,
                    color: _batteryLevel == '-'
                        ? Colors.grey
                        : _batteryColor(_batteryLevel),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Level Baterai HP',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: Text(
                      _batteryLevel,
                      key: ValueKey(_batteryLevel),
                      style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                        color: _batteryLevel == '-'
                            ? Colors.grey
                            : _batteryColor(_batteryLevel),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _getBatteryLevel,
                      icon: _isLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                          : const Icon(Icons.refresh_rounded,
                              color: Colors.white),
                      label: Text(
                        _isLoading ? 'Membaca...' : 'Baca Level Baterai',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1565C0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.07),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.notifications_active_rounded,
                          color: Colors.orange, size: 28),
                      SizedBox(width: 10),
                      Text(
                        'Native Toast Android',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Memunculkan native Toast Android via MethodChannel dari kode Kotlin.',
                    style: TextStyle(
                        color: Colors.grey[600], fontSize: 13, height: 1.4),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _showNativeToast,
                      icon: const Icon(Icons.announcement_rounded,
                          color: Colors.white),
                      label: const Text(
                        'Tampilkan Native Toast',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Color(0xFF1565C0), size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Platform Channel: com.example.utd_store_rival/device\nImplementasi Kotlin ada di MainActivity.kt',
                      style: TextStyle(
                          color: Color(0xFF1565C0), fontSize: 12, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
