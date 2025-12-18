import 'package:amore_student_erp/datalayer.dart/apicalls.dart';
import 'package:amore_student_erp/models/invoicemodel/invoicemodel.dart';
import 'package:amore_student_erp/others/clors.dart';
import 'package:flutter/material.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key? key,  this.studentId}) : super(key: key);

  final String? studentId;
  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  List<InvoiceData> _invoices = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _fetchInvoices();
  }

 
  Future<void> _fetchInvoices() async {
  print(" Fetching invoices for student: ${widget.studentId!}");

  setState(() {
    _isLoading = true;
    _errorMessage = '';
  });

  try {
    final response = await getStudentInvoice(widget.studentId!);

    if (response != null) {
      print(" Invoices fetched successfully");
      print(" Invoice Count: ${response.data.length}");

      setState(() {
        _invoices = response.data;
        _isLoading = false;
      });
    } else {
      print(" Fetch failed: Null response");
      setState(() {
        _errorMessage = 'Failed to fetch invoices';
        _isLoading = false;
      });
    }
  } catch (e) {
    print(" Error fetching invoices: $e");
    setState(() {
      _errorMessage = 'Error: ${e.toString()}';
      _isLoading = false;
    });
  }
}


  List<InvoiceData> get _filteredInvoices {
    if (_selectedFilter == 'All') {
      return _invoices;
    }
    return _invoices
        .where((invoice) =>
            invoice.status.toLowerCase() == _selectedFilter.toLowerCase())
        .toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Appcolor.green;
      case 'unpaid':
        return Appcolor.red;
      case 'partial':
        return Appcolor.orange;
      default:
        return Appcolor.lightgrey;
    }
  }

  void _showInvoiceDetails(InvoiceData invoice) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Invoice Details',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getStatusColor(invoice.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      invoice.status.toUpperCase(),
                      style: TextStyle(
                        color: _getStatusColor(invoice.status),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 30),
              _buildDetailRow('Bill No', invoice.billNo),
              _buildDetailRow('Invoice ID', invoice.invoiceId),
              _buildDetailRow('Title', invoice.title),
              _buildDetailRow('Description', invoice.description),
              if (invoice.feeType != null)
                _buildDetailRow('Fee Type', invoice.feeType!),
              if (invoice.routeName != null)
                _buildDetailRow('Route', invoice.routeName!),
              const Divider(height: 30),
              _buildDetailRow('Amount', '₹${invoice.amount}'),
              _buildDetailRow('Amount Paid', '₹${invoice.amountPaid}'),
              _buildDetailRow('Due', '₹${invoice.due}',
                  valueColor:
                      invoice.due != '0' ? Appcolor.red : Appcolor.green),
              if (invoice.fillDiscount != '0')
                _buildDetailRow('Discount', '₹${invoice.fillDiscount}'),
              const Divider(height: 30),
              _buildDetailRow(
                  'Created On', _formatTimestamp(invoice.creationTimestamp)),
              if (invoice.paymentTimestamp.isNotEmpty)
                _buildDetailRow(
                    'Paid On', _formatTimestamp(invoice.paymentTimestamp)),
              if (invoice.paymentMethod.isNotEmpty)
                _buildDetailRow('Payment Method', invoice.paymentMethod),
              if (invoice.paymentDetails.isNotEmpty)
                _buildDetailRow('Payment Details', invoice.paymentDetails),
              const SizedBox(height: 30),
              if (invoice.status.toLowerCase() != 'paid')
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _processPayment(invoice);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.blue,
                      foregroundColor: Appcolor.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Make Payment',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor ?? Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(String timestamp) {
    if (timestamp.isEmpty) return 'N/A';
    try {
      final parts = timestamp.split(' ');
      return '${parts[0]} at ${parts[1]}';
    } catch (e) {
      return timestamp;
    }
  }

  void _processPayment(InvoiceData invoice) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Process Payment'),
        content: Text(
            'Process payment for ${invoice.title}?\nAmount Due: ₹${invoice.due}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Payment gateway would open here'),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            child: const Text('Proceed'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
        backgroundColor: Appcolor.blue,
        foregroundColor: Appcolor.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Appcolor.blue,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                _buildFilterChip('All'),
                const SizedBox(width: 8),
                _buildFilterChip('Paid'),
                const SizedBox(width: 8),
                _buildFilterChip('Unpaid'),
                const SizedBox(width: 8),
                _buildFilterChip('Partial'),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage.isNotEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline,
                                size: 60, color: Appcolor.red),
                            const SizedBox(height: 16),
                            Text(_errorMessage),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _fetchInvoices,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : _filteredInvoices.isEmpty
                    
                        ? const Center(
                            child: Text(
                              'No invoices found',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: _fetchInvoices,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: _filteredInvoices.length,
                              itemBuilder: (context, index) {
                                final invoice = _filteredInvoices[index];
                                return _buildInvoiceCard(invoice);
                              },
                            ),
                          ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Appcolor.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Appcolor.black : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceCard(InvoiceData invoice) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: InkWell(
        onTap: () => _showInvoiceDetails(invoice),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      invoice.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(invoice.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      invoice.status.toUpperCase(),
                      style: TextStyle(
                        color: _getStatusColor(invoice.status),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                invoice.description,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.receipt_long, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    invoice.billNo,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const Spacer(),
                  const Icon(Icons.calendar_today,
                      size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    invoice.creationTimestamp.split(' ')[0],
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
              const Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      Text(
                        '₹${invoice.amount}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (invoice.due != '0')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Due',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                        Text(
                          '₹${invoice.due}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
