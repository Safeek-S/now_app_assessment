enum AppRoute {
  loginScreen,
  signUpScreen,
  productScreen,
  retailerCheckinScreen,
  cartScreen,
  retailerSignupScreen
}

// Helper function to convert enum values to string
String enumToString(Object enumValue) => enumValue.toString().split('.').last;