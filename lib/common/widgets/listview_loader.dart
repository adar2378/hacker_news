import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListViewLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 6,
      separatorBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(
            height: 1,
          ),
        );
      },
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.white,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            leading: Container(
              height: 44,
              width: 44,
              padding: EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange.shade700,
              ),
            ),
            title: Container(
              width: double.infinity,
              height: 20,
              color: Colors.grey.shade200,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 20,
                  color: Colors.grey.shade200,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 20,
                  color: Colors.grey.shade200,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
