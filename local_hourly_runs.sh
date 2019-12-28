#!/bin/bash

source ~/.bash_profile

# work with pdfkit & imgkit stuff that doesn't work on pa
cd ~/code/jail_scrapers && python3 pdf_stuff.py
cd ~/code/msleg_scraper && python3 msleg_scraper.py

# idk if permission settings can be created? So far, I've only run manually
cd ~/code/reading_list && python3 get_reading_list.py
