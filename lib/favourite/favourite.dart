import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/cubithome/cubithome.dart';
import 'package:salla/cubithome/statehome.dart';
import 'package:salla/model/favmodel.dart';

class Favourite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cubitshoplayout, Statesshoplayout>(
        listener: (context, state) {},
        builder: (context, state) => ConditionalBuilder(
              condition:
                  Cubitshoplayout.getdata(context).allmyfavourite != null,
              builder: (context) {
                if (Cubitshoplayout.getdata(context).allmyfavourite!.status ==
                    true) {
                  return ListView.separated(
                      itemBuilder: (context, index) => favouriteitem(
                          Cubitshoplayout.getdata(context)
                              .allmyfavourite!
                              .data!
                              .data![index],
                          context),
                      separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              height: 1,
                              color: Colors.grey,
                              width: double.infinity,
                            ),
                          ),
                      itemCount: Cubitshoplayout.getdata(context)
                          .allmyfavourite!
                          .data!
                          .data!
                          .length);
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.menu, color: Colors.grey, size: 90),
                        Text("You Don't have any favourites item ",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold))
                      ],
                    ),
                  );
                }
              },
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ));
  }
}

Widget favouriteitem(Datamodelfav fav, context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage('${fav.product!.image}'),
            height: 120,
            width: 120,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            height: 120,
            width: 230,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${fav.product!.name}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                // SizedBox(
                //   height: 50,
                // ),
                Spacer(),

                Row(
                  children: [
                    Text('price : ${fav.product!.price}',
                        style:
                            TextStyle(fontSize: 18, color: Colors.deepPurple)),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          Cubitshoplayout.getdata(context)
                              .postfavourite(id: fav.product!.id);
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.purple,
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
