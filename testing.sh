#!/bin/bash

# working on PA (personal) consoles
source ~/.bashrc && cd ~/code/jail_scrapers
pipenv run python scrapers.py mcdc,prcdf,lcdc,jcadc 10
pipenv run python scrapers.py jcj,acdc,hcdc 20

# working on PA (splc account) consoles???
source ~/.bashrc && cd ~/code/jail_scrapers && pipenv run python scrapers.py kcdc,jcdc,tcdc,ccdc,ccj 8

# working on local Mac via crontab/terminal???
source ~/.bashrc && cd ~/code/jail_scrapers && pipenv run python scrapers.py all
