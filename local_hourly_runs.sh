#!/bin/bash

# work with pdfkit & imgkit stuff that doesn't work on pa
cd ~/code/jail_scrapers && python3.6 pdf_stuff.py
cd ~/code/msleg_scraper && python3.6 msleg_scraper.py && python3.6 senate_cmte_agendas.py

# TODO: find out how to automate deleting from reading list
the_hour="$(date +"%H")"
if [ "$the_hour" = "07" ]; then
    cd ~/code/reading_list && python3.6 get_reading_list.py
fi
