import 'package:daily_flyers_app/features/home/presentation/screens/home_screen.dart';
import 'package:daily_flyers_app/features/wishlist/presentation/screens/wishlist_screen.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int currentIndex = 0;


  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    bool isAllowed = await LocalNotifications.isNotificationAllowed();
    DCacheHelper.putBoolean(key: CacheKeys.notificationVariable, value: isAllowed);
    if (!isAllowed) {
      await LocalNotifications.requestPermissionToSendNotifications();
    }
    /// Initialize notifications
    await LocalNotifications.init();

    /// Show periodic notification
    LocalNotifications.showPeriodicNotification(
      title: 'Daily Flyers',
      body: 'Please, go to app to see new offers',
      payload: 'Please, go to app to see new offers',
    );
  }

  @override
  Widget build(BuildContext context) {
    List tabs = [
      HomeScreen(),
      WishlistScreen(),
      // Container(color: Colors.blue),
      // FavouriteScreen(),
      // ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: DColors.greyScale50,
      body: tabs[currentIndex],
      bottomNavigationBar: NavigationBar(
        height: MediaQuery.of(context).size.width / 4,
        elevation: 0,
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: DColors.whiteColor,
        indicatorColor: DColors.primaryColor500.withOpacity(.1),
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
          // NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
          NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
          // NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
        ],
      ),
    );
  }
}
