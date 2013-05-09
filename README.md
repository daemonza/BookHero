BookHero
========

## eBook web library

eBook library written in Ruby (Rails) using Google Books API for metadata information.

I had the need for a web based eBook manager, that can run on my home server, from where I can
browse my library from any of my devices(ipad, macbook, android phone etc.).

At the moment the core basic features work
* Listing books
* Able to download books
* Remove books from library (only remove in BookHero)
* Scan for new books

Got a couple of more features planned, but that's it for now.

![Main Window](https://raw.github.com/daemonza/BookHero/master/screenshots/main.png)

![Book Description](https://raw.github.com/daemonza/BookHero/master/screenshots/main_description.png)


Using Zurb Foundation responsive css design BookHero works on most mobile devices. 

![iPhone](https://raw.github.com/daemonza/BookHero/master/screenshots/iphone.png)

![iPhone Book Description](https://raw.github.com/daemonza/BookHero/master/screenshots/iphone_description.png)


## Installation 

First thing, you need Ruby and Rails working to run BookHero. Have a look at
https://rvm.io/rvm/install/
to setup it up. Basically you need to run the following command :

        curl -#L https://get.rvm.io | bash -s stable --autolibs=3 --ruby

Git clone the repository
cd  to BookHero directory and run the

        BookHero --firsttime

command.
This will setup BookHero for it's first startup and then start it.

## Usage

To start BookHero run :

        BookHero --start

This will start BookHero on http://127.0.0.1:9911 --- or any other IP that's configured on your host.

To add books to BookHero Library, got to Settings, fill in the full path to the directory where all your eBooks are
don't worry about the order of your eBooks in this library, BookHero will scan through everything.

Add you Google Book API (note you don't have to do this, but BookHero works MUCH better with one, due to the Google API usage
restrictions.) To get a Google Books API go to : 

https://code.google.com/apis/console
Go to Services, set Books to "On"
Click on "API access" and copy the API key and enter it on the Settings page in Bookhero   


Click the "Scan now" button at the top for BookHero to start scanning for books and importing them.     

To stop BookHero run :

        BookHero --stop

## Issues

BookHero use the Google Books API to get all the information about the books in the library. Google limits
you to 1000 API requests a day. Which normally would not be a issue on a day to day basis, however if you have
a ebook colleciton that's bigger than 1000, your going to hit the google limit during import. Busy looking at
a way to get around it.

It's tested on OS X (mountain lion), should work on any Linux/UNIX with Ruby/Rails enviroument. Things to look out
for might be the stop command of the BookHero script.