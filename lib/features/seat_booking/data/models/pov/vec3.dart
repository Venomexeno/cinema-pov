import 'dart:math' as math;

// x: right, y: up, z: from the screen towards the seats.
final class Vec3 {
  const Vec3(this.x, this.y, this.z);

  final double x;
  final double y;
  final double z;

  Vec3 operator +(Vec3 other) => Vec3(x + other.x, y + other.y, z + other.z);
  Vec3 operator -(Vec3 other) => Vec3(x - other.x, y - other.y, z - other.z);
  Vec3 operator *(double scale) => Vec3(x * scale, y * scale, z * scale);

  double dot(Vec3 other) => x * other.x + y * other.y + z * other.z;

  Vec3 cross(Vec3 other) => Vec3(
    y * other.z - z * other.y,
    z * other.x - x * other.z,
    x * other.y - y * other.x,
  );

  double get length => math.sqrt(dot(this));

  Vec3 get normalized => this * (1 / length);

  static Vec3 lerp(Vec3 a, Vec3 b, double t) => a + (b - a) * t;
}
