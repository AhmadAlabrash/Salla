import 'package:flutter/material.dart';
import 'package:salla/model/models.dart';

Widget itemonboarding(context, Pageviewitems data) => Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Image(
            image: NetworkImage('${data.urlimage}'),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3,
          ),
          SizedBox(
            height: 60,
          ),
          Text(
            '${data.title}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            '${data.content}',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );

Widget defulttextform({
  @required preficon,
  @required label,
  @required control,
  invisible = false,
  suficon,
}) =>
    TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: preficon,
        suffixIcon: suficon,
        labelText: label,
      ),
      obscureText: invisible,
      controller: control,
      validator: (value) {
        if (value!.isEmpty) {
          return 'you not insert your data';
        }
      },
    );
