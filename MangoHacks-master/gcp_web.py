
import argparse
import io
import re


def detect_web(path):
    """Detects web annotations given an image."""
    from google.cloud import vision
    client = vision.ImageAnnotatorClient()

    with io.open(path, 'rb') as image_file:
        content = image_file.read()

    image = vision.types.Image(content=content)

    response = client.web_detection(image=image)
    annotations = response.web_detection
    guess_array = []
    if annotations.best_guess_labels:
        for label in annotations.best_guess_labels:
           
            print('\nBest guess label: {}'.format(label.label))
            guess_array.append(label.label)
    return guess_array

    # if annotations.pages_with_matching_images:
    #     print('\n{} Pages with matching images found:'.format(
    #         len(annotations.pages_with_matching_images)))

    #     for page in annotations.pages_with_matching_images:
    #         print('\n\tPage url   : {}'.format(page.url))

    #         if page.full_matching_images:
    #             print('\t{} Full Matches found: '.format(
    #                    len(page.full_matching_images)))

    #             for image in page.full_matching_images:
    #                 print('\t\tImage url  : {}'.format(image.url))

    #         if page.partial_matching_images:
    #             print('\t{} Partial Matches found: '.format(
    #                    len(page.partial_matching_images)))

    #             for image in page.partial_matching_images:
    #                 print('\t\tImage url  : {}'.format(image.url))

    # if annotations.web_entities:
    #     print('\n{} Web entities found: '.format(
    #         len(annotations.web_entities)))

    #     for entity in annotations.web_entities:
    #         print('\n\tScore      : {}'.format(entity.score))
    #         print(u'\tDescription: {}'.format(entity.description))

    # if annotations.visually_similar_images:
    #     print('\n{} visually similar images found:\n'.format(
    #         len(annotations.visually_similar_images)))

    #     for image in annotations.visually_similar_images:
    #         print('\tImage url    : {}'.format(image.url))


arr = detect_web("C:\\Users\\kshit\\Downloads\\MangoHacks\\images\\A.png")