import 'package:new_flutter_assignment/models/blog.dart';

class BlogPostChecker {
  static bool isComplete(Blog blog) {
    if (blog.id != null &&
        blog.title != null &&
        blog.subtitle != null &&
        blog.content != null &&
        blog.date != null &&
        blog.image != null) {
      return true;
    }
    return false;
  }
}
