import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/cubitsearch/cubit.dart';
import 'package:salla/cubitsearch/states.dart';
import 'package:salla/model/searchmodel.dart';

import 'model/favmodel.dart';

class Search extends StatelessWidget {
  var wordcontroller = TextEditingController();
  dynamic islast = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Cubitshopsearch(),
      child: BlocConsumer<Cubitshopsearch, Stateshopsearch>(
        listener: (context, state) {
          {}
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextFormField(
                  controller: wordcontroller,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: 'Search',
                      border: OutlineInputBorder()),
                  onFieldSubmitted: (value) {
                    Cubitshopsearch.getdata(context)
                        .senddatasearch(word: value);
                    islast = true;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                if (state is Loadingsearch) LinearProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                if (Cubitshopsearch.getdata(context).searchdata != null)
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: ListView.separated(
                        itemBuilder: (context, index) => searchitem(
                            Cubitshopsearch.getdata(context)
                                .searchdata!
                                .data!
                                .data![index],
                            context),
                        separatorBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Container(
                                height: 1,
                                color: Colors.grey,
                                width: double.infinity,
                              ),
                            ),
                        itemCount: Cubitshopsearch.getdata(context)
                            .searchdata!
                            .data!
                            .data!
                            .length),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget searchitem(Datamodelsearch fav, context) => Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage('${fav.image}'),
            height: 120,
            width: 120,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            height: 120,
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${fav.name}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                // SizedBox(
                //   height: 50,
                // ),
                Spacer(),

                Row(
                  children: [
                    Text('${fav.price},', style: TextStyle(fontSize: 18)),
                    Spacer(),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
