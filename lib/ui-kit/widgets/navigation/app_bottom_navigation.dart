import 'package:newhonekapp/app/hooks/user.dart';
import 'package:newhonekapp/ui-kit/models/bottom_bar_item.dart';
import 'package:newhonekapp/ui-kit/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';


class AppBottomNavigation extends StatefulWidget {
  final String pageActually;
  const AppBottomNavigation({super.key, required this.pageActually});

  @override
  // ignore: no_logic_in_create_state
  createState() => _AppBottomNavigationState(paramsPage: pageActually);
}

class _AppBottomNavigationState extends State<AppBottomNavigation> {
  final String paramsPage;
  String activePage = "home";

  _AppBottomNavigationState({required this.paramsPage});

  void setActivePage(String page) {
    //if(page != activePage) {
    setState(() => {activePage = page});
    //}
  }

  List<BottomBarItem> items = [];

  @override
  void initState() {
    activePage = paramsPage;
    items = [
      BottomBarItem(
        
        icon: Ionicons.home_outline,
        onPressed: () => {
          Future.delayed(Duration.zero, () async {
            setActivePage("home");
            getDashboardRoutes(context);
          })
        },
        key: "home",
      ),
      BottomBarItem(
        icon: Ionicons.calendar_outline,
        onPressed: () => {
          Future.delayed(Duration.zero, () async {
            getBookingRoutes(context, setActivePage);
          })
        },
        key: "bookings",
      ),
      BottomBarItem(
        icon: Ionicons.chatbubble_ellipses_outline,
        onPressed: () => {
          Future.delayed(Duration.zero, () async {
            getChatRoutes(context, setActivePage);
          })
        },
        key: "chat",
      ),
      BottomBarItem(
        icon: Ionicons.fast_food_outline,
        onPressed: () => {
          Future.delayed(Duration.zero, () async {
            getFoodRoutes(context, setActivePage);
          })
        },
        key: "food",
      ),
      BottomBarItem(
        icon: Ionicons.location_outline,
        onPressed: () => {
          Future.delayed(Duration.zero, () async {
            getServicesRoutes(context, setActivePage);
          })
        },
        key: "services",
      ),
      BottomBarItem(
        
        icon: Ionicons.hammer_outline,
        onPressed: () => {
          Future.delayed(Duration.zero, () async {
            getMaintanceRoutes(context, setActivePage);
          })
        },
        key: "maintance",
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 6.0,
        bottom: 35.0,
        right: 6.0,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      height: ScreenUtil().setHeight(65.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items
            .map(
              (BottomBarItem item) =>
                  getBottomWidgetItem(item, activePage == item.key),
            )
            .toList(),
      ),
    );
  }
}

Widget getBottomWidgetItem(BottomBarItem item, bool isActive) {
  return Container(
    height: ScreenUtil().setHeight(52.0),
    width: ScreenUtil().setWidth(52.0),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: isActive ? Constants.buttonColor : Colors.transparent,
    ),
    child: AnimatedSwitcher(
      duration: Duration(milliseconds: 450),
      child: isActive
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 5.0,
                ),
              ],
            )
          : Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: IconButton(
                icon: Icon(
                  item.icon,
                  color: Color.fromRGBO(156, 166, 201, 1),
                ),
                onPressed: () => item.onPressed(),
              ),
            ),
    ),
  );
}
