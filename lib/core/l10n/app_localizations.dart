import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'uz_UZ': {
      // Auth
      'welcome': 'Xush kelibsiz!',
      'phone_number': 'Telefon raqam',
      'enter_phone': 'Telefon raqamingizni kiriting',
      'continue': 'Davom etish',
      'verify_code': 'Kodni tasdiqlang',
      'enter_code': 'SMS kodni kiriting',
      'resend_code': 'Kodni qayta yuborish',
      'passport_verify': 'Pasport ma\'lumotlari',
      'passport_series': 'Pasport seriya',
      'passport_number': 'Pasport raqam',
      'birth_date': 'Tug\'ilgan sana',
      'verify': 'Tasdiqlash',

      // Home
      'your_limit': 'Sizning limitingiz',
      'available': 'Mavjud',
      'apply_now': 'Ariza topshirish',

      // Profile
      'profile': 'Profil',
      'my_purchases': 'Xaridlarim',
      'scoring_history': 'Skoring tarixim',
      'about_us': 'Biz haqimizda',
      'contact': 'Bog\'lanish',
      'logout': 'Chiqish',
      'status': 'Status',
      'verified': 'Tasdiqlangan',

      // Bottom Nav
      'home': 'Asosiy',
      'catalog': 'Katalog',
      'cart': 'Savatcha',

      // General
      'sum': 'so\'m',
      'mln': 'mln',
      'loading': 'Yuklanmoqda...',
      'error': 'Xatolik yuz berdi',
      'try_again': 'Qayta urinish',
    },
    'ru_RU': {
      // Auth
      'welcome': 'Добро пожаловать!',
      'phone_number': 'Номер телефона',
      'enter_phone': 'Введите номер телефона',
      'continue': 'Продолжить',
      'verify_code': 'Подтвердите код',
      'enter_code': 'Введите SMS код',
      'resend_code': 'Отправить код повторно',
      'passport_verify': 'Паспортные данные',
      'passport_series': 'Серия паспорта',
      'passport_number': 'Номер паспорта',
      'birth_date': 'Дата рождения',
      'verify': 'Подтвердить',

      // Home
      'your_limit': 'Ваш лимит',
      'available': 'Доступно',
      'apply_now': 'Подать заявку',

      // Profile
      'profile': 'Профиль',
      'my_purchases': 'Мои покупки',
      'scoring_history': 'История скоринга',
      'about_us': 'О нас',
      'contact': 'Связаться',
      'logout': 'Выйти',
      'status': 'Статус',
      'verified': 'Подтвержден',

      // Bottom Nav
      'home': 'Главная',
      'catalog': 'Каталог',
      'cart': 'Корзина',

      // General
      'sum': 'сум',
      'mln': 'млн',
      'loading': 'Загрузка...',
      'error': 'Произошла ошибка',
      'try_again': 'Попробовать снова',
    },
    'en_US': {
      // Auth
      'welcome': 'Welcome!',
      'phone_number': 'Phone number',
      'enter_phone': 'Enter your phone number',
      'continue': 'Continue',
      'verify_code': 'Verify code',
      'enter_code': 'Enter SMS code',
      'resend_code': 'Resend code',
      'passport_verify': 'Passport verification',
      'passport_series': 'Passport series',
      'passport_number': 'Passport number',
      'birth_date': 'Birth date',
      'verify': 'Verify',

      // Home
      'your_limit': 'Your limit',
      'available': 'Available',
      'apply_now': 'Apply now',

      // Profile
      'profile': 'Profile',
      'my_purchases': 'My purchases',
      'scoring_history': 'Scoring history',
      'about_us': 'About us',
      'contact': 'Contact',
      'logout': 'Logout',
      'status': 'Status',
      'verified': 'Verified',

      // Bottom Nav
      'home': 'Home',
      'catalog': 'Catalog',
      'cart': 'Cart',

      // General
      'sum': 'UZS',
      'mln': 'mln',
      'loading': 'Loading...',
      'error': 'An error occurred',
      'try_again': 'Try again',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.toString()]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['uz', 'ru', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
