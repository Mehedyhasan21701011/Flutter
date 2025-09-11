import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border_sharp),
            iconSize: 30,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content
        children: [
          Container(
            width: double.infinity,
            height: 250, // Set a fixed height for proper rendering
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Images/Shoee.png"),
                fit: BoxFit.cover, // Adjusts image within the container
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8),
            child: Row(
              children: [
                Icon(Icons.star, size: 30, color: Colors.yellow),
                SizedBox(width: 5),
                Text(
                  "4.3 (123)",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(Icons.share, size: 30),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "\$100",
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.red,
                    decorationThickness: 2.0,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "\$80.0",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              "Green Air Shoe",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                Text("Status:", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                Text(
                  "In Stock",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              "Description:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ExpandableText(
              text:
                  "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.",
            ),
          ),
          const Spacer(),
          Container(
            color: const Color.fromRGBO(89, 33, 33, 0.122),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Expanded(
                  flex: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.remove_circle, size: 40, color: Colors.grey),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text("5", style: TextStyle(fontSize: 18)),
                      ),
                      Icon(Icons.add_circle, size: 40),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Add to cart",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLength;

  const ExpandableText({super.key, required this.text, this.maxLength = 100});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    bool shouldTruncate = widget.text.length > widget.maxLength;

    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   isExpanded || !shouldTruncate
        //       ? widget.text
        //       : widget.text.substring(0, widget.maxLength) + "...",
        //   style: TextStyle(fontSize: 16.0),
        //   softWrap: true,
        // ),
        // if (shouldTruncate) // Only show "Show more" if truncation is applied
        //   InkWell(
        //     onTap: () {
        //       setState(() {
        //         isExpanded = !isExpanded;
        //       });
        //     },
        //     child: Text(
        //       isExpanded ? "Show less" : "Show more",
        //       style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // ReadMoreText(
        //   "Product er description text......bla blaa",
        //               trimLines: 3,
        //               trimMode: TrimMode.Line,
        //               trimCollapsedText: ' See more',
        //               trimExpandedText: ' Less',
        // ),
      ],
    );
  }
}
