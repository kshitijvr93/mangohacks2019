

import argparse
import io
import re
from pathlib import Path
import os


def detect_web(path):
    """Detects web annotations given an image."""
    from google.cloud import vision
    client = vision.ImageAnnotatorClient()

    with io.open(path, 'rb') as image_file:
        content = image_file.read()

    image = vision.types.Image(content=content)

    response = client.web_detection(image=image)
    annotations = response.web_detection
    guess_string = "some painting"
    # if annotations.best_guess_labels:
    #     for label in annotations.best_guess_labels:
           
    #         print('\nBest guess label: {}'.format(label.label))
    #         guess_string+= label.label+" "



    if annotations.web_entities:
        print('\n{} Web entities found: '.format(
            len(annotations.web_entities)))

        for entity in annotations.web_entities:
            print('\n\tScore      : {}'.format(entity.score))
            print(u'\tDescription: {}'.format(entity.description))
        
        
        
        banned_words = ["painting","art","museum","artist","painter","picture","gallery","grant wood","cubism","pablo picasso"]
        for entity in annotations.web_entities:
            contains_banned_words = False
            for word in banned_words:
                    if word in entity.description.lower():
                        contains_banned_words = True
                        break
            if not contains_banned_words:
                guess_string = entity.description
                break



    print(guess_string)
    return guess_string








def text2speech(text1):
    from google.cloud import texttospeech
    # Instantiates a client
    client = texttospeech.TextToSpeechClient()

    # Set the text input to be synthesized
    synthesis_input = texttospeech.types.SynthesisInput(text=text1)

    # Build the voice request, select the language code ("en-US") and the ssml
    # voice gender ("neutral")
    voice = texttospeech.types.VoiceSelectionParams(
        language_code='en-US',
        ssml_gender=texttospeech.enums.SsmlVoiceGender.NEUTRAL)

    # Select the type of audio file you want returned
    audio_config = texttospeech.types.AudioConfig(
        audio_encoding=texttospeech.enums.AudioEncoding.LINEAR16)

    # Perform the text-to-speech request on the text input with the selected
    # voice parameters and audio file type
    response = client.synthesize_speech(synthesis_input, voice, audio_config)

    # The response's audio_content is binary.
    with open('output.wav', 'wb') as out:
        # Write the response to the output file.
        out.write(response.audio_content)
        print('Audio content written to file "output.wav"')



val = 0
while True:
    # print("listening" , val)
    val+=1
    my_file = Path("D:\\Downloads\\MangoHacks-master\\images\\A.png")
    if my_file.is_file():
        text1 = detect_web("D:\\Downloads\\MangoHacks-master\\images\\A.png")
        # text1 = detect_web("D:\\Downloads\MangoHacks-master\\images\\Mona_Lisa.jpg")
        text2speech(text1)
        os.remove("D:\\Downloads\\MangoHacks-master\\images\\A.png")
