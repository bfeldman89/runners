#!/bin/bash

# scrape the 4 or 5 jails that don't work on pa
cd ~/code/jail_scrapers
# pipenv run python scrapers.py kcdc,jcdc,tcdc,ccdc,ccj 5
# work with pdfkit & imgkit stuff that doesn't work via PyAn
# jail scraper pdfs
pipenv run python pdf_stuff.py

# msleg pdfs
cd ~/code/msleg_scraper
pipenv run python msleg_scraper.py
pipenv run python senate_cmte_agendas.py

# mdoc covid pdf now scheduled via PyAn at 7pm
# cd ~/code/mdoc_scraper
# pipenv run python mdoc_covid.py

# TODO: find out how to automate deleting from reading list
cd ~/code/reading_list
the_hour="$(date +"%H")"
if (( $(( ${the_hour#0} % 2 )) == 1 )); then
    pipenv run python muh_news.py
elif [ "$the_hour" = "05" ]; then
    pipenv run python get_reading_list.py
fi
