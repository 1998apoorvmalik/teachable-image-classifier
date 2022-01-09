from flask import Flask
from flask_socketio import SocketIO, emit

from object_classification.dl_classification_model import DeepLearningModel

app = Flask(__name__)
app.config["SECRET_KEY"] = "secret!"
socketio = SocketIO(app)

model = None


@socketio.on("predict_object_classification_model")
def predict_object_classification_model(data):
    if model is None:
        print("[Error] No model trained.")
        emit("error", "Train a model first")
        return

    img_path = str(data["img_path"])

    if img_path is None:
        print("[Error] Invalid image/path.")
        return

    prob, label = model.predict(img_path)

    emit("predict_object_classification_model", label)
    print("[INFO] Prediction Done, Details:", prob, label)


@socketio.on("train_object_classification_model")
def train_object_classification_model(data):
    def log(val):
        emit("object_classification_train_log", val)

    def handle_error(error):
        emit("error", error)

    try:
        global model

        object_classes = data["object_classes"]
        image_paths = []
        labels = []
        for object_class in object_classes:
            image_paths += object_class["sample_paths"]
            labels += [str(object_class["name"])] * len(object_class["sample_paths"])

        model = DeepLearningModel(
            data=image_paths,
            labels=labels,
            repeat_count=int(data["aug_batch_size"]),
            batch_size=int(data["train_batch_size"]),
        )
        model.compile(
            optimizer="rmsprop",
            loss="categorical_crossentropy",
            metrics=["accuracy"],
        )
        model.fit(epochs=int(data["epochs"]))

    except Exception as exception:
        handle_error(str(exception))
        return

    print("Training Done!")
    log("[INFO] Model training successfully completed.")


if __name__ == "__main__":
    socketio.run(app, debug=True)
