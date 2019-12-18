enum Status { 
  Buy , Sell
}
enum Payment{
  Perfect , Premium
}
class TransactionItem {

  final Status status;
  final DateTime time;
  final String amount;
  final Payment payment;
  final String transactionnumber;
  final String activationcode;

  const TransactionItem(this.status , this.time , this.amount , this.activationcode , this.payment , this.transactionnumber);
}