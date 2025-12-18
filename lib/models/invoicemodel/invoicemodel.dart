class InvoiceResponse {
  final String status;
  final String message;
  final List<InvoiceData> data;

  InvoiceResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory InvoiceResponse.fromJson(Map<String, dynamic> json) {
    return InvoiceResponse(
      status: json['status'] ?? "",
      message: json['message'] ?? "",
      data: (json['data'] as List<dynamic>)
          .map((item) => InvoiceData.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": data.map((e) => e.toJson()).toList(),
    };
  }
}

class InvoiceData {
  final String invoiceId;
  final String studentId;
  final String billNo;
  final String? ref;
  final String feesTypeId;
  final String title;
  final String description;
  final String amount;
  final String amountPaid;
  final String due;
  final String creationTimestamp;
  final String paymentTimestamp;
  final String paymentMethod;
  final String paymentDetails;
  final String status;
  final String year;
  final String? feesId;
  final String termId;
  final String? transportId;
  final String? routeName;
  final String? feeType;
  final String fillAmount;
  final String fillDiscount;

  InvoiceData({
    required this.invoiceId,
    required this.studentId,
    required this.billNo,
    this.ref,
    required this.feesTypeId,
    required this.title,
    required this.description,
    required this.amount,
    required this.amountPaid,
    required this.due,
    required this.creationTimestamp,
    required this.paymentTimestamp,
    required this.paymentMethod,
    required this.paymentDetails,
    required this.status,
    required this.year,
    this.feesId,
    required this.termId,
    this.transportId,
    this.routeName,
    this.feeType,
    required this.fillAmount,
    required this.fillDiscount,
  });

  factory InvoiceData.fromJson(Map<String, dynamic> json) {
    return InvoiceData(
      invoiceId: json['invoice_id'] ?? "",
      studentId: json['student_id'] ?? "",
      billNo: json['bill_no'] ?? "",
      ref: json['ref'],
      feesTypeId: json['fees_type_id'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      amount: json['amount'] ?? "",
      amountPaid: json['amount_paid'] ?? "",
      due: json['due'] ?? "",
      creationTimestamp: json['creation_timestamp'] ?? "",
      paymentTimestamp: json['payment_timestamp'] ?? "",
      paymentMethod: json['payment_method'] ?? "",
      paymentDetails: json['payment_details'] ?? "",
      status: json['status'] ?? "",
      year: json['year'] ?? "",
      feesId: json['fees_id'],
      termId: json['termid'] ?? "",
      transportId: json['transport_id'],
      routeName: json['route_name'],
      feeType: json['fee_type'],
      fillAmount: json['fill_amount'] ?? "",
      fillDiscount: json['fill_discount'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "invoice_id": invoiceId,
      "student_id": studentId,
      "bill_no": billNo,
      "ref": ref,
      "fees_type_id": feesTypeId,
      "title": title,
      "description": description,
      "amount": amount,
      "amount_paid": amountPaid,
      "due": due,
      "creation_timestamp": creationTimestamp,
      "payment_timestamp": paymentTimestamp,
      "payment_method": paymentMethod,
      "payment_details": paymentDetails,
      "status": status,
      "year": year,
      "fees_id": feesId,
      "termid": termId,
      "transport_id": transportId,
      "route_name": routeName,
      "fee_type": feeType,
      "fill_amount": fillAmount,
      "fill_discount": fillDiscount,
    };
  }
}
