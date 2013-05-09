#!/usr/bin/env bash
# BookHero start up script
# Coded by Werner Gillmer <werner.gillmer@gmail.com>


function firstTime
{
	echo "Setting up BookHero for the first time."
	bundle install
	rake db:reset
	rake db:migrate
	exit 0
}

function startBookHero
{
	echo "starting"
}

function stopBookHero
{
	echo "stopping"
}


case "$1" in
	--firsttime) firstTime "1" ;;
    --start) startBookHero "2" ;;
    --stop) stopBookHero ;; 
    *) echo "Usage : "
       echo "    --firstime (Run this the first time your setting up BookHero)"
       echo "    --start (Start up BookHero)"
       echo "    --stop (Stop BookHero)"
     ;;
esac
