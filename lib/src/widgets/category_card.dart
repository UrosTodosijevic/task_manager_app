import 'package:flutter/material.dart';
import 'package:task_manager_app/src/data/database/database.dart';
import 'package:task_manager_app/src/styles/base.dart';
import 'package:task_manager_app/src/styles/buttons.dart';
import 'package:task_manager_app/src/styles/colors.dart';
import 'package:task_manager_app/src/styles/text.dart';

class CategoryCard extends StatelessWidget {

  final Category category;

  CategoryCard({@required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1 / 2,vertical: 6.0),
      child: Container(
        height: 70.0,
        //width: MediaQuery.of(context).size.width * 0.9,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.gainsboro,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.raisinBlack.withOpacity(0.5),
              offset: Offset(1.0, 2.0),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              //clipBehavior: Clip.hardEdge,
              height: 70.0,
              width: 60.0,
              color: Colors.blue[400],
              child: Center(
                child: Icon(Icons.settings, color: Colors.white, size: BaseStyles.iconSize),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                category.categoryName,
                style: TextStyles.bodyTextStyle,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                print('SOON...');
              },
            ),
          ],
        ),
      ),
    );
  }
}
