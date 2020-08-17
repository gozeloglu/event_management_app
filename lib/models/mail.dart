class Mail {
  const Mail({
    this.to,
    this.subject,
    this.body,
    this.qrCodeMsg,
  });

  final String to;
  final String subject;
  final String body;
  final String qrCodeMsg;
}
