enum PreprocessTool {
  crop,
  adjuster,
  blur,
  threshold,
  edgeDetector,
}

enum BlurType {
  average,
  gaussian,
  median,
  bilateralFiltering,
}

enum ThresholdCategory { simple, adaptive }

enum AdaptiveThresholdMethod { mean, gaussian }

enum ThresholdType {
  binary,
  binaryInvert,
  trunc,
  toZero,
  toZeroInv,
}

enum EdgeDetectorType {
  laplacian,
  canny,
  holisticallyNestedEdge,
}

enum ClassificationBaseModel {
  VGG16,
  VGG19,
  Resnet50,
  Xception,
  InceptionV3,
}

enum ModelType {
  Classification,
  DimensionalAnalysis,
}

enum ModelLossFunction {
  binary_crossentropy,
  categorical_crossentropy,
  kl_divergence,
  mean_squared_error,
  mean_absolute_error,
  cosine_similarity,
  squared_hinge,
  categorical_hinge
}

enum ModelOptimizer {
  SGD,
  RMSprop,
  Adam,
  Adadelta,
  Adagrad,
  Adamax,
  Nadam,
  Ftrl,
}
