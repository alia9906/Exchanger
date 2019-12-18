const String _MAIN_ENDPOINT = 'https://amirreza.liara.run/api';

const String CREATE_ACCOUNT = _MAIN_ENDPOINT + '/user';
const String VERIFY_PHONE_NUMBER = _MAIN_ENDPOINT + '/auth';
const String VERIFY_SENT_PHONE_NUMBER = _MAIN_ENDPOINT + '/user/verify';
const String TRANSACTION_LIST = _MAIN_ENDPOINT + '/';
const String PRICES = _MAIN_ENDPOINT + '/init';
const String BANK = _MAIN_ENDPOINT + '/bank';
const String PAYTYPES = BANK + '/paytypes';
const String BUY = BANK + '/buy';
const String SELL = BANK + '/sell';
const String REEDOM = _MAIN_ENDPOINT + "/user/reedom";
const String GETPERFECTORDERS = _MAIN_ENDPOINT + '/bank/getperfectmoney';
const String USEREDIT = _MAIN_ENDPOINT + '/user/edit';
const String CHATGET = _MAIN_ENDPOINT + '/ticket/user';
const String CHATPOST = _MAIN_ENDPOINT + '/ticket';
const String INBOX = _MAIN_ENDPOINT + '/user/inbox';
const String TRANSACTION = _MAIN_ENDPOINT + '/transection';

const List<String> USER_VERIFY_FILE = [
  _MAIN_ENDPOINT + '/file/upload/cardnumber',
  _MAIN_ENDPOINT + '/file/upload/nationalcode' , 
  _MAIN_ENDPOINT + '/file/upload/selfi'
];