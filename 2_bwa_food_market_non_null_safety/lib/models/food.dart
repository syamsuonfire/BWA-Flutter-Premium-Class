part of 'models.dart';

enum FoodType {new_food, popular, recomended }

class Food extends Equatable {
  final int id;
  final String picturePath;
  final String name;
  final String description;
  final String ingredients;
  final int price;
  final double rate;
  final List<FoodType> types;

  Food(
      {this.id,
      this.picturePath,
      this.name,
      this.description,
      this.ingredients,
      this.price,
      this.rate,
      this.types = const []});

  factory Food.fromJson(Map<String, dynamic> data) => Food(
    id: data['id'],
    picturePath: data['picturePath'],
    name: data['name'],
    description: data['description'],
    ingredients: data['ingredients'],
    price: data['price'],
    rate: (data['rate'] as num).toDouble(),
    types: data['types'].toString().split(',').map((e) {
      switch (e) {
        case 'recommended':
          return FoodType.recomended;
          break;
        case 'popular':
          return FoodType.popular;
          break;
        default:
          return FoodType.new_food;
      }
    }).toList()

  );

  @override
  List<Object> get props =>
      [id, picturePath, name, description, ingredients, price, rate];
}

List<Food> mockFoods = [
  Food(
      id: 1,
      picturePath:
          "https://1.bp.blogspot.com/-y0BwJQwsny0/Xurv5nXQwSI/AAAAAAABw5A/lIeSIRDD2k8GkccExrSrGPM78-A3AtmOQCK4BGAsYHg/s796/Nasi%2BGoreng%2BJawa1.jpg",
      name: "Nasi Goreng Bang Kari",
      description:
          "Nasi goreng bang kari adalah salah nasi yang ramai peminatnya didaerah Darussalam  ",
      ingredients: "Nasi, Kecap, Cabe, Bawang, Seledri, Timun, Tomat",
      price: 10000,
      rate: 2.5,
      types: [FoodType.popular, FoodType.recomended]),
  Food(
      id: 2,
      picturePath:
          "https://cdn.yummy.co.id/content-images/images/20200326/XmyZpnYBPkWXTIEnp1G82BPIxYNdSUJo-31353835313938383937d41d8cd98f00b204e9800998ecf8427e_800x800.jpg",
      name: "Nasi Uduk",
      description: "Nasi uduk yang ramai disukai oleh banyak orang didaerah darussalam  ",
      ingredients: "Nasi, Bawang, Pandan, Timun, Ayam",
      price: 5000,
      rate: 3.5,
      types: [FoodType.popular,]),
  Food(
      id: 3,
      picturePath:
          "https://cdn.yummy.co.id/content-images/images/20200326/XmyZpnYBPkWXTIEnp1G82BPIxYNdSUJo-31353835313938383937d41d8cd98f00b204e9800998ecf8427e_800x800.jpg",
      name: "Nasi Padang",
      description: "Nasi  ",
      ingredients: "Nasi, Bawang, Pandan, Timun, Ayam",
      price: 15000,
      rate: 4.5,
      types: [FoodType.new_food]),
];
