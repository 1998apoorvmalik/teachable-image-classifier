import tensorflow as tf
from tensorflow import keras


class FeatureExtractor(keras.layers.Layer):
    def __init__(self, transfer_model="VGG16", trainable=False):
        super(FeatureExtractor, self).__init__()
        self.transfer_model_name = transfer_model
        self.trainable = trainable

    def build(self, input_shape):
        if self.transfer_model_name == "VGG16":
            model, self.preprocess_input = FeatureExtractor.extract_VGG16()
        elif self.transfer_model_name == "VGG19":
            model, self.preprocess_input = FeatureExtractor.extract_VGG19()
        elif self.transfer_model_name == "ResNet50":
            model, self.preprocess_input = FeatureExtractor.extract_Resnet50()
        elif self.transfer_model_name == "Xception":
            model, self.preprocess_input = FeatureExtractor.extract_Xception()
        else:
            (
                model,
                self.preprocess_input,
            ) = FeatureExtractor.extract_InceptionV3()

        self.feature_extractor = model(
            include_top=False,
            weights="imagenet",
            input_shape=input_shape,
            pooling="avg",
        )

        for layer in self.feature_extractor.layers:
            layer.trainable = self.trainable

    def call(self, inputs):
        if len(inputs.shape) < 4:
            inputs = tf.expand_dims(inputs, axis=0)
        return self.feature_extractor(self.preprocess_input(inputs))

    @staticmethod
    def extract_VGG16():
        from tensorflow.keras.applications.vgg16 import VGG16, preprocess_input

        return VGG16, preprocess_input

    @staticmethod
    def extract_VGG19():
        from tensorflow.keras.applications.vgg19 import VGG19, preprocess_input

        return VGG19, preprocess_input

    @staticmethod
    def extract_Resnet50():
        from tensorflow.keras.applications.resnet50 import (ResNet50,
                                                            preprocess_input)

        return ResNet50, preprocess_input

    @staticmethod
    def extract_Xception():
        from tensorflow.keras.applications.xception import (Xception,
                                                            preprocess_input)

        return Xception, preprocess_input

    @staticmethod
    def extract_InceptionV3():
        from tensorflow.keras.applications.inception_v3 import (
            InceptionV3, preprocess_input)

        return InceptionV3, preprocess_input
