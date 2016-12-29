#!/usr/bin/env sh

#run the default config script
sh /srv/config.sh

#chown the sickrage directory by the new user
chown mediadepot:mediadepot -R /srv/plexpy

# download the latest version of PlexPy
[[ ! -d /srv/plexpy/app/.git ]] && su -c "git clone https://github.com/JonnyWong16/plexpy.git /srv/plexpy/app" mediadepot

# opt out for autoupdates using env variable
if [ -z "$ADVANCED_DISABLEUPDATES" ]; then
	# update the application
	cd /srv/plexpy/app/ && su -c "git pull" mediadepot
fi

# run PlexPy
su -c "/usr/bin/python /srv/plexpy/app/PlexPy.py --datadir /srv/plexpy/data --config /srv/plexpy/config/plexpy.ini" mediadepot