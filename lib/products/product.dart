import 'package:carousel_slider/carousel_slider.dart';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/cubithome/cubithome.dart';
import 'package:salla/cubithome/statehome.dart';
import 'package:salla/model/categorymodel.dart';
import 'package:salla/model/homemodelabdallh.dart';
import 'package:salla/style/icon_broken.dart';

class Product extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cubitshoplayout, Statesshoplayout>(
        listener: (context, state) {
      if (state is Iniatialshoplayout) {
        // Cubitshoplayout.getdata(context).gethomedata();
        // Cubitshoplayout.getdata(context).getcategorydata();
      }
    }, builder: (context, state) {
      return ConditionalBuilder(
        condition: Cubitshoplayout.getdata(context).allcategorydata != null &&
            Cubitshoplayout.getdata(context).allhomedata != null,
        builder: (BuildContext context) => SingleChildScrollView(
            child: defultbanner(
                Cubitshoplayout.getdata(context).allhomedata, context)),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      );
    });
  }
}

Widget defultbanner(HomeModel? model, context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CarouselSlider(
        items: model!.data!.banners
            .map((e) => Image(
                  image: NetworkImage('${e.image}'),
                  width: double.infinity,
                  fit: BoxFit.fill,
                ))
            .toList(),
        options: CarouselOptions(
            viewportFraction: 1,
            autoPlay: true,
            height: 250,
            reverse: false,
            enableInfiniteScroll: true,
            initialPage: 0,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1)),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        ' Category',
        maxLines: 1,
        style: TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: double.infinity,
          height: 100,
          child: ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => categoryitem(
                  Cubitshoplayout.getdata(context)
                      .allcategorydata!
                      .data!
                      .data![index]),
              separatorBuilder: (context, index) => SizedBox(
                    width: 10,
                  ),
              itemCount: Cubitshoplayout.getdata(context)
                  .allcategorydata!
                  .data!
                  .data!
                  .length),
        ),
      ),
      Text(
        ' Prouducts',
        maxLines: 1,
        style: TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: 1 / 1.7,
          crossAxisCount: 2,
          children: List.generate(
            Cubitshoplayout.getdata(context).allhomedata!.data!.products.length,
            (index) => product(model.data!.products[index], context),
          ))
    ],
  );
}

Widget product(ProductModel pr, context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage('${pr.image}'),
            height: 200,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${pr.name}',
            style: TextStyle(
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                'Price :${pr.price} ',
                style: TextStyle(color: Colors.deepPurple, fontSize: 12),
              ),
              SizedBox(
                width: 10,
              ),
              if (pr.discount != null)
                Text(
                  '${pr.oldPrice} ',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough),
                ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    Cubitshoplayout.getdata(context).postfavourite(id: pr.id);
                  },
                  icon: Cubitshoplayout.getdata(context).favouriecubit[pr.id]
                      ? Icon(
                          Icons.favorite,
                          color: Colors.purple,
                        )
                      : Icon(Neue.Heart))
            ],
          )
        ],
      ),
    );

Widget categoryitem(Categorydatadata model) => Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          width: 100,
          height: 100,
        ),
        Container(
            alignment: AlignmentDirectional.bottomCenter,
            width: 100,
            height: 22,
            color: Colors.black,
            child: Text(
              '${model.name}',
              maxLines: 1,
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
