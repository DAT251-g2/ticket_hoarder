import 'package:flutter/material.dart';
import 'package:ticket_hoarder/models/all_direction_model.dart';
import 'package:ticket_hoarder/models/transport_interface.dart';
import 'package:ticket_hoarder/models/transport_model.dart';

//import 'package:flutter_js/flutter_js.dart';

class RoutePage extends StatefulWidget {
  final AllDirectionModel map;

  const RoutePage({Key? key, required this.map}) : super(key: key);

  @override
  _RoutePage createState() => _RoutePage();
}

class _RoutePage extends State<RoutePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Route information'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: PostList(listItems: widget.map.directions))
          ],
        ));
  }

  List<TransportInterface> getGoogleResponse() {
    TransportModel transportObject = TransportModel();
    //transportObject.setItems(widget.map['routes'][0]);
    return transportObject.transportItems;
  }
}

class PostList extends StatefulWidget {
  final List<TransportModel> listItems;

  const PostList({Key? key, required this.listItems}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.listItems.length,
        itemBuilder: (context, index) {
          var item = widget.listItems[index];
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ItemList(transportItems: item.transportItems)));
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                        title: Text(item.transportTitle),
                        subtitle: Text(item.printInfo())),
                  ),
                  item.getIcon(),
                ],
              ),
            ),
          );
        });
  }
}

class ItemList extends StatefulWidget {
  final List<TransportInterface> transportItems;

  const ItemList({Key? key, required this.transportItems}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Route information'),
        ),
        body: ListView.builder(
          itemCount: widget.transportItems.length,
          itemBuilder: (context, index) {
            var item = widget.transportItems[index];
            return Card(
                child: Row(
              children: <Widget>[
                Expanded(
                    child: ListTile(
                        title: Text(item.printTitle()),
                        subtitle: Text(item.printInfo()))),
                //Row(children: <Widget>[Icon(Icon)],)
              ],
            ));
          },
        ));
  }
}
