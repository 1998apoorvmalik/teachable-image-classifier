# Teachable Machine Classifier

## Introduction

Inspired by Google’s teachable machines, I created my own version of this project. The frontend is created with the Flutter, and the backend is coded with Python (Tensorflow, Flask, Socket IO).

https://github.com/1998apoorvmalik/teachable_image_classifier/blob/main/demo/teachable_image_classifier_demo.mp4

To run this project, you must have both flutter and anaconda installed.

## Getting Started

First Clone this repository.

Now copy & paste this code in your terminal to create a new conda environment, install all the required dependencies, and finally to start the backend.

```test
cd teachable_image_classifier
conda env create -f environment.yml
conda activate teachable-image-classifier
python backend/app.py
```

You can now build the flutter app for Desktop/MacOS/Linux.
