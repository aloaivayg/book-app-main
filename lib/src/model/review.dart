class Review {
  final String? id; // Optional, as it will be assigned by the server
  final String productId;
  final String userId;
  final String title;
  final String comment;
  final double rating;
  final String createdAt; // ISO timestamp (e.g., "2024-12-26T15:30:00Z")

  Review({
    this.id,
    required this.productId,
    required this.userId,
    required this.title,
    required this.comment,
    required this.rating,
    required this.createdAt,
  });

  // Factory constructor to create a Review object from JSON
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'] ?? json['id'], // Handle both "_id" and "id"
      productId: json['productId'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      comment: json['comment'] as String,
      rating: (json['rating'] as num).toDouble(), // Ensure double type
      createdAt: json['createdAt'] as String,
    );
  }

  // Method to convert a Review object to JSON
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id, // Include id only if it's not null
      'productId': productId,
      'userId': userId,
      'title': title,
      'comment': comment,
      'rating': rating,
      'createdAt': createdAt,
    };
  }
}
