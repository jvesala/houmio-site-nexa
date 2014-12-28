    Install telldus - http://lassesunix.wordpress.com/2013/08/12/installing-telldus-core-on-raspberry-pi/

    npm install -g coffee-script
    npm install
    Edit supervisor.conf
    HORSELIGHTS_SITEKEY=<yoursitekey> coffee site.coffee

    supervisorctl restart houmio-site-nexa

    (Or alternatively update supervirot and insert your HORSELIGHTS_SITEKEY into supervisor.conf in env)

    Press + -> Light -> General Device
    Select Binary or Dimmable
    Vendor: nexa
    Vendor address: should match id configured in /etc/tellstick.conf (see tdtool -l)


