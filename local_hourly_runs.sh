#!/bin/bash

# work with pdfkit & imgkit stuff that doesn't work on pa
cd ~/code/jail_scrapers && pipenv run python pdf_stuff.py
cd ~/code/msleg_scraper && pipenv run python msleg_scraper.py && pipenv run python senate_cmte_agendas.py

# TODO: find out how to automate deleting from reading list
the_hour="$(date +"%H")"
if [ "$the_hour" = "07" ]; then
    cd ~/code/reading_list && pipenv run python get_reading_list.py
fi
