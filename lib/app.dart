//  PACKAGES
export 'package:flutter/material.dart' hide FormFieldValidator, Flow;
export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:font_awesome_flutter/font_awesome_flutter.dart';
export 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
export 'package:material_symbols_icons/symbols.dart';
export 'package:form_field_validator/form_field_validator.dart';
export 'package:equatable/equatable.dart';
export 'dart:developer';
export 'package:geolocator/geolocator.dart';
export 'package:http/http.dart';
export 'dart:convert';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:google_maps_flutter/google_maps_flutter.dart';
export 'package:shimmer/shimmer.dart';
export 'package:carousel_slider/carousel_slider.dart';
export 'package:intl/intl.dart' hide TextDirection;
export 'package:flutter_rating_bar/flutter_rating_bar.dart';
export 'package:flutter_dash/flutter_dash.dart';
export 'package:hive_flutter/hive_flutter.dart';
export 'package:animated_custom_dropdown/custom_dropdown.dart';
export 'package:flutter_polyline_points/flutter_polyline_points.dart';

// export 'package:badges/badges.dart';

// config
export './config/config.dart';

//core
export './core/core.dart';

//CONSTANTS
export 'config/constants/image_constants.dart';
export 'config/theme/app_fontweight.dart';
export 'config/extensions/padding.dart';
export 'config/constants/text_constants.dart';
export 'config/utils/enums/auth_error_enums.dart';

//THEMES
export 'config/theme/app_textstyles.dart';
export 'config/theme/brand_theme_color.dart';
export 'config/theme/app_theme.dart';

//WIDGETS
export 'src/widgets/widgets.dart';

//! SCREENS
export 'src/account/account.dart' hide AddressModel, AccountModel;
export 'src/home/home.dart';
export 'src/onboarding/onboarding.dart';
export 'src/rider/rider.dart' hide FulfillmentHubModel, OrderItemModel;
export 'src/product/product.dart';
export 'src/orders/order.dart' hide OrderListModel;
export 'src/categories/categories.dart' hide ProductsModel;
export 'src/drawer/drawer.dart';
export './src/search/search.dart';
export './src/checkout/checkout.dart' hide CartModel;
