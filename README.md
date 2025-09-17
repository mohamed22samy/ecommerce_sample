# E-Commerce Flutter App

A simple e-commerce mobile app built with Flutter using BLoC pattern for state management.

## What the app does

- Browse products from an online store
- Add items to shopping cart
- View and manage cart items
- Switch between Arabic and English
- Change between light and dark themes
- User profile settings

The app gets product data from a free API and saves cart items locally on the phone.

## How I organized the code

I tried to keep things organized by separating different parts:

```
lib/
├── core/                    # Shared stuff used everywhere
│   ├── blocs/              # Theme management
│   ├── models/             # Data structures
│   ├── services/           # Cart service, API calls
│   ├── utils/              # Colors, strings, constants
│   └── widgets/            # Reusable UI components
├── features/               # Main app features
│   ├── home/              # Home screen and related stuff
│   ├── card/              # Shopping cart
│   └── profile/           # User profile
└── main.dart              # App starts here
```

## Why I chose BLoC for state management

I decided to use BLoC pattern because:

1. **It separates UI from business logic** - The screen widgets don't need to know how data is fetched or processed
2. **Easy to test** - I can test the business logic without worrying about UI
3. **Predictable** - Data flows in one direction, so it's easier to track what's happening
4. **Good for learning** - It's the official Flutter recommendation and has good documentation

Here's a simple example of how I used it:

```dart
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<GetProductsEvent>(_getProducts);
  }

  Future<void> _getProducts(GetProductsEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(productsStatus: RequestStatus.loading));
    try {
      final products = await _productRepository.getProducts();
      emit(state.copyWith(products: products, productsStatus: RequestStatus.loaded));
    } catch (e) {
      emit(state.copyWith(productsStatus: RequestStatus.error));
    }
  }
}
```

## API I used

I used a free fake store API to get product data:

- **API**: https://fakestoreapi.com
- **What I get**:
  - `/products` - All products
  - `/products/categories` - Product categories

Simple example of how I fetch data:
```dart
Future<List<ProductModel>> getProducts() async {
  final response = await _dio.get('https://fakestoreapi.com/products');
  return (response.data as List)
      .map((json) => ProductModel.fromJson(json))
      .toList();
}
```

## How to run the project

### What you need
- Flutter installed on your computer
- Android Studio or VS Code
- An emulator or real device

### Steps to run
1. Clone this repo
   ```bash
   git clone https://github.com/mohamed22samy/ecommerce_sample.git
   cd ecommerce_sample
   ```

2. Get the packages
   ```bash
   flutter pub get
   ```

3. Run the app
   ```bash
   flutter run
   ```

That's it! The app should start on your device.

## Main packages I used

- `flutter_bloc` - For state management
- `dio` - To make API calls
- `easy_localization` - For Arabic/English support
- `flutter_screenutil` - To make UI responsive
- `shared_preferences` - To save cart data locally
- `google_fonts` - For custom fonts

## What I focused on

This project demonstrates:
- Clean Flutter app architecture
- BLoC pattern for state management
- API integration and data handling
- Multi-language support (Arabic/English)
- Local data persistence

## Language support

The app works in both Arabic and English. I put the translations in JSON files:
- `assets/translations/en-US.json` - English text
- `assets/translations/ar-EG.json` - Arabic text

## Cart functionality

I made a simple service to handle the shopping cart:
- Add items to cart
- Remove items
- Update quantities
- Save everything locally so it persists when you close the app

## Notes

The code is organized following Flutter best practices and is well-commented for maintainability. The architecture allows for easy scaling and adding new features.

Feel free to explore the code and provide feedback!
