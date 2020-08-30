# runners

[![codefactor](https://www.codefactor.io/repository/github/bfeldman89/runners/badge?style=plastic)](https://www.codefactor.io/repository/github/bfeldman89/runners)
![GitHub](https://img.shields.io/github/license/bfeldman89/runners?style=plastic)

![Twitter Follow](https://img.shields.io/twitter/follow/botfeldman89?style=social)
![Twitter Follow](https://img.shields.io/twitter/follow/bfeldman89?style=social)

## local schedule

```cron
PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin

# RUNNING VIA THIS COMPUTER VIA THIS CRONTAB FILE
# every hour at 40 minutes past the hour, run local_hourly_runs.sh, which
# runs the jails, msleg, reading list and news, and MDOC covid data scrapers.
40 * * * * source ~/.bash_profile && cd ~/code/runners && ./local_hourly_runs.sh


# RUNNING VIA DAILY TASKS ON PYTHONANYWHERE
# at 8am (13 UTC), scrape WaPo police shootings data
# 0 8 * * * source ~/.bash_profile && cd ~/code/police_shootings && pipenv run python police_shootings.py

# at 9am (14 UTC), email 3XP yesterday's covid data
# 0 9 * * * source ~/.bash_profile && cd ~/code/3xp && pipenv run python covid_tracker.py

# at 10am (15 UTC) update legislation tracker
# 0 10 * * * source ~/.bash_profile && cd ~/code/msleg_scraper && pipenv run python msleg_openstates.py

# at 11am (16 UTC) get yesterday's admits and population data for each jail
# 0 11 * * * source ~/.bash_profile && cd ~/code/jail_scrapers && pipenv run python snapshot.py
```

I have to locally run all of my scrapers that require `pdfkit`, and I'm running them each via `local_hourly_runs.sh`. More specifically, `local_hourly_runs.sh` is scheduled to run ever hour at 40 minutes past the hour via a cron job on my MacBook.

To view the schedule, open the terminal, and enter `crontab -l`. To edit the schedule, enter `crontab -e`.

## virtual server schedule

Frequency|Time|Command
---|---|---
Daily|00:00|`source ~/.bashrc && cd ~/code/runners && ./update_pa.sh`
Daily|13:00|`source ~/.bashrc && cd ~/code/police_shootings && pipenv run python police_shootings.py`
Daily|14:00|`source ~/.bashrc && cd ~/code/3xp && pipenv run python covid_tracker.py`
Daily|16:00|`source ~/.bashrc && cd ~/code/jail_scrapers && pipenv run python snapshot.py`
Hourly|05 mins past|`source ~/.bashrc && cd ~/code/runners && ./pa_hourly_runs.sh`



Of course, if pythonanywhere has the ability to run any of my scrapers, that's where I'll run them. For now -- everything other than `msleg_scraper.py` and `jail_scrapers/pdf_stuff` -- runs through `pa_hourly_runs.sh`, which itself is run up as an **hourly task** at pythonanywhere.


I use `~/code/update_repos.sh` to keep all the repos on pythonanywhere up to date. I manually run it in a pythonanywhere bash console when I've just finished working on the code and know I've pushed changes to `pa_hourly_runs.sh`. Also, just in case, it's also run as a **daily task** once a day at 0 o'clock (UTC).


## environment variables

### MacBook Air
The variables are located in `~/.exports`

```cron
export AIRTABLE_API_KEY="*****"
export botfeldman89_db="*****"
export jail_scrapers_db="*****"
export jails_archive_db="*****"
export articles_db="*****"
export other_scrapers_db="*****"
export msleg_db="*****"
export ms_jail_db="*****"
export police_violence_db="*****"
export log_db="*****"
export dc_db="*****"
export xxxp_db="*****"
export CLOUDCONVERT_API_KEY="*****"
export CLOUDINARY_CLOUD_NAME="*****"
export CLOUDINARY_API_KEY="*****"
export CLOUDINARY_API_SECRET="*****"
export DOCUMENT_CLOUD_USERNAME="*****"
export DOCUMENT_CLOUD_PW="*****"
export GMAIL_USERNAME="*****"
export GMAIL_PW="*****"
export IFTTT_WEBHOOKS_URL="*****"
export MUCKROCK_TOKEN="*****"
export MUCKROCK_USERNAME="*****"
export MUCKROCK_PW="*****"
export PYTHONANYWHERE_TOKEN="*****"
export TWILIO_SID="*****"
export TWILIO_TOKEN="*****"
export TWITTER_APP_KEY="*****"
export TWITTER_APP_SECRET="*****"
export TWITTER_OAUTH_TOKEN="*****"
export TWITTER_OAUTH_TOKEN_SECRET="*****"
export webshare_proxy_api_key="*****"

export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR=nano
export PIPENV_IGNORE_VIRTUALENVS=1
```

### PythonAnywhere
The variables are located in `~/.bashrc`

```cron
# Load up standard site-wide settings.
source /etc/bashrc

# Setting the timezone to CST
export TZ="America/Chicago"

#remove duplicate entries from history
export HISTCONTROL=ignoreboth

# Show current git branch in prompt.
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
LIGHT_GREEN="\[\033[1;32m\]"
LIGHT_GRAY="\[\033[0;37m\]"
PS1="$LIGHT_GRAY\$(date +%H:%M) \w$YELLOW \$(parse_git_branch)$LIGHT_GREEN\$ $LIGHT_GRAY"

# Airtable keys
export AIRTABLE_API_KEY="*****"
export botfeldman89_db="*****"
export jail_scrapers_db="*****"
export jails_archive_db="*****"
export articles_db="*****"
export other_scrapers_db="*****"
export msleg_db="*****"
export ms_jail_db="*****"
export police_violence_db="*****"
export log_db="*****"
export dc_db="*****"
export xxxp_db="*****"


# Other keys (cloudinary, documentcloud, twitter, gmail, ifttt, muckrock, twilio)
export CLOUDINARY_CLOUD_NAME="*****"
export CLOUDINARY_API_KEY="*****"
export CLOUDINARY_API_SECRET="*****"
export DOCUMENT_CLOUD_USERNAME="*****"
export DOCUMENT_CLOUD_PW="*****"
export GMAIL_USERNAME="*****"
export GMAIL_PW="*****"
export IFTTT_WEBHOOKS_URL="*****"
export MUCKROCK_TOKEN="*****"
export MUCKROCK_USERNAME="*****"
export MUCKROCK_PW="*****"
export PYTHONANYWHERE_TOKEN="*****"
export TWILIO_SID="*****"
export TWILIO_TOKEN="*****"
export TWITTER_APP_KEY="*****"
export TWITTER_APP_SECRET="*****"
export TWITTER_OAUTH_TOKEN="*****"
export TWITTER_OAUTH_TOKEN_SECRET="*****"
export webshare_proxy_api_key="*****"

# Load virtualenvwrapper
source virtualenvwrapper.sh &> /dev/null

# pipenv stuff
export PIPENV_IGNORE_VIRTUALENVS=1
```
