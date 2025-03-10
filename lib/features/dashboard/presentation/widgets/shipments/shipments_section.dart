import 'package:flutter/material.dart';


class ShipmentsSection extends StatelessWidget {
  const ShipmentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delayed Shipments',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildShipmentItem('123', 'Nov. 16, 2024'),
            _buildShipmentItem('1255', 'Nov. 9, 2024'),
            _buildShipmentItem('3484758934', 'Nov. 9, 2024'),
          ],
        ),
      ),
    );
  }

  Widget _buildShipmentItem(String id, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(id),
          Text('Planned: $date'),
        ],
      ),
    );
  }
} 