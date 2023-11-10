import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Hello'),
            bottom: TabBar(tabs: [
              Tab(
                icon: Icon(Icons.location_history_sharp),
              ),
              Tab(
                icon: Icon(Icons.photo_sharp),
              ),
            ]),
          ),
          body: TabBarView(
            children: [
              ResfullPage(),
              ResPhoto(),
            ],
          )),
    );
  }
}

getData() async {
  Dio restfullExample = Dio();
  Response response =
      await restfullExample.get('https://jsonplaceholder.typicode.com/users');
  return response.data;
}

class ResfullPage extends StatelessWidget {
  const ResfullPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            dynamic temp = snapshot.data;
            List name =
                List.generate(temp.length, (index) => temp[index]['name']);
            List user =
                List.generate(temp.length, (index) => temp[index]['username']);

            List streets = List.generate(
                temp.length, (index) => temp[index]['address']['geo']['lat']);
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: name.length,
              itemBuilder: (context, index) => ListTile(
                title: Text("Name is:" + name[index],
                    style: TextStyle(
                        color: const Color.fromARGB(255, 25, 0, 212))),
                subtitle: Text("Lat is:" + streets[index]),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return const Center(
              child: Text('Somthing Missed'),
            );
          }
        },
      ),
    );
  }
}

getPhoto() async {
  Dio restfullExample = Dio();
  Response response =
      await restfullExample.get('https://jsonplaceholder.typicode.com/photos');
  return response.data;
}

class ResPhoto extends StatelessWidget {
  const ResPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPhoto(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            dynamic temp = snapshot.data;
            List url =
                List.generate(temp.length, (index) => temp[index]['url']);

            List urla = List.generate(
                temp.length, (index) => temp[index]['thumbnailUrl']);
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: url.length,
              itemBuilder: (context, index) => ListTile(
                title: Image.network(url[index]),
                subtitle: Image.network(urla[index]),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return const Center(
              child: Text('Somthing Missed'),
            );
          }
        },
      ),
    );
  }
}
