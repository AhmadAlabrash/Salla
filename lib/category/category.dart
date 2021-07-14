
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salla/cubithome/cubithome.dart';
import 'package:salla/model/categorymodel.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: Cubitshoplayout.getdata(context).allcategorydata != null,
      builder: (BuildContext context) => ListView.separated(
          itemBuilder: (context, index) => gategorpageitem(
              Cubitshoplayout.getdata(context)
                  .allcategorydata!
                  .data!
                  .data![index]),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  height: 1,
                  color: Colors.grey,
                  width: double.infinity,
                ),
              ),
          itemCount: Cubitshoplayout.getdata(context)
              .allcategorydata!
              .data!
              .data!
              .length),
      fallback: (context) => Center(child: CircularProgressIndicator()),
    );
  }
}

Widget gategorpageitem(Categorydatadata model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            width: 80,
            height: 80,
          ),
          SizedBox(
            width: 20,
          ),
          Text('${model.name}',
              style: TextStyle(color: Colors.black, fontSize: 18)),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
