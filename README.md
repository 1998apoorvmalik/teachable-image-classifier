# Teachable Machine Classifier

## Introduction

Inspired by Google’s teachable machines, I created my own version of this project. The frontend is created with the Flutter, and the backend is coded with Python (Tensorflow, Flask, Socket IO).

![ezgif com-gif-maker](https://user-images.githubusercontent.com/34202100/148705686-5f4705b7-2754-4e20-bfb4-f94faa194ce0.gif)

![Screenshot 2022-01-10 at 5 07 17 AM](https://user-images.githubusercontent.com/34202100/148705828-89d63ff0-79ce-41c5-b372-9a4a66eb8155.png)

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
