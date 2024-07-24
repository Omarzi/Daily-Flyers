import 'package:intl/intl.dart';

class DFormatter {

  static String formatTime(String time) {
    // Assuming the time string is in the format "HH:mm"
    final DateFormat inputFormat = DateFormat('HH:mm');
    final DateFormat outputFormat = DateFormat('h:mm a');

    final DateTime dateTime = inputFormat.parse(time);
    final String formattedTime = outputFormat.format(dateTime);

    return formattedTime;
  }

  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyy').format(date);
  }

  static String formatDateTime(String dateTimeString) {
    // Parse the input date string
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format the date
    String formattedDate = DateFormat('MMM dd, yyyy | hh:mm a').format(dateTime);

    return formattedDate;
  }


  static String? formatPhoneNumber(String? phoneNumber, String? selectedCountryCode) {
    if(phoneNumber!.isEmpty) {
      return 'You must fill out this field';
    } else if((selectedCountryCode == '+20' || selectedCountryCode == '+966') && phoneNumber.length != 10) {
      return 'You must fill in ten numbers';
    }
    return null;
  }

  static String? formatLocation(String? currentLocation) {
    if(currentLocation == 'Loading...') {
      return 'Wait for it to fetch the current location';
    }
    return null;
  }

  static String? formatUserName(String? userName) {
    if(userName!.isEmpty) {
      return 'You must fill out this field';
    } else if(userName.length < 2) {
      return 'You must enter a valid username';
    }
    return null;
  }

  static String? formatPassword(String? password) {
    if(password!.isEmpty) {
      return 'You must fill out this field';
    } else if(password.length < 2) {
      return 'You must enter a valid password';
    }
    return null;
  }

  static String? formatEmail(String? email) {
    if(email!.isEmpty) {
      return 'You must fill out this field';
    } else if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[com]").hasMatch(email)) {
      return 'You must fill this field in valid ex: example@gmail.com';
    }
    return null;
  }

  static String? formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);
  }

  // static String formatPhoneNumber(String phoneNumber) {
  //   /// Assuming a 10-digit US phone number format: (123) 456-7890
  //   if(phoneNumber.length == 10) {
  //     return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
  //   } else if(phoneNumber.length == 1) {
  //     return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
  //   }
  //   return phoneNumber;
  // }

  static String? formatterPhoneNumber(String phoneNumber) {
    if(phoneNumber.isEmpty) {
      return 'You must fill out this field';
    } else if(phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    }
    return 'You must fill out this field';
  }

  static String internationalFormatPhoneNumber(String phoneNumber) {
    /// Remove any non-digit characters from the phone number
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    /// Extract the country code from the digitsOnly
    String countryCode = '+${digitsOnly.substring(0, 2)}';
    digitsOnly = digitsOnly.substring(2);

    /// Add the remaining digits with proper formatting
    final formattedNumber = StringBuffer();
    formattedNumber.write('($countryCode)');

    int i = 0;
    while(i < digitsOnly.length) {
      int groupLength = 2;
      if(i == 0 && countryCode == '+1') {
        groupLength = 3;
      }

      int end = i + groupLength;
      formattedNumber.write(digitsOnly.substring(i, end));

      if(end < digitsOnly.length) {
        formattedNumber.write(' ');
      }
      i = end;
    }
    return digitsOnly;
  }
}