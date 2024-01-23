import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/dashboard_models.dart';
import '../models/user_auth_model.dart';

final ref = FirebaseFirestore.instance.collection('Build_With_Innovation');
const todaySpecialId = "today_special_123";
const featuredServicesId = "featured_services";
final User? authUser = FirebaseAuth.instance.currentUser;

class FirestoreService {
  Future<TodaySpecial?> getTodaySpecial() async {
    late TodaySpecial? todaySpecial;
    final doc = await ref.doc(todaySpecialId).get();
    if (doc.exists) {
      todaySpecial = TodaySpecial.fromMap(doc.data()!);
    }
    return todaySpecial;
  }

  Future<UserModel?> getUser() async {
    if (authUser == null) {
      return null;
    }
    UserModel? user;
    final doc = await ref
        .doc('users')
        .collection("users_collection")
        .doc(authUser!.uid)
        .get();
    if (doc.exists) {
      user = UserModel.fromMap(doc.data()!);
    }
    return user;
  }

  Future<List<FeaturedService>?> getFeaturedServices() async {
    List<FeaturedService>? featuredServices;
    final doc = await ref
        .doc(featuredServicesId)
        .collection('featured_services_collection')
        .get();
    // //  temp
    // final temp = FeaturedService(
    //     discountPrice: "300",
    //     image:
    //         "https://img.freepik.com/free-photo/two-male-customers-enjoy-expert-barber-skills-generated-by-ai_188544-29058.jpg",
    //     originalPrice: "500",
    //     name: "Bleaching");
    // final temp1 = FeaturedService(
    //     discountPrice: "500",
    //     originalPrice: "800",
    //     image:
    //         "https://img.freepik.com/free-photo/young-adult-applying-clay-mask-relaxation-generated-by-ai_188544-54116.jpg",
    //     name: "Spa");
    // final temp2 = FeaturedService(
    //     discountPrice: "1000",
    //     originalPrice: "2000",
    //     image:
    //         "https://img.freepik.com/free-photo/handsome-man-barber-shop-styling-hair_1303-20978.jpg?size=626&ext=jpg&uid=R125884824&ga=GA1.1.1043004737.1700320989&semt=ais",
    //     name: "Hair Cutting");
    // final temp3 = FeaturedService(
    //     discountPrice: "1500",
    //     originalPrice: "1800",
    //     name: "Hair Dyeing",
    //     image:
    //         "https://img.freepik.com/free-photo/hairdresser-colored-hair-her-client-hair-salon_1157-27194.jpg?size=626&ext=jpg&uid=R125884824&ga=GA1.1.1043004737.1700320989&semt=ais");
    // final temp4 = FeaturedService(
    //   discountPrice: "100",
    //   originalPrice: "200",
    //   name: "Beard Trimming",
    //   image:
    //       "https://img.freepik.com/free-photo/stylish-man-sitting-barbershop_1157-21208.jpg?size=626&ext=jpg&uid=R125884824&ga=GA1.1.1043004737.1700320989&semt=ais",
    // );
    // await ref
    //     .doc(featuredServicesId)
    //     .collection('featured_services_collection')
    //     .add(temp.toMap());
    // await ref
    //     .doc(featuredServicesId)
    //     .collection('featured_services_collection')
    //     .add(temp1.toMap());
    // await ref
    //     .doc(featuredServicesId)
    //     .collection('featured_services_collection')
    //     .add(temp2.toMap());
    // await ref
    //     .doc(featuredServicesId)
    //     .collection('featured_services_collection')
    //     .add(temp3.toMap());
    // await ref
    //     .doc(featuredServicesId)
    //     .collection('featured_services_collection')
    //     .add(temp4.toMap());

    //
    if (doc.docs.isNotEmpty) {
      featuredServices = [];
      try {
        for (var element in doc.docs) {
          featuredServices.add(FeaturedService.fromMap(element.data()));
        }
        //adding twice for testing purpose
        for (var element in doc.docs) {
          featuredServices.add(FeaturedService.fromMap(element.data()));
        }
      } catch (e) {
        log('error is here $e');
      }
    }
    return featuredServices;
  }

  Future<List<CategoryModel>?> getCategories() async {
    List<CategoryModel>? categories;
    final doc =
        await ref.doc('categories').collection('categories_collection').get();

    if (doc.docs.isNotEmpty) {
      categories = [];
      try {
        for (var element in doc.docs) {
          categories.add(CategoryModel.fromMap(element.data()));
        }
      } catch (e) {
        log('error is here in getcategories $e');
      }
    }
    return categories;
  }

  Future<List<HairSalon>?> getHairSalons() async {
    List<HairSalon>? hairSalons;
    final doc = await ref
        .doc('hair_salons')
        .collection('hair_salons_collection')
        .orderBy('total_reviews')
        .get();

    if (doc.docs.isNotEmpty) {
      hairSalons = [];
      try {
        for (var element in doc.docs.reversed) {
          hairSalons.add(HairSalon.fromMap(element.data()));
        }
      } catch (e) {
        log('error is here in gethair salons $e');
      }
    }
    return hairSalons;
  }

  Future<void> addUserToFirestore(UserModel user) async {
    await ref.doc('users').collection("users_collection").doc(user.id).set(
          user.toMap(),
          SetOptions(merge: true),
        );
  }
}
