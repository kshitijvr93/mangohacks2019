

import argparse
import io
import re

def detect_labels(path):
    """Detects labels in the file."""
    from google.cloud import vision
    client = vision.ImageAnnotatorClient()

    # [START vision_python_migration_label_detection]
    with io.open(path, 'rb') as image_file:
        content = image_file.read()

    image = vision.types.Image(content=content)

    response = client.label_detection(image=image)
    labels = response.label_annotations
    print('Labels:')

    for label in labels:
        print(label.description)


# detect_labels("C:\\Users\\kshit\\Downloads\\MangoHacks\\images\\A.png")