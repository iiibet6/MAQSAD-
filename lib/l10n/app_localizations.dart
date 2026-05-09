import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @memories.
  ///
  /// In en, this message translates to:
  /// **'Memories'**
  String get memories;

  /// No description provided for @visits.
  ///
  /// In en, this message translates to:
  /// **'Visit History'**
  String get visits;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccount;

  /// No description provided for @myInfo.
  ///
  /// In en, this message translates to:
  /// **'My Information'**
  String get myInfo;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @suggestions.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get suggestions;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy;

  /// No description provided for @partners.
  ///
  /// In en, this message translates to:
  /// **'Join Maqsad Partners'**
  String get partners;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Check for Updates'**
  String get update;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @loginRequired.
  ///
  /// In en, this message translates to:
  /// **'You need to sign in'**
  String get loginRequired;

  /// No description provided for @noPhotos.
  ///
  /// In en, this message translates to:
  /// **'No photos yet 📸'**
  String get noPhotos;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loggingIn.
  ///
  /// In en, this message translates to:
  /// **'Logging in...'**
  String get loggingIn;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create New Account'**
  String get createNewAccount;

  /// No description provided for @loginError.
  ///
  /// In en, this message translates to:
  /// **'Login Error'**
  String get loginError;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get unexpectedError;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @nameExample.
  ///
  /// In en, this message translates to:
  /// **'Example: Ahmed'**
  String get nameExample;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @phoneExample.
  ///
  /// In en, this message translates to:
  /// **'05xxxxxxxx'**
  String get phoneExample;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'Birth Date'**
  String get birthDate;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @registering.
  ///
  /// In en, this message translates to:
  /// **'Registering...'**
  String get registering;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @selectBirthDateMessage.
  ///
  /// In en, this message translates to:
  /// **'Please select your birth date'**
  String get selectBirthDateMessage;

  /// No description provided for @enterPhoneMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get enterPhoneMessage;

  /// No description provided for @generalError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get generalError;

  /// No description provided for @emailVerification.
  ///
  /// In en, this message translates to:
  /// **'Email Verification'**
  String get emailVerification;

  /// No description provided for @checkYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get checkYourEmail;

  /// No description provided for @verificationLinkSentTo.
  ///
  /// In en, this message translates to:
  /// **'Verification link sent to'**
  String get verificationLinkSentTo;

  /// No description provided for @emailVerificationInstructions.
  ///
  /// In en, this message translates to:
  /// **'Please open your email and click the verification link'**
  String get emailVerificationInstructions;

  /// No description provided for @checking.
  ///
  /// In en, this message translates to:
  /// **'Checking...'**
  String get checking;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @resendVerificationLink.
  ///
  /// In en, this message translates to:
  /// **'Resend verification link'**
  String get resendVerificationLink;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// No description provided for @verificationEmailFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send verification email'**
  String get verificationEmailFailed;

  /// No description provided for @emailNotVerifiedYet.
  ///
  /// In en, this message translates to:
  /// **'Email is not verified yet'**
  String get emailNotVerifiedYet;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Discover Hail'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In en, this message translates to:
  /// **'Explore the best tourist and natural places in Hail'**
  String get onboardingDesc1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Smart Recommendations'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In en, this message translates to:
  /// **'Get suggestions tailored to your interests and mood'**
  String get onboardingDesc2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Start Your Journey'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In en, this message translates to:
  /// **'Enjoy a smart and unique tourism experience'**
  String get onboardingDesc3;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @startNow.
  ///
  /// In en, this message translates to:
  /// **'Start Now'**
  String get startNow;

  /// No description provided for @interestsHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Interests'**
  String get interestsHeroTitle;

  /// No description provided for @favoriteHobbiesQuestion.
  ///
  /// In en, this message translates to:
  /// **'What are your favorite hobbies?'**
  String get favoriteHobbiesQuestion;

  /// No description provided for @videoGames.
  ///
  /// In en, this message translates to:
  /// **'Video Games'**
  String get videoGames;

  /// No description provided for @chess.
  ///
  /// In en, this message translates to:
  /// **'Chess'**
  String get chess;

  /// No description provided for @basketball.
  ///
  /// In en, this message translates to:
  /// **'Basketball'**
  String get basketball;

  /// No description provided for @volleyball.
  ///
  /// In en, this message translates to:
  /// **'Volleyball'**
  String get volleyball;

  /// No description provided for @football.
  ///
  /// In en, this message translates to:
  /// **'Football'**
  String get football;

  /// No description provided for @swimming.
  ///
  /// In en, this message translates to:
  /// **'Swimming'**
  String get swimming;

  /// No description provided for @drawing.
  ///
  /// In en, this message translates to:
  /// **'Drawing'**
  String get drawing;

  /// No description provided for @horseRiding.
  ///
  /// In en, this message translates to:
  /// **'Horse Riding'**
  String get horseRiding;

  /// No description provided for @cooking.
  ///
  /// In en, this message translates to:
  /// **'Cooking'**
  String get cooking;

  /// No description provided for @photography.
  ///
  /// In en, this message translates to:
  /// **'Photography'**
  String get photography;

  /// No description provided for @moodHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Mood'**
  String get moodHeroTitle;

  /// No description provided for @choosePreferredMood.
  ///
  /// In en, this message translates to:
  /// **'What atmosphere do you prefer?'**
  String get choosePreferredMood;

  /// No description provided for @calmMood.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get calmMood;

  /// No description provided for @familyMood.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get familyMood;

  /// No description provided for @livelyMood.
  ///
  /// In en, this message translates to:
  /// **'Lively'**
  String get livelyMood;

  /// No description provided for @romanticMood.
  ///
  /// In en, this message translates to:
  /// **'Romantic'**
  String get romanticMood;

  /// No description provided for @natureMood.
  ///
  /// In en, this message translates to:
  /// **'Nature'**
  String get natureMood;

  /// No description provided for @adventureMood.
  ///
  /// In en, this message translates to:
  /// **'Adventure'**
  String get adventureMood;

  /// No description provided for @chooseFavoriteCuisine.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Favorite Cuisine'**
  String get chooseFavoriteCuisine;

  /// No description provided for @saudiCuisine.
  ///
  /// In en, this message translates to:
  /// **'Saudi'**
  String get saudiCuisine;

  /// No description provided for @gulfCuisine.
  ///
  /// In en, this message translates to:
  /// **'Gulf'**
  String get gulfCuisine;

  /// No description provided for @levantineCuisine.
  ///
  /// In en, this message translates to:
  /// **'Levantine'**
  String get levantineCuisine;

  /// No description provided for @turkishCuisine.
  ///
  /// In en, this message translates to:
  /// **'Turkish'**
  String get turkishCuisine;

  /// No description provided for @italianCuisine.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get italianCuisine;

  /// No description provided for @americanCuisine.
  ///
  /// In en, this message translates to:
  /// **'American'**
  String get americanCuisine;

  /// No description provided for @indianCuisine.
  ///
  /// In en, this message translates to:
  /// **'Indian'**
  String get indianCuisine;

  /// No description provided for @chineseCuisine.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get chineseCuisine;

  /// No description provided for @japaneseCuisine.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get japaneseCuisine;

  /// No description provided for @seafoodCuisine.
  ///
  /// In en, this message translates to:
  /// **'Seafood'**
  String get seafoodCuisine;

  /// No description provided for @fastFoodCuisine.
  ///
  /// In en, this message translates to:
  /// **'Fast Food'**
  String get fastFoodCuisine;

  /// No description provided for @dessertsAndCafes.
  ///
  /// In en, this message translates to:
  /// **'Desserts and Cafes'**
  String get dessertsAndCafes;

  /// No description provided for @guestName.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guestName;

  /// No description provided for @welcomeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcomeGreeting;

  /// No description provided for @todayOffers.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Offers'**
  String get todayOffers;

  /// No description provided for @pickedForYou.
  ///
  /// In en, this message translates to:
  /// **'Picked For You'**
  String get pickedForYou;

  /// No description provided for @nearbyPlaces.
  ///
  /// In en, this message translates to:
  /// **'Nearby Places'**
  String get nearbyPlaces;

  /// No description provided for @giftSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Share Gifts, Spread Love'**
  String get giftSectionTitle;

  /// No description provided for @flowerGift.
  ///
  /// In en, this message translates to:
  /// **'Flowers & Gifts'**
  String get flowerGift;

  /// No description provided for @giftCourier.
  ///
  /// In en, this message translates to:
  /// **'Gift Courier'**
  String get giftCourier;

  /// No description provided for @flowersAndGifts.
  ///
  /// In en, this message translates to:
  /// **'Flowers and Gifts'**
  String get flowersAndGifts;

  /// No description provided for @sameDayDelivery.
  ///
  /// In en, this message translates to:
  /// **'Same-day Delivery'**
  String get sameDayDelivery;

  /// No description provided for @discoverHail.
  ///
  /// In en, this message translates to:
  /// **'Discover Hail'**
  String get discoverHail;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @featuredPlaces.
  ///
  /// In en, this message translates to:
  /// **'Featured Places'**
  String get featuredPlaces;

  /// No description provided for @aerifCastle.
  ///
  /// In en, this message translates to:
  /// **'A\'arif Castle'**
  String get aerifCastle;

  /// No description provided for @aerifCastleDescription.
  ///
  /// In en, this message translates to:
  /// **'A historical castle overlooking Hail city'**
  String get aerifCastleDescription;

  /// No description provided for @aerifCastleLocation.
  ///
  /// In en, this message translates to:
  /// **'Hail'**
  String get aerifCastleLocation;

  /// No description provided for @hatimHouse.
  ///
  /// In en, this message translates to:
  /// **'Hatim Al-Tai Houses'**
  String get hatimHouse;

  /// No description provided for @hatimHouseDescription.
  ///
  /// In en, this message translates to:
  /// **'A famous historical landmark known for Arab generosity'**
  String get hatimHouseDescription;

  /// No description provided for @hatimHouseLocation.
  ///
  /// In en, this message translates to:
  /// **'Tawaran - Hail'**
  String get hatimHouseLocation;

  /// No description provided for @openAllDay.
  ///
  /// In en, this message translates to:
  /// **'Open All Day'**
  String get openAllDay;

  /// No description provided for @historical.
  ///
  /// In en, this message translates to:
  /// **'Historical'**
  String get historical;

  /// No description provided for @restaurants.
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get restaurants;

  /// No description provided for @natureAndTourismPlaces.
  ///
  /// In en, this message translates to:
  /// **'Nature & Tourism Places'**
  String get natureAndTourismPlaces;

  /// No description provided for @cafes.
  ///
  /// In en, this message translates to:
  /// **'Cafes'**
  String get cafes;

  /// No description provided for @chaletsAndResorts.
  ///
  /// In en, this message translates to:
  /// **'Chalets & Resorts'**
  String get chaletsAndResorts;

  /// No description provided for @hotels.
  ///
  /// In en, this message translates to:
  /// **'Hotels'**
  String get hotels;

  /// No description provided for @shopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get shopping;

  /// No description provided for @americanRestaurants.
  ///
  /// In en, this message translates to:
  /// **'American Restaurants'**
  String get americanRestaurants;

  /// No description provided for @egyptianRestaurants.
  ///
  /// In en, this message translates to:
  /// **'Egyptian Restaurants'**
  String get egyptianRestaurants;

  /// No description provided for @italianRestaurants.
  ///
  /// In en, this message translates to:
  /// **'Italian Restaurants'**
  String get italianRestaurants;

  /// No description provided for @indianRestaurants.
  ///
  /// In en, this message translates to:
  /// **'Indian Restaurants'**
  String get indianRestaurants;

  /// No description provided for @saudiRestaurants.
  ///
  /// In en, this message translates to:
  /// **'Saudi Restaurants'**
  String get saudiRestaurants;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @malls.
  ///
  /// In en, this message translates to:
  /// **'Malls'**
  String get malls;

  /// No description provided for @womenClothes.
  ///
  /// In en, this message translates to:
  /// **'Women\'s Clothing'**
  String get womenClothes;

  /// No description provided for @menClothes.
  ///
  /// In en, this message translates to:
  /// **'Men\'s Clothing'**
  String get menClothes;

  /// No description provided for @kidsClothes.
  ///
  /// In en, this message translates to:
  /// **'Kids Clothing'**
  String get kidsClothes;

  /// No description provided for @homeCategory.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeCategory;

  /// No description provided for @beauty.
  ///
  /// In en, this message translates to:
  /// **'Beauty'**
  String get beauty;

  /// No description provided for @electronics.
  ///
  /// In en, this message translates to:
  /// **'Electronics'**
  String get electronics;

  /// No description provided for @recommendedForYou.
  ///
  /// In en, this message translates to:
  /// **'Recommended For You'**
  String get recommendedForYou;

  /// No description provided for @nature.
  ///
  /// In en, this message translates to:
  /// **'Nature'**
  String get nature;

  /// No description provided for @chalets.
  ///
  /// In en, this message translates to:
  /// **'Chalets'**
  String get chalets;

  /// No description provided for @italian.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get italian;

  /// No description provided for @saudi.
  ///
  /// In en, this message translates to:
  /// **'Saudi'**
  String get saudi;

  /// No description provided for @american.
  ///
  /// In en, this message translates to:
  /// **'American'**
  String get american;

  /// No description provided for @indian.
  ///
  /// In en, this message translates to:
  /// **'Indian'**
  String get indian;

  /// No description provided for @chinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get chinese;

  /// No description provided for @egyptian.
  ///
  /// In en, this message translates to:
  /// **'Egyptian'**
  String get egyptian;

  /// No description provided for @hatimHouseFullDescription.
  ///
  /// In en, this message translates to:
  /// **'A symbol of Arab generosity in Hail'**
  String get hatimHouseFullDescription;

  /// No description provided for @aerifCastleFullDescription.
  ///
  /// In en, this message translates to:
  /// **'One of the oldest historical castles in Hail'**
  String get aerifCastleFullDescription;

  /// No description provided for @mahjaMountain.
  ///
  /// In en, this message translates to:
  /// **'Mahja Mountain'**
  String get mahjaMountain;

  /// No description provided for @mahjaMountainDescription.
  ///
  /// In en, this message translates to:
  /// **'A unique natural destination in Hail'**
  String get mahjaMountainDescription;

  /// No description provided for @oqdahTouristArea.
  ///
  /// In en, this message translates to:
  /// **'Oqdah Tourist Area'**
  String get oqdahTouristArea;

  /// No description provided for @oqdahTouristAreaDescription.
  ///
  /// In en, this message translates to:
  /// **'A beautiful natural tourist destination'**
  String get oqdahTouristAreaDescription;

  /// No description provided for @faydHistoricalCity.
  ///
  /// In en, this message translates to:
  /// **'Fayd Historical City'**
  String get faydHistoricalCity;

  /// No description provided for @faydHistoricalCityDescription.
  ///
  /// In en, this message translates to:
  /// **'An ancient city on Zubaida Road'**
  String get faydHistoricalCityDescription;

  /// No description provided for @faydLocation.
  ///
  /// In en, this message translates to:
  /// **'Fayd - Hail'**
  String get faydLocation;

  /// No description provided for @masharPark.
  ///
  /// In en, this message translates to:
  /// **'Mashar Park'**
  String get masharPark;

  /// No description provided for @masharParkDescription.
  ///
  /// In en, this message translates to:
  /// **'A natural park suitable for families'**
  String get masharParkDescription;

  /// No description provided for @masharWorkingHours.
  ///
  /// In en, this message translates to:
  /// **'6 AM - 12 Midnight'**
  String get masharWorkingHours;

  /// No description provided for @tawaranValley.
  ///
  /// In en, this message translates to:
  /// **'Tawaran Valley'**
  String get tawaranValley;

  /// No description provided for @tawaranValleyDescription.
  ///
  /// In en, this message translates to:
  /// **'A natural destination for adventure lovers'**
  String get tawaranValleyDescription;

  /// No description provided for @tawaranLocation.
  ///
  /// In en, this message translates to:
  /// **'Tawaran - Hail'**
  String get tawaranLocation;

  /// No description provided for @hail.
  ///
  /// In en, this message translates to:
  /// **'Hail'**
  String get hail;

  /// No description provided for @natural.
  ///
  /// In en, this message translates to:
  /// **'Natural'**
  String get natural;

  /// No description provided for @tourism.
  ///
  /// In en, this message translates to:
  /// **'Tourism'**
  String get tourism;

  /// No description provided for @historicalTouristLandmark.
  ///
  /// In en, this message translates to:
  /// **'A historical tourist landmark in Hail'**
  String get historicalTouristLandmark;

  /// No description provided for @naturalTouristDestination.
  ///
  /// In en, this message translates to:
  /// **'A natural tourist destination in Hail'**
  String get naturalTouristDestination;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyTitle;

  /// No description provided for @privacyPolicyContent.
  ///
  /// In en, this message translates to:
  /// **'This Privacy Policy explains that protecting your personal data is extremely important to us, and we recognize our responsibility to handle your personal information carefully and securely.\n\nFor service providers: the data you enter into the application is used to reach your customers.\n\nFor customers: your data is used to save your information such as favorite stores and all orders. The data is only accessible to the stores. Maqsad is committed not to use the data for any other purposes or share it with other parties.\n\nMaqsad uses the data of service providers and customers to provide better services based on geographical location, including displaying nearby stores and services supported by the application.\n\nMaqsad is committed not to share or publish private information of service providers or customers with any third party for any purpose.\n\nMaqsad also clarifies that it does not collect undisclosed information from stores or customers such as device IP addresses, operating systems, versions, software details, languages, identifiers, or mobile network information.'**
  String get privacyPolicyContent;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get notAvailable;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter New Password'**
  String get enterNewPassword;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// No description provided for @updating.
  ///
  /// In en, this message translates to:
  /// **'Updating...'**
  String get updating;

  /// No description provided for @passwordChangedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get passwordChangedSuccess;

  /// No description provided for @reloginRequired.
  ///
  /// In en, this message translates to:
  /// **'Please login again before changing password'**
  String get reloginRequired;

  /// No description provided for @welcomeToHail.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Hail'**
  String get welcomeToHail;

  /// No description provided for @noFavoritesYet.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet ❤️'**
  String get noFavoritesYet;

  /// No description provided for @signInOrRegister.
  ///
  /// In en, this message translates to:
  /// **'Sign In or Register'**
  String get signInOrRegister;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get continueAsGuest;

  /// No description provided for @workingHours.
  ///
  /// In en, this message translates to:
  /// **'Working Hours: 7:00 AM - 12:00 AM'**
  String get workingHours;

  /// No description provided for @aboutPlace.
  ///
  /// In en, this message translates to:
  /// **'About Place'**
  String get aboutPlace;

  /// No description provided for @ratePlace.
  ///
  /// In en, this message translates to:
  /// **'Rate This Place'**
  String get ratePlace;

  /// No description provided for @contactPlace.
  ///
  /// In en, this message translates to:
  /// **'Contact Place'**
  String get contactPlace;

  /// No description provided for @writeComment.
  ///
  /// In en, this message translates to:
  /// **'Write Your Comment'**
  String get writeComment;

  /// No description provided for @commentHint.
  ///
  /// In en, this message translates to:
  /// **'Write your opinion about the place...'**
  String get commentHint;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @commentSent.
  ///
  /// In en, this message translates to:
  /// **'Your comment has been sent successfully'**
  String get commentSent;

  /// No description provided for @ratingSaved.
  ///
  /// In en, this message translates to:
  /// **'Your rating has been saved'**
  String get ratingSaved;

  /// No description provided for @stars.
  ///
  /// In en, this message translates to:
  /// **'Stars'**
  String get stars;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
