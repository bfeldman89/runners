# !/usr/bin/env python3
import sys
sys.path.append('/Users/blakefeldman/code/msleg_scraper')
sys.path.append('/Users/blakefeldman/code/jail_scrapers')


for x in sys.path:
    print(x)


import scrapers
try:
    scrapers.main()
except ModuleNotFoundError as err:
    print(err)

"""
sys.path.append('/Users/blakefeldman/code/mdoc_scraper')
sys.path.append('/Users/blakefeldman/code/sos_scraper')
sys.path.append('/Users/blakefeldman/code/jail_scrapers')
sys.path.append('/Users/blakefeldman/code/reading_list')
sys.path.append('/Users/blakefeldman/code/scheduled_tweets')
sys.path.append('/Users/blakefeldman/code/police_shootings')
"""
