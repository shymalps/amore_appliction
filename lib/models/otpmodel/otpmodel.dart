class OtpResponse {
  final String status;   // To hold the status of the response
  final String message;  // To hold the message of the response
  final OtpData data;    // To hold the data containing the OTP

  // Constructor to initialize the model
  OtpResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  // Factory constructor to create an OtpResponse from JSON
  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      status: json['status'],
      message: json['message'],
      data: OtpData.fromJson(json['data']),  // Parse the 'data' field
    );
  }

  // Method to convert OtpResponse to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),  // Convert 'data' to JSON
    };
  }
}

class OtpData {
  final int otp; // To hold the OTP value

  // Constructor to initialize the model
  OtpData({
    required this.otp,
  });

  // Factory constructor to create an OtpData from JSON
  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(
      otp: json['otp'],  // Parse the OTP value
    );
  }

  // Method to convert OtpData to JSON
  Map<String, dynamic> toJson() {
    return {
      'otp': otp,  // Return the OTP value
    };
  }
}
