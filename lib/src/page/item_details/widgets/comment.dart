import 'package:flutter/material.dart';

class CommentSectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final comments = [
      {
        "username": "camille.officialstore",
        "rating": 5,
        "date": "2023-08-24",
        "variant": "Black, XL",
        "review":
            "Sweater kiểu này đẹp quá, có phối layer kiểu basic rất dễ phối đồ mà nam nữ đều ok nè...",
        "images": [
          "https://via.placeholder.com/100",
          "https://via.placeholder.com/100",
          "https://via.placeholder.com/100",
        ],
        "reply":
            "CUNA chân thành cảm ơn bạn đã tin tưởng và ủng hộ. Có bất kỳ vấn đề gì cứ nhắn tin CUNA luôn hỗ trợ."
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Reviews"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall Rating Section
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "4.7 trên 5",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text("See All"),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Comments List
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User and Rating
                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundImage: NetworkImage(
                                  "https://via.placeholder.com/50",
                                ),
                                radius: 24,
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "camille.officialstore",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "2023-08-24",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: List.generate(
                                  comment["rating"] as int,
                                  (index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Review Content
                          Text(
                            "Sweater kiểu này đẹp quá, có phối layer kiểu basic rất dễ phối đồ mà nam nữ đều ok nè...",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Images
                          if ((comment["images"] as List).isNotEmpty)
                            SizedBox(
                              height: 80,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children:
                                    (comment["images"] as List).map((image) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Image.network(
                                      image,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),

                          const SizedBox(height: 8),

                          // Reply Section
                          if (comment["reply"] != null)
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "CUNA chân thành cảm ơn bạn đã tin tưởng và ủng hộ. Có bất kỳ vấn đề gì cứ nhắn tin CUNA luôn hỗ trợ.",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
