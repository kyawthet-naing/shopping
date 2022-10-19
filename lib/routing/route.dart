import 'route_import.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Splash.route:
        return pageRouter(settings: settings, page: const Splash());

      case Product.route:
        return pageRouter(settings: settings, page: const Product());

      case Cart.route:
        return pageRouter(settings: settings, page: const Cart());

      case ProductDetail.route:
        var product = settings.arguments as ProductModel;
        return pageRouter(
          settings: settings,
          page: ProductDetail(product: product),
        );

      default:

        ///404 page

        return null;
    }
  }

  static pageRouter({required RouteSettings settings, required Widget page}) {
    return MaterialPageRoute(builder: (ctx) => page, settings: settings);
  }
}
