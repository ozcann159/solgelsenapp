import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class FinanceSection extends StatelessWidget {
  const FinanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Finance Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 70,
                      color: Colors.pink,
                      title: 'Payable',
                      radius: 50,
                    ),
                    PieChartSectionData(
                      value: 30,
                      color: Colors.blue,
                      title: 'Receivable',
                      radius: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 