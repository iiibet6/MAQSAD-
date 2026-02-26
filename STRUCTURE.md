# Maqsad Flutter App – Folder Structure

```
lib/
├── main.dart                        # App entry point, MaterialApp, routes
│
├── theme/
│   └── app_theme.dart               # AppColors, AppTextStyles, AppTheme (ThemeData)
│
├── widgets/                         # Reusable shared widgets
│   └── shared_widgets.dart          # PatternBorderFallback, AppLogo, PrimaryButton,
│                                    # OutlinedAppButton, LabeledTextField,
│                                    # SectionHeader, AppBottomNavBar
│
└── screens/
    ├── welcome_screen.dart          # Splash / Welcome (logo + landscape photo)
    ├── auth_choice_screen.dart      # Login or Guest choice (full-screen BG)
    ├── login_screen.dart            # Login form (bottom-sheet style card)
    ├── register_screen.dart         # New account registration form
    ├── interests_screen.dart        # Hobby selection grid
    ├── home_screen.dart             # Main home feed (offers, recommended, nearby)
    ├── map_screen.dart              # Map with filter chips
    └── account_screen.dart          # Profile + settings

assets/
├── fonts/
│   ├── Cairo-Regular.ttf
│   ├── Cairo-Medium.ttf
│   ├── Cairo-SemiBold.ttf
│   └── Cairo-Bold.ttf
└── images/
    ├── logo.png                     # App pin/castle logo
    ├── pattern_border.png           # Arabic pattern strip (top of screens)
    ├── welcome_landscape.jpg        # Hail landscape photo
    ├── auth_bg.jpg                  # Background for auth screens
    ├── map_bg.jpg                   # Map screenshot or real map
    ├── offer_chalets.jpg
    ├── offer_restaurants.jpg
    ├── place1-4.jpg
    ├── nearby1-4.jpg
    ├── trending1-2.jpg
    └── interest_*.jpg               # Chess, football, etc.
```

## Navigation Flow

```
/ (WelcomeScreen)
  └─► /auth-choice (AuthChoiceScreen)
        ├─► /login (LoginScreen)
        │     └─► /home
        ├─► /register (RegisterScreen)
        │     └─► /interests (InterestsScreen)
        │           └─► /home
        └─► /home (Guest)
              ├─► HomeScreen  (tab 3)
              ├─► MapScreen   (tab 1)
              └─► AccountScreen (tab 0)
```

## Key Design Notes

- **RTL first**: All screens wrapped in `Directionality(textDirection: TextDirection.rtl)`
- **Arabic pattern border**: `PatternBorderFallback` (14px brown geometric strip at top)
- **Bottom nav**: 4 icons — Profile, Map, Explore, Home; icons flip at accent color when active
- **Color palette**: Deep brown (#7B3F00), golden orange (#D4820A), white cards
- **Typography**: Cairo font family throughout (Arabic + Latin support)
- **Input fields**: Brown border (1.5px), rounded 12px, RTL aligned text
