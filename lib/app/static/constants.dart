import 'package:newhonekapp/app/models/foodandbeverage.dart';
import 'package:newhonekapp/app/models/travels.dart';

class TravelStaticData {
  static final List<TravelsModel> travels = [
    TravelsModel(
      title: "Milano",
      description:
          "Milano  è un capoluogo della regione Lombardia e dell'omonima città metropolitana, è centro di una delle più popolose aree metropolitane d'Europa.",
      price: "150",
      ubication: "None",
      imagepath: "assets/images/rome1.jpeg",
    ),
    TravelsModel(
      title: "Venezia",
      description:
          "Una città incredibile, costituita da un insieme di 118 isole unite da oltre 400 ponti e separate dai canali che fungono da strade.",
      price: "300",
      ubication: "None",
      imagepath: "assets/images/rome2.jpeg",
    ),
    TravelsModel(
      title: "Firenze",
      description:
          "Firenze è una tipica città fluviale. Sviluppata sulle due sponde dell'Arno, città ricca di storia e d'arte. Fondata e abitata da popoli italici.",
      price: "200",
      ubication: "None",
      imagepath: "assets/images/rome3.jpeg",
    ),
    TravelsModel(
      title: "Amalfi",
      description:
          "Si presenta come un agglomerato di case bianche, aggrappate alla roccia e collegate da vicoli coperti e scalinate. Al centro della piazza principale domina il Duomo di Sant'Andrea.",
      price: "230",
      ubication: "None",
      imagepath: "assets/images/rome4.jpeg",
    ),
  ];
}

class CategoriesData {
  static final List<CategoriesModel> categories =  [...beverageCategories.map((e) => CategoriesModel(title: e))];
  
}

class FoodData {
  


  static final List<FoodListModel> foodViewlist = [
    FoodListModel(
        description: "Pizza tipo longaniza con queso mozzarella",
        title: "Pizza",
        hotel: "Hotel Roma",
        time: "22",
        price: "£ 8.0",
        imagepath:
            "https://www.chuckecheese.com/wp-content/uploads/2022/04/CEC-22-0063-Website-Menu-Page-Update_stuffed-crust.jpg"),
    FoodListModel(
        description: "Hamburguesa completa tipo bacon con cebolla crispy",
        title: "Hamburguesa",
        hotel: "Hotel Roma",
        time: "22",
        price: "£ 6.0",
        imagepath:
            "https://img4.goodfon.com/wallpaper/nbig/0/96/burger-bulochka-kotleta-ovoshchi.jpg"),
    FoodListModel(
        description: "Empanadas de carne cortada a cuchillo",
        title: "Empanadas",
        hotel: "Hotel Roma",
        time: "22",
        price: "£ 2.0",
        imagepath:
            "https://img.freepik.com/premium-photo/neapolitan-empanada-opened-half-front-more-empanadas_311379-69.jpg?w=2000")
  ];
}
