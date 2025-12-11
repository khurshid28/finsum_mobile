# FinSum Mobile

Muddat to'lovga xarid qilish uchun mobil ilova. Flutter, Clean Architecture va BLoC bilan qurilgan.

## Xususiyatlari

### Texnologiyalar
- ✅ **Clean Architecture** - Domain, Data, Presentation qatlamlari
- ✅ **BLoC** - State management
- ✅ **GO Router** - Navigation
- ✅ **ScreenUtil** - Responsive dizayn
- ✅ **Shimmer** - Loading effektlari
- ✅ **Animations** - Smooth animatsiyalar (animate_do)
- ✅ **Dependency Injection** - GetIt
- ✅ **Multi-language** - O'zbekcha, Ruscha, Inglizcha
- ✅ **Theme** - Light/Dark rejim

### Funksiyalar
1. **Splash Screen** - Animatsiyali kirish ekrani
2. **Login** - Telefon raqam bilan kirish (+998)
3. **Verify** - 6 raqamli SMS kod tasdiqlash (2 minutlik timer)
4. **Passport** - MyID pasport tasdiqlash (AB 1234567, DD.MM.YYYY)
5. **Home** - Limit ko'rsatish, tez amallar
6. **Profile** - Foydalanuvchi ma'lumotlari:
   - Tasdiqlangan status
   - Telefon raqam
   - Xaridlarim
   - Skoring tarixim
   - Biz haqimizda
   - Bog'lanish
   - Til tanlash
   - Qorong'u rejim
   - Chiqish
7. **Catalog** - Mahsulotlar katalogi (demo)
8. **Cart** - Savatcha (demo)

### UI/UX
- 🎨 Zamonaviy gradient ranglari
- 🎯 Responsiv dizayn (ScreenUtil)
- ✨ Smooth animatsiyalar
- 💫 Shimmer loading effektlari
- 🎭 Light/Dark theme
- 🌐 3 til qo'llab-quvvatlash
- 📱 Beautiful icons

## O'rnatish

### 1. Dart SDK versiyasini tekshiring
```bash
flutter --version
```
SDK versiya: >=3.2.0 <4.0.0

### 2. Dependencies o'rnatish
```bash
flutter pub get
```

### 3. Font fayllarini qo'shish
`assets/fonts/` papkasiga Manrope font oilasini yuklab oling:
- Manrope-Regular.ttf
- Manrope-Medium.ttf
- Manrope-SemiBold.ttf
- Manrope-Bold.ttf
- Manrope-ExtraBold.ttf

**Download:** https://fonts.google.com/specimen/Manrope

### 4. Assets papkalarini yaratish
```bash
mkdir assets
mkdir assets/images
mkdir assets/icons
mkdir assets/fonts
```

### 5. Ilovani ishga tushirish
```bash
flutter run
```

## Loyiha strukturasi

```
lib/
├── core/
│   ├── di/                    # Dependency Injection
│   ├── l10n/                  # Localization
│   ├── router/                # Navigation (GO Router)
│   └── theme/                 # Theme va rangler
├── data/
│   ├── datasources/
│   │   ├── local/            # SharedPreferences
│   │   └── remote/           # API Client (Dio)
│   ├── models/               # Data models
│   └── repositories/         # Repository implementations
├── domain/
│   ├── repositories/         # Repository interfaces
│   └── usecases/            # Business logic
└── presentation/
    ├── blocs/               # BLoC state management
    ├── screens/             # UI ekranlari
    └── widgets/             # Reusable widgets
```

## Demo hisob ma'lumotlari

Ilova demo rejimida ishlaydi va haqiqiy backend'ga ulanmaydi.

### Login
- **Telefon:** Har qanday 9 raqamli raqam (+998 bilan)
- **Misol:** +998 90 123 45 67

### Verify Code
- **Kod:** Har qanday 6 raqamli kod
- **Misol:** 123456

### Passport
- **Seriya:** Har qanday 2 ta harf (katta)
- **Raqam:** Har qanday 7 raqamli son
- **Sana:** DD.MM.YYYY formatida
- **Misol:** AB 1234567, 20.10.1998

## Dependencies

```yaml
dependencies:
  flutter_bloc: ^8.1.3          # State management
  go_router: ^14.0.2            # Navigation
  flutter_screenutil: ^5.9.0    # Responsive
  dio: ^5.4.0                   # HTTP client
  shimmer: ^3.0.0               # Loading effects
  animate_do: ^3.1.2            # Animations
  get_it: ^7.6.4                # DI
  shared_preferences: ^2.2.2    # Local storage
  pin_code_fields: ^8.0.1       # PIN input
  mask_text_input_formatter: ^2.9.0  # Input masking
  intl: ^0.19.0                 # Formatting
```

## Ranglar palitasi

- **Primary:** #6C5CE7 (Binafsharang)
- **Secondary:** #00B894 (Yashil)
- **Accent:** #FD79A8 (Pushti)
- **Success:** #00B894
- **Error:** #FF7675
- **Warning:** #FDCB6E
- **Info:** #74B9FF

## Ekran rasmlari

1. **Splash** - Animatsiyali yuklash ekrani
2. **Login** - Telefon raqam kiritish
3. **Verify** - SMS kodni tasdiqlash
4. **Passport** - MyID tasdiqlash
5. **Home** - Limit va tez amallar
6. **Profile** - Profil sozlamalari

## Kelajakda qo'shilishi mumkin

- [ ] Backend integratsiya
- [ ] Real API calls
- [ ] Push notifications
- [ ] Biometrics authentication
- [ ] Product catalog
- [ ] Payment integration
- [ ] Order history
- [ ] Customer support chat

## Muallif

Flutter Developer | Clean Architecture | BLoC Pattern

---

**Note:** Bu demo loyiha bo'lib, haqiqiy backend'ga ulanmaydi. Barcha ma'lumotlar simulyatsiya qilingan.
