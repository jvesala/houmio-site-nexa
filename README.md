    Install telldus - http://lassesunix.wordpress.com/2013/08/12/installing-telldus-core-on-raspberry-pi/

    Checkout this project to /home/pi/houmio-site-nexa (or update supervisor.conf)

    npm install -g coffee-script
    npm install
    Insert your HORSELIGHTS_SITEKEY into supervisor.conf

    Press + -> Light -> General Device
    Select Binary or Dimmable
    Vendor: nexa
    Vendor address: should match id configured in /etc/tellstick.conf (see tdtool -l)


