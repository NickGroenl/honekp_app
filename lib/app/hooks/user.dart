// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/user.dart';
import 'package:newhonekapp/app/routes/bookings/bookings.admin.dart';
import 'package:newhonekapp/app/routes/bookings/bookings.camarera.dart';
import 'package:newhonekapp/app/routes/bookings/bookings.dart';
import 'package:newhonekapp/app/routes/chat/chats.dart';
import 'package:newhonekapp/app/routes/dashboard/dashboard.dart';
import 'package:newhonekapp/app/routes/dashboard/dashboard.opendoor.dart';
import 'package:newhonekapp/app/routes/food/food.dart';
import 'package:newhonekapp/app/routes/home.dart';
import 'package:newhonekapp/app/routes/maintance/maintenance.dart';
import 'package:newhonekapp/app/routes/dashboard/dashboard.admin.dart';
import 'package:newhonekapp/app/routes/maintance/maintenance.gob.dart';
import 'package:newhonekapp/app/routes/services/services.dart';
import 'package:newhonekapp/app/routes/user/%20blinkid/scan_blink.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:newhonekapp/ui-kit/widgets/forms/dropdown.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';

import '../routes/maintance/maintenances.manutentore.dart';
import '../routes/user/ blinkid/lang.dart';

Future<void> verifySession(context) async {
  if (await getUser(false)) {
    if (currentUser.value.roles.isNotEmpty) {
      getDashboardRoutes(context);
    } else {
      Helper.nextScreen(context, Dashboard());
    }
  } else {
      
    Helper.nextScreen(context, LangSelect(route: '/login',));
  }
}

void getDashboardRoutes(context) {
  if (currentUser.value.roles.isNotEmpty) {
    switch (
        currentUser.value.roles[currentUser.value.roles.length - 1].role_id) {
      case 1:
      case 2:
      case 9:
        {
          Helper.nextScreen(context, BookingListAdmin());
          break;
        }
      case 7:
        {
          Helper.nextScreen(context, DashBoardOpeenDoor());
          break;
        }
      case 10:
      case 11:
        {
          Helper.nextScreen(context, DashBoardOpeenDoor());
          break;
        }
      default:
        {
          Helper.nextScreen(context, Dashboard());
          break;
        }
    }
  }
}

void getChatRoutes(context, setActivePage) {
  if (currentUser.value.roles[currentUser.value.roles.length - 1].role_id !=
      11) {
    Helper.nextScreen(context, ChatList());
    setActivePage('chat');
  }
}

void getBookingRoutes(context, setActivePage) {
  switch (currentUser.value.roles[currentUser.value.roles.length - 1].role_id) {
    case 1:
    case 2:
    case 9:
      Helper.nextScreen(context, DashboardAdmin());
      setActivePage('bookings');
      break;
    case 3:
    case 4:
      Helper.nextScreen(context, BookingList());
      setActivePage('bookings');

      break;
    case 7:
      Helper.nextScreen(context, CamareraKeepings());
      setActivePage('bookings');

      break;
  }
}

void getFoodRoutes(context, setActivePage) {
  if (currentUser.value.roles.isNotEmpty) {
    switch (
        currentUser.value.roles[currentUser.value.roles.length - 1].role_id) {
      case 1:
      case 2:
      case 3:
      case 4:
        Helper.nextScreen(context, Food());
        setActivePage('food');
        break;
    }
  }
}

void getServicesRoutes(context, setActivePage) {
  if (currentUser.value.roles.isNotEmpty) {
    switch (
        currentUser.value.roles[currentUser.value.roles.length - 1].role_id) {
      case 1:
      case 2:
      case 3:
      case 4:
        Helper.nextScreen(context, Services());
        setActivePage('food');
        break;
    }
  }
}

void getMaintanceRoutes(context, setActivePage) {
  if (currentUser.value.roles.isNotEmpty) {
    switch (
        currentUser.value.roles[currentUser.value.roles.length - 1].role_id) {
      case 1:
      case 2:
      case 3:
      case 4:
        Helper.nextScreen(context, Maintance());
        setActivePage('maintenance');
        break;
      case 9:
        {
          Helper.nextScreen(context, MaintenanceGobernante());
          setActivePage('maintenance');
          break;
        }
      case 10:
        {
          Helper.nextScreen(context, MaintanceMantutentore());
          setActivePage('maintenance');
          break;
        }
    }
  }
}
