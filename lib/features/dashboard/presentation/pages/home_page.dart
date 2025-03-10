import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:solgensenapp/core/constants/app_colors.dart';
import 'package:solgensenapp/core/utils/responsive_layout.dart';
import 'package:solgensenapp/features/dashboard/presentation/widgets/appbar/custom_appbar.dart';
import 'package:solgensenapp/features/dashboard/presentation/widgets/bottom/bottom_navigation_bar.dart';
import 'package:solgensenapp/features/dashboard/presentation/widgets/drawer/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = ResponsiveLayout.isMobile(context);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      appBar: CustomAppbar(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSmallScreen)
            const SizedBox(
              width: 250,
              child: CustomDrawer(),
            ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick Stats Cards
                  Row(
                    children: [
                      _buildQuickStatCard(
                        'Low Stock Items',
                        '3',
                        'Items need attention',
                      ),
                      const SizedBox(width: 16),
                      _buildQuickStatCard(
                        'Delayed Shipments',
                        '14',
                        'Customer orders',
                      ),
                      const SizedBox(width: 16),
                      _buildQuickStatCard(
                        'Support Tickets',
                        '1',
                        'Pending tickets',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Monthly Payment Overview
                  _buildMonthlyPaymentChart(),
                  const SizedBox(height: 24),

                  // Bottom Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Monthly Sales Count
                      Expanded(
                        child: _buildMonthlySalesSection(),
                      ),
                      const SizedBox(width: 16),
                      // Active Projects
                      Expanded(
                        child: _buildActiveProjectsSection(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Right Sidebar
          if (!isSmallScreen)
            SizedBox(
              child: Container(
                width: 300,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    left: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                ),
                child: SingleChildScrollView(
                  child: _buildInventoryOverview(),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: isSmallScreen
          ? Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                      ..withValues(
                        alpha: (0.5 * 255),
                        //blurRadius: 10,
                      ),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: custom_navigation_bar(),
              ),
            )
          : null,
    );
  }

  Widget _buildQuickStatCard(String title, String value, String subtitle) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyPaymentChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Monthly Payment Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const months = [
                          'Sep',
                          'Oct',
                          'Nov',
                          'Dec',
                          'Jan',
                          'Feb'
                        ];
                        if (value.toInt() < months.length) {
                          return Text(months[value.toInt()]);
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      // FlSpot(0, 0),
                      //FlSpot(1, 0),
                      // FlSpot(2, 50),
                      // FlSpot(3, 40),
                      //FlSpot(4, 0),
                      //FlSpot(5, 30),
                    ],
                    isCurved: true,
                    color: Colors.pink,
                    barWidth: 3,
                    dotData: FlDotData(show: false),
                  ),
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 0),
                      FlSpot(1, 0),
                      FlSpot(2, 20),
                      FlSpot(3, 350),
                      FlSpot(4, 0),
                      FlSpot(5, 20),
                    ],
                    isCurved: true,
                    color: Colors.greenAccent,
                    barWidth: 3,
                    dotData: FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlySalesSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Monthly Sales Count',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          // Buraya sales grafiği
          Center(
            child: Text('Sales Chart Coming Soon'),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveProjectsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active Projects',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          // Buraya proje listesi
          Center(
            child: Text('Project List Coming Soon'),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryOverview() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Inventory Overview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '3 Items',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInventoryItem('#11223344', '42 in stock'),
          _buildInventoryItem('#213213213214', '97 in stock'),
          _buildInventoryItem('#23123123214145', '50 in stock'),
        ],
      ),
    );
  }

  Widget _buildInventoryItem(String code, String stock) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  code,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  stock,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange[700],
          ),
        ],
      ),
    );
  }
}
