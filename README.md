# runners

[![codefactor](https://www.codefactor.io/repository/github/bfeldman89/runners/badge?style=plastic)](https://www.codefactor.io/repository/github/bfeldman89/runners)
![GitHub](https://img.shields.io/github/license/bfeldman89/runners?style=plastic)

![Twitter Follow](https://img.shields.io/twitter/follow/botfeldman89?style=social)

![Twitter Follow](https://img.shields.io/twitter/follow/bfeldman89?style=social)

## local schedule

```cron
PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin

40 * * * * source ~/.bash_profile && cd ~/code/runners && ./local_hourly_runs.sh
```

I have to locally run all of my scrapers that require `pdfkit`, and I'm running them each via `local_hourly_runs.sh`. More specifically, `local_hourly_runs.sh` is scheduled to run ever hour at 40 minutes past the hour via a cron job on my Macbook.

## virtual server schedule

Frequency|Time|Command
---|---|---
Daily|00:00|`source ~/.bashrc && cd ~/code/runners && ./update_pa.sh`
Hourly|05 mins past|`source ~/.bashrc && cd ~/code/runners && ./pa_hourly_runs.sh`


Of course, if pythonanywhere has the ability to run any of my scrapers, I that's where I'll run them. For now -- everything other than `msleg_scraper.py` and `jail_scrapers/pdf_stuff` -- runs through `pa_hourly_runs.sh`, which itself is run up as an **hourly task** at pythonanywhere.


I use `~/code/update_repos.sh` to keep all the repos on pythonanywhere up to date. I manually run it in a pythonanywhere bash console when I've just finished working on the code and know I've pushed changes to `pa_hourly_runs.sh`. Also, just in case, it's also run as a **daily task** once a day at 0 o'clock (UTC).
