import 'package:flutter/material.dart';

import '../models/data.dart';

class TopSpendingPart extends StatelessWidget {
  TopSpendingPart({
    Key? key,
  }) : super(key: key);

  final data = Data();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 5.0,
        ),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'Top Spending',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              const Icon(Icons.swap_vert),
            ]),
            Column(
              children: data.listTileData
                  .asMap()
                  .map(
                    (key, listTileMap) => MapEntry(
                      key,
                      Card(
                        elevation: listTileMap['isSelected'] ? 15.0 : 0.0,
                        shadowColor: Colors.grey[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ListTile(
                          textColor: Colors.black,
                          selectedColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          selected: listTileMap['isSelected'],
                          selectedTileColor: Theme.of(context).primaryColorDark,
                          tileColor: Colors.grey[100],
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(listTileMap['image']),
                          ),
                          title: Text(
                            listTileMap['title'],
                            style: listTileMap['isSelected']
                                ? null
                                : Theme.of(context).textTheme.headline4,
                          ),
                          subtitle: Text(listTileMap['subtitle']),
                          trailing: Text(
                            listTileMap['trailingText'],
                            style: listTileMap['isSelected']
                                ? const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  )
                                : Theme.of(context).textTheme.headline2,
                          ),
                        ),
                      ),
                    ),
                  )
                  .values
                  .toList(),
            ),
          ],
        ));
  }
}
