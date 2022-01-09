""" Does anything"""
import numpy as np
import tensorflow as tf
from sklearn.preprocessing import OneHotEncoder
from tensorflow import keras
from tensorflow.keras import layers
from tensorflow.keras.preprocessing.image import img_to_array, load_img

from object_classification.feature_extractor import FeatureExtractor


class DeepLearningModel(keras.Model):
    def __init__(
        self,
        data,
        labels,
        base_model="VGG16",
        repeat_count=1,
        batch_size=16,
        validation_split=0.2,
        input_shape=(229, 229),
    ):
        super(DeepLearningModel, self).__init__()

        # model hyperparameters
        self.repeat_count = repeat_count
        self.batch_size = batch_size
        self.validation_split = validation_split
        self.shape = input_shape
        self.label_encoder = OneHotEncoder()

        # get tensors from image paths and encode labels
        self.tensors = self._paths_to_tensor(data)
        self.labels = self.label_encoder.fit_transform(np.array(labels).reshape(-1, 1)).toarray()

        print("[INF0] Tensors shape:", self.tensors.shape)
        print("[INF0] Labels shape:", self.labels.shape)

        # data augmentation layer
        # use CPU for data augmentation, apple metal bullshit...
        with tf.device("/cpu:0"):
            data_augmentation = keras.Sequential(
                [
                    layers.RandomFlip("horizontal"),
                    # layers.RandomRotation(0.1),
                ]
            )

        # generate tf dataset from tensors and labels
        self.dataset = tf.data.Dataset.from_tensor_slices((self.tensors, self.labels))
        # repeat dataset
        self.dataset = self.dataset.repeat(count=repeat_count)
        # shuffle dataset
        self.dataset = self.dataset.shuffle(len(data), reshuffle_each_iteration=False)  # reshuffle ?
        # batch dataset
        self.dataset = self.dataset.batch(batch_size=batch_size)
        # augment dataset
        self.dataset = self.dataset.map(lambda x, y: (data_augmentation(x), y))
        # self.dataset = self.dataset.prefetch(tf.data.AUTOTUNE)  # prefetch ??

        """ initialize model layers """
        # automatically applies preprocessing steps
        self.feature_extractor = FeatureExtractor(transfer_model=base_model)
        self.dense1 = layers.Dense(128, activation="relu")
        self.dense2 = layers.Dense(64, activation="relu")
        self.classifier = layers.Dense(self.labels.shape[-1], activation="softmax")

        # build the network
        super().build(input_shape=self.tensors.shape[1:])

    def _path_to_tensor(self, img_path):
        try:
            image = load_img(img_path, target_size=self.shape)
            image = img_to_array(image)
            image = np.expand_dims(image, axis=0)
            return image

        except Exception:
            print("[Error] {} sample cannot be loaded.".format(img_path))
            return None

    def _paths_to_tensor(self, data):
        tensors = []

        for path in data:
            tensor = self._path_to_tensor(path)
            if tensor is not None:
                tensors.append(tensor)

        return np.vstack(tensors)

    def call(self, inputs):
        """Define model architecture"""
        x = self.feature_extractor(inputs)
        x = self.dense1(x)
        x = self.dense2(x)
        return self.classifier(x)

    def fit(self, epochs=16, verbose=1):
        super().fit(
            self.dataset,
            batch_size=self.batch_size,
            epochs=epochs,
            verbose=verbose,
        )
        print("fit done")

    def predict(self, object):
        if type(object) is str:
            tensor = self._path_to_tensor(object)
        elif type(object) is np.ndarray:
            tensor = np.expand_dims(object, axis=0)
        else:
            predictions = []
            for item in object:
                predictions.append(self.predict(item))
            return predictions

        prediction = super().predict(tensor)
        label = str(self.label_encoder.inverse_transform(prediction).flatten()[0])

        return prediction, label
