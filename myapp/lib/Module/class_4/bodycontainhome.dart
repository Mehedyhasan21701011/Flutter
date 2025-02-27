import 'package:flutter/material.dart';
import 'package:myapp/Module/class_5/cart.dart';

class Bodycontainhome extends StatelessWidget {
  const Bodycontainhome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Category",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            TextButton(onPressed: () {}, child: Text("view all"))
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(12),
                  splashColor: Colors.blue.withOpacity(0.3),
                  highlightColor: Colors.blue.withOpacity(0.1),
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 4,
                            color: Colors.grey,
                            offset: Offset(2, 2))
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircleAvatar(
                              minRadius: 50,
                              backgroundImage: AssetImage(
                                  "assets/Images/download_$index.jpg"),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Item ${index + 1}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Popular Products",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              TextButton(onPressed: () {}, child: Text("view all"))
            ],
          ),
        ),
      ),
      Expanded(
        child: SizedBox(
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio: 0.7,
            ),
            itemCount: 8,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Cart()));
                },
                borderRadius: BorderRadius.circular(12),
                splashColor: Colors.blue.withOpacity(0.3),
                highlightColor: Colors.blue.withOpacity(0.1),
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 4.0, left: 8, right: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 12,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "assets/Images/download_$index.jpg",
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: const Text(
                                    "Fruits",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    children: const [
                                      Text("3.9",
                                          style: TextStyle(fontSize: 12)),
                                      SizedBox(width: 8),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 16),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "400.0\$",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(50),
                                      onTap: () {
                                        print("Icon tapped!");
                                      },
                                      child: const Icon(Icons.add,
                                          color: Colors.white, size: 30),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ]);
  }
}
