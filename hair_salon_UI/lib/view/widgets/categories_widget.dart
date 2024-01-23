import 'package:flutter/material.dart';
import 'package:ui_practice/models/dashboard_models.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key, required this.categories, this.isWidget});

  final List<CategoryModel> categories;
  final bool? isWidget;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: isWidget != null ? height * 0.5 : height * 0.9,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Expanded(
            child: GridView.builder(
                physics: isWidget != null
                    ? const NeverScrollableScrollPhysics()
                    : null,
                itemCount: isWidget != null ? 6 : categories.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 3 / 5,
                    mainAxisExtent: isWidget != null ? height * 0.25 : 150,
                    mainAxisSpacing: 8.0),
                itemBuilder: (context, index) {
                  return Container(
                    height: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(20.0),
                                  color: Colors.grey.withOpacity(0.1),
                                  child: Image.network(
                                    categories[index].image,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              categories[index].name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          )
                        ]),
                  );
                }))
      ]),
    );
  }
}
