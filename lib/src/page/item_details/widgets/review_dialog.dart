import 'package:flutter/material.dart';

class ReviewDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const ReviewDialog({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _ReviewDialogState createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  double rating = 0.0;
  double fitValue = 2.0;
  final List<String> fitLabels = [
    "Tight",
    "Slightly Tight",
    "Fit",
    "Slightly Loose",
    "Loose"
  ];

  @override
  void dispose() {
    titleController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Please Provide Your Review",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Rating stars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        rating = index + 1.0;
                      });
                    },
                    child: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 30,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              // Fit feedback slider
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(fitLabels.length, (index) {
                  return Text(
                    fitLabels[index],
                    style: const TextStyle(fontSize: 10),
                  );
                }),
              ),
              Slider(
                value: fitValue,
                min: 0,
                max: 4,
                divisions: 4,
                label: fitLabels[fitValue.round()],
                onChanged: (value) {
                  setState(() {
                    fitValue = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Title field
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  hintText: "Summarize your review",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Comment field
              TextField(
                controller: commentController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Comment",
                  hintText: "Write your review here",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Close"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle confirm logic here
                      final reviewData = {
                        "rating": rating,
                        "fit": fitValue,
                        "title": titleController.text,
                        "comment": commentController.text,
                      };

                      // Pass the data back using the callback
                      widget.onSubmit(reviewData);
                      Navigator.of(context).pop();
                    },
                    child: const Text("Confirm"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
