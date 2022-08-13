class DimensionalBoundaries {
  final int width;
  final int height;

  DimensionalBoundaries(this.width, this.height);
}

class LayoutBoundaries {
  final DimensionalBoundaries minSize;
  final DimensionalBoundaries maxSize;

  LayoutBoundaries(this.minSize, this.maxSize);
}
