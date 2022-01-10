# Teachable Image Classifier

## Introduction

Inspired by Google’s teachable machine ([link](https://teachablemachine.withgoogle.com)), I created my own version of this project. You can train almost any Deep Learning model visually by selecting images from your computer, naming the classes and fine tuning model & training parameters. The frontend is created with the Flutter framework, and backend with Python (Tensorflow, Flask, Socket IO). This project is still in development stages, please excuse any performance issues or bugs.

In this example, the model is being trained on 6 different animal classes, each with 250 samples. After the training is done, a different image is loaded and the model predicts the correct label.

![ezgif com-gif-maker](https://user-images.githubusercontent.com/34202100/148705686-5f4705b7-2754-4e20-bfb4-f94faa194ce0.gif)

The model successfully predicts the correct label as shown below (Cow in this example).

![Screenshot 2022-01-10 at 5 07 17 AM](https://user-images.githubusercontent.com/34202100/148706018-0056db31-4479-43cc-b649-ae30c97e8c47.png)

Find the full resolution demo video link [here](demo/)

## Getting Started

First Clone this repository. To run this project, you must have both flutter and anaconda installed.

Now copy & paste this code in your terminal to create a new conda environment, install all the required dependencies, and finally to start the backend.

```test
cd teachable_image_classifier
conda env create -f environment.yml
conda activate teachable-image-classifier
python backend/app.py
```

You can now build the flutter app for Desktop/MacOS/Linux.
