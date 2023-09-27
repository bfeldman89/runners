#!/bin/bash

# 1. SOME JAIL SCRAPING MODULES ARE RUN EVERY HOUR
# Only 7 dockets are working via PyAn (mcdc, prcdf, lcdc, jcadc, hcdc, acdc, and jcj).
# The other 5 dockets (kcdc, jcdc, tcdc, ccdc, and ccj) are scraped from the local netweork.
# Because MS internet is trash, I scrape 2/5 dockets every odd hour and 3/5 dockets every even hour.
# cd ~/code/jail_scrapers
# the_hour="$(date +"%H")"
# if (( $(( ${the_hour#0} % 2 )) == 1 )); then
#     pipenv run python scrapers.py kcdc,ccj 7
# else
#     pipenv run python scrapers.py jcdc,tcdc,ccdc 7
# fi
# clean the data and upload any new pdfs
# pipenv run python polish_data.py
# pipenv run python pdf_stuff.py

# 2. RUN THE MSLEG SCRAPERS LOCALLY EVERY HOUR
cd ~/code/msleg_scraper
pipenv run python msleg_scraper.py
pipenv run python senate_cmte_agendas.py

# 3. CHECK MDOC FOR COVID UPDATES EVERY HOUR
# cd ~/code/mdoc_scraper && pipenv run python mdoc_covid.py

# 4. SCRAPE NEWS AND CLEAN TEXT EVERY OTHER HOUR
# cd ~/code/reading_list
# if (( $(( ${the_hour#0} % 2 )) == 1 )); then
#     pipenv run python muh_news.py
# elif [ "$the_hour" == "22" ]; then
#     once a day, the Safari reading list will be scraped
#     this hour can be anytime, as long as it is even
#     pipenv run python get_reading_list.py
# fi
