import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/src/data/database/database.dart';

import 'package:task_manager_app/src/data/service/database_service.dart';
import 'package:task_manager_app/src/styles/base.dart';
import 'package:task_manager_app/src/styles/buttons.dart';
import 'package:task_manager_app/src/styles/text.dart';
import 'package:task_manager_app/src/widgets/category_card.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: categoriesScreenAppBar(),
      body: CategoriesScreenBody(),
      floatingActionButton: categoriesScreenFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  AppBar categoriesScreenAppBar() {
    return AppBar(
      backgroundColor: BaseStyles.appBarBackgroundColor,
      elevation: BaseStyles.appBarElevation,
      centerTitle: true,
      title: Text('CATEGORIES', style: TextStyles.appBarBigTextStyle),
      automaticallyImplyLeading: true,
    );
  }

  Widget categoriesScreenFloatingActionButton(BuildContext context) {
    var random = Random();
    var databaseService = Provider.of<DatabaseService>(context);

    return RaisedButton(
      color: ButtonStyles.floatingActionButtonColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Container(
        height: ButtonStyles.bigFloatingActionButtonHeight,
        width: ButtonStyles.bigFloatingActionButtonWidth(context),
        child: Center(
          child: Text(
            'CREATE NEW CATEGORY',
            style: ButtonStyles.floatingActionButtonTextStyle,
          ),
        ),
      ),
      onPressed: () {
        databaseService
            .addNewCategory('nova kategorija ${random.nextInt(125)}');
        //databaseService.deleteAllCategories();
      },
    );
  }
}

class CategoriesScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var databaseService = Provider.of<DatabaseService>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: StreamBuilder<List<Category>>(
        stream: databaseService.watchAllCategories(),
        builder: (context, AsyncSnapshot<List<Category>> snapshot) {
          if (snapshot.data != null) {
            var listOfCategories = snapshot.data;
            if (listOfCategories.length > 0) {
              return ListView.builder(
                itemCount: listOfCategories.length,
                itemBuilder: (context, index) {
                  var category = listOfCategories[index];
                  return CategoryCard(category: category);
                },
              );
            } else {
              return Center(
                child: Text('There is no Categories currently'),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
