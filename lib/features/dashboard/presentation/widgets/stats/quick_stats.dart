import 'package:flutter/material.dart';
import 'stat_card.dart';
import 'package:solgensenapp/core/utils/responsive_layout.dart';
import 'package:solgensenapp/core/utils/responsive_breakpoints.dart';

class QuickStats extends StatelessWidget {
  const QuickStats({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = ResponsiveLayout.isMobile(context);

    return Container(
      padding: ResponsiveBreakpoints.getPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Stats',
            style: TextStyle(
              fontSize: ResponsiveBreakpoints.getFontSize(
                context,
                mobile: 20,
                tablet: 24,
                desktop: 28,
              ),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              if (isSmallScreen) ...[
                _buildQuickStatCard(
                  'Low Stock Items',
                  '3',
                  'Items need attention',
                  Colors.orange,
                ),
              ],
              if (!isSmallScreen) ...[
                _buildQuickStatCard(
                  'Low Stock Items',
                  '3',
                  'Items need attention',
                  Colors.orange,
                ),
                const SizedBox(width: 16),
                _buildQuickStatCard(
                  'Delayed Shipments',
                  '14',
                  'Customer orders',
                  Colors.red,
                ),
                const SizedBox(width: 16),
                _buildQuickStatCard(
                  'Support Tickets',
                  '1',
                  'Pending tickets',
                  Colors.blue,
                ),
              ],
            ],
          )
        ],
      ),
    );
  }

  Widget _buildQuickStatCard(
      String title, String value, String subtitle, Color color) {
    return Expanded(
      child: StatCard(
        title: title,
        value: value,
        icon: Icons.inventory,
        color: color,
      ),
    );
  }
}
