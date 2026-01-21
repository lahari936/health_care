import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({Key? key}) : super(key: key);

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  String selectedTab = 'All';

  final billingData = [
    {
      'invoiceId': 'INV-001',
      'patientName': 'John Smith',
      'date': '14/08/2025',
      'amount': '\$150.00',
      'status': 'Paid',
      'description': 'Consultation',
    },
    {
      'invoiceId': 'INV-002',
      'patientName': 'Emily Davis',
      'date': '12/08/2025',
      'amount': '\$200.00',
      'status': 'Pending',
      'description': 'Follow-up Treatment',
    },
    {
      'invoiceId': 'INV-003',
      'patientName': 'Riya Sharma',
      'date': '10/08/2025',
      'amount': '\$120.00',
      'status': 'Overdue',
      'description': 'Lab Tests',
    },
    {
      'invoiceId': 'INV-004',
      'patientName': 'Priya Mehta',
      'date': '08/08/2025',
      'amount': '\$180.00',
      'status': 'Paid',
      'description': 'Prescription & Consultation',
    },
  ];

  List<Map<String, dynamic>> get filteredBilling {
    if (selectedTab == 'All') return billingData;
    return billingData
        .where(
          (item) =>
              item['status'].toString().toLowerCase() ==
              selectedTab.toLowerCase(),
        )
        .toList();
  }


  @override
Widget build(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 600;

      return Scaffold(
        backgroundColor: const Color(0xFFF6F8FB),
        body: Column(
          children: [
            // ✅ FIXED HEADER — TOPMOST
            _buildTopBar(),

            // ✅ ONLY THIS PART SCROLLS
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(isMobile ? 16 : 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Filter Tabs
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: ['All', 'Paid', 'Pending', 'Overdue']
                              .map(
                                (tab) => Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: FilterChip(
                                    label: Text(tab),
                                    selected: selectedTab == tab,
                                    onSelected: (_) {
                                      setState(() => selectedTab = tab);
                                    },
                                    backgroundColor: Colors.grey.shade200,
                                    selectedColor: const Color(0xFFB9D4FF),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Billing Content
                      isMobile
                          ? _buildMobileBillingList()
                          : _buildBillingTable(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}


  Widget _buildTopBar() {
    return Material(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Billing',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: const Color(0xFF222B45),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.download, color: Color(0xFF5A6474)),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('New Invoice'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB9D4FF),
                    foregroundColor: const Color(0xFF222B45),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillingTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Invoice ID')),
            DataColumn(label: Text('Patient Name')),
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Amount')),
            DataColumn(label: Text('Description')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Actions')),
          ],
          rows: filteredBilling
              .map(
                (bill) => DataRow(
                  cells: [
                    DataCell(Text(bill['invoiceId'])),
                    DataCell(Text(bill['patientName'])),
                    DataCell(Text(bill['date'])),
                    DataCell(Text(bill['amount'])),
                    DataCell(Text(bill['description'])),
                    DataCell(_buildStatusBadge(bill['status'])),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.visibility, size: 18),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, size: 18),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildMobileBillingList() {
    return Column(
      children: filteredBilling
          .map(
            (bill) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
                        Text(
                          bill['invoiceId'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        _buildStatusBadge(bill['status']),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Patient: ${bill['patientName']}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Date: ${bill['date']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Amount: ${bill['amount']}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.visibility, size: 16),
                          label: const Text('View'),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.edit, size: 16),
                          label: const Text('Edit'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'paid':
        bgColor = const Color(0xFFDEF3DD);
        textColor = const Color(0xFF0B7A1B);
        break;
      case 'pending':
        bgColor = const Color(0xFFFFF4D6);
        textColor = const Color(0xFF997400);
        break;
      case 'overdue':
        bgColor = const Color(0xFFFFDDDD);
        textColor = const Color(0xFFD32F2F);
        break;
      default:
        bgColor = Colors.grey.shade200;
        textColor = Colors.grey.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
