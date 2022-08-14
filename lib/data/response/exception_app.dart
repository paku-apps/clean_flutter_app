class ExceptionApp implements Exception {
    int statusCode;
    String message;

    ExceptionApp(
      this.statusCode,
      this.message
    );
}