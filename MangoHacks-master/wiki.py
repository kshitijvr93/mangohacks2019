import wikipediaapi
import argparse
import io
import re
from pathlib import Path
import os
wiki_wiki = wikipediaapi.Wikipedia('en')
page_py = wiki_wiki.page('Mona Lisa')

if page_py.exists():
    print("Page - Title: %s" % page_py.summary)