#!/usr/bin/env python2

# FIX THIS: a bit buggy; gets multiple copies of pdfs in merged pdf

# Usage:
# from current directory list out pdf files to merge.
# $ ./pdf_merge.py <f1.pdf> <f2.pdf>
# NOTE: These should reside in current directory where the script is running

# Courtesy:
# https://www.boxcontrol.net/merge-pdf-files-with-under-10-lines-in-python.html

import os
import sys
from PyPDF2 import PdfFileReader, PdfFileMerger

files_dir = os.path.dirname(__file__)
# pdf_files = [f for f in os.listdir(files_dir) if f.endswith("pdf")]
pdf_files = sys.argv[1:]
merger = PdfFileMerger()
for filename in pdf_files:
    merger.append(PdfFileReader(os.path.join(files_dir, filename), "rb"))
    merger.write(os.path.join(files_dir, "merged_full.pdf"))
