import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:totalx/controller/homepageprovider.dart';
import 'package:totalx/views/homepage/widgets/alertbox.dart';
import 'package:totalx/views/loginpages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        return SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: const Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    Text(
                      "Nilambur",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 233, 233, 233),
              body: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              homeProvider.setSearchQuery(value);
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: "Search by name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, left: 20),
                                        child: Text(
                                          "Sort",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      ListTile(
                                        leading: IconButton(
                                          onPressed: () {
                                            homeProvider.setSelectedAge('All');
                                            Navigator.pop(context);
                                          },
                                          icon: homeProvider.selectedAge ==
                                                  'All'
                                              ? const Icon(Icons
                                                  .radio_button_on_outlined)
                                              : const Icon(Icons
                                                  .radio_button_off_outlined),
                                        ),
                                        title: const Text('All'),
                                        onTap: () {
                                          homeProvider.setSelectedAge('All');
                                          Navigator.pop(context);
                                        },
                                        selected:
                                            homeProvider.selectedAge == 'All',
                                      ),
                                      ListTile(
                                        leading: IconButton(
                                          onPressed: () {
                                            homeProvider
                                                .setSelectedAge('Older');
                                            Navigator.pop(context);
                                          },
                                          icon: homeProvider.selectedAge ==
                                                  'Older'
                                              ? const Icon(Icons
                                                  .radio_button_on_outlined)
                                              : const Icon(Icons
                                                  .radio_button_off_outlined),
                                        ),
                                        title: const Text('Age : Older'),
                                        onTap: () {
                                          homeProvider.setSelectedAge('Older');
                                          Navigator.pop(context);
                                        },
                                        selected:
                                            homeProvider.selectedAge == 'Older',
                                      ),
                                      ListTile(
                                        leading: IconButton(
                                          onPressed: () {
                                            homeProvider
                                                .setSelectedAge('Younger');
                                            Navigator.pop(context);
                                          },
                                          icon: homeProvider.selectedAge ==
                                                  'Younger'
                                              ? const Icon(Icons
                                                  .radio_button_on_outlined)
                                              : const Icon(Icons
                                                  .radio_button_off_outlined),
                                        ),
                                        title: const Text('Age : Younger'),
                                        onTap: () {
                                          homeProvider
                                              .setSelectedAge('Younger');
                                          Navigator.pop(context);
                                        },
                                        selected: homeProvider.selectedAge ==
                                            'Younger',
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.filter_list_sharp,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "User Lists",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: homeProvider.stream,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            QuerySnapshot querySnapshot = snapshot.data!;
                            List<QueryDocumentSnapshot> document =
                                querySnapshot.docs;
                            List<Map> items =
                                document.map((e) => e.data() as Map).toList();

                            items = homeProvider.filterItems(items);

                            return ListView.separated(
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  Map thisItems = items[index];
                                  return Container(
                                    height: 80,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(blurRadius: .2)
                                        ],
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, left: 15),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 30,
                                                      backgroundImage: thisItems
                                                              .containsKey(
                                                                  'image')
                                                          ? NetworkImage(
                                                              "${thisItems['image']}")
                                                          : null,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${thisItems['name']}",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Text(
                                                            "Age : ${thisItems['age']}",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: Colors.black,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertBoxWidget();
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
