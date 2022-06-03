import 'package:flutter/material.dart';
import 'package:mealapp/data/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const String routeName = "meal_detail";
  final Function toggleFavorite;
  final Function isFavorite;
  const MealDetailScreen(this.toggleFavorite, this.isFavorite, {Key? key})
      : super(key: key);
  Widget buildData(String txt, BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Text(
        "$index -  $txt",
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: const Color.fromRGBO(252, 241, 206, 1.0),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final meal = DUMMY_MEALS.firstWhere((element) {
      return element.id == mealId;
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          meal.title,
          style: const TextStyle(color: Color.fromRGBO(250, 240, 206, 1.0)),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(30), left: Radius.circular(30)),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2.7,
                  width: double.infinity,
                  child: Image.network(
                    meal.imageUrl,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2.7,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 1.73,
              decoration: const BoxDecoration(
                  color: Color(0xff2e2532),
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20), right: Radius.circular(30))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.all(7),
                        width: MediaQuery.of(context).size.width / 15,
                        height: MediaQuery.of(context).size.height / 150,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(206, 206, 187, 1.0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    Text(
                      "Ingredients",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return buildData(
                              meal.ingredients[index], context, index + 1);
                        },
                        itemCount: meal.ingredients.length,
                      ),
                    ),
                    Text(
                      "Steps",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 16,
                              // backgroundColor: textColor,
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                    color: Theme.of(context).canvasColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Text(
                              meal.steps[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: const Color.fromRGBO(
                                        252, 241, 206, 1.0),
                                  ),
                            ),
                          );
                        },
                        itemCount: meal.steps.length,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () {
        //   Navigator.of(context).pop(mealId);
        // },
        onPressed: () => toggleFavorite(mealId),
        child: Icon(isFavorite(mealId) ? Icons.star : Icons.star_border),
      ),
    );
  }
}
