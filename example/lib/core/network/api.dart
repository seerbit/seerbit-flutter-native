class Api {
  const Api.dev() : host = "https://seerbitapi.com/";

String  getSandbox(String type) {
    switch (type) {
      case "CARD":
        return "sandbox";
      default:
        return "checkout";
    }
  }

  final String host;
}
