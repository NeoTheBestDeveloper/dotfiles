#!/bin/bash

sudo -H pacman -S --noconfirm \
    python python-pip python-lxml python-babel \
    uwsgi uwsgi-plugin-python \
    git base-devel libxml2 \
    shellcheck

sudo -H useradd --shell /bin/bash --system \
    --home-dir "/usr/local/searx" \
    --comment 'Privacy-respecting metasearch engine' searx

sudo -H mkdir "/usr/local/searx"
sudo -H chown -R "searx:searx" "/usr/local/searx"

sudo -H -u searx git clone "https://github.com/searxng/searxng" "/usr/local/searx/searx-src"
sudo -H -u searx python3 -m venv "/usr/local/searx/searx-pyenv"
PIP="/usr/local/searx/searx-pyenv/bin/pip3"

sudo -H -u searx $PIP install -U pip
sudo -H -u searx $PIP install -U setuptools
sudo -H -u searx $PIP install -U wheel
sudo -H -u searx $PIP install -U pyyaml

cd "/usr/local/searx/searx-src"
sudo -H -u searx $PIP install -e .

sudo -H mkdir -p "/etc/searxng"
sudo -H cp "/usr/local/searx/searx-src/searx/settings.yml" \
             "/etc/searxng/settings.yml"
sudo mkdir /etc/uwsgi

sudo echo  '# -*- mode: conf; coding: utf-8  -*-
[uwsgi]

# uWSGI core
# ----------
#
# https://uwsgi-docs.readthedocs.io/en/latest/Options.html#uwsgi-core

# Who will run the code
uid = searx
gid = searx

# set (python) default encoding UTF-8
env = LANG=C.UTF-8
env = LANGUAGE=C.UTF-8
env = LC_ALL=C.UTF-8

# chdir to specified directory before apps loading
chdir = /usr/local/searx/searx-src/searx

# SearXNG configuration (settings.yml)
env = SEARXNG_SETTINGS_PATH=/etc/searxng/settings.yml

# disable logging for privacy
# logger = systemd
# disable-logging = true

# The right granted on the created socket
chmod-socket = 666

# Plugin to use and interpretor config
single-interpreter = true

# enable master process
master = true

# load apps in each worker instead of the master
lazy-apps = true

# load uWSGI plugins
plugin = python

# By default the Python plugin does not initialize the GIL.  This means your
# app-generated threads will not run.  If you need threads, remember to enable
# them with enable-threads.  Running uWSGI in multithreading mode (with the
# threads options) will automatically enable threading support. This *strange*
# default behaviour is for performance reasons.
enable-threads = true


# plugin: python
# --------------
#
# https://uwsgi-docs.readthedocs.io/en/latest/Options.html#plugin-python

# load a WSGI module
module = searx.webapp

# set PYTHONHOME/virtualenv
virtualenv = /usr/local/searx/searx-pyenv

# add directory (or glob) to pythonpath
pythonpath = /usr/local/searx/searx-src


# speak to upstream
# -----------------
#
# Activate the 'http' configuration for filtron or activate the 'socket'
# configuration if you setup your HTTP server to use uWSGI protocol via sockets.

# using IP:
#
# https://uwsgi-docs.readthedocs.io/en/latest/Options.html#plugin-http
# Native HTTP support: https://uwsgi-docs.readthedocs.io/en/latest/HTTP.html

http = 127.0.0.1:8888

# using unix-sockets:
#
# On some distributions you need to create the app folder for the sockets::
#
#   mkdir -p /run/uwsgi/app/searxng/socket
#   chown -R searx:searx  /run/uwsgi/app/searxng/socket
#
# socket = /run/uwsgi/app/searxng/socket

# uwsgi serves the static files
# expires set to one year since there are hashes
static-map = /static=/usr/local/searx/searx-src/searx/static
static-expires = /* 31557600
static-gzip-all = True
offload-threads = %k

# Cache
cache2 = name=searxngcache,items=2000,blocks=2000,blocksize=4096,bitmap=1'| sudo tee /etc/uwsgi/searxng.ini

echo "Run: '/usr/bin/uwsgi --ini /etc/uwsgi/searxng.ini'"

sudo -H sed -i -e "s/ultrasecretkey/$(openssl rand -hex 16)/g" "/etc/searxng/settings.yml"
