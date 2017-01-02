# hbpimon
This is a real-time heart-beat monitoring application intended for use with a raspberry-pi 3 and a Polar H7 heart-beat sensor. Heart beats are recorded using the hb.py script into a txt file and these values are then read and graphed in realtime by the Lazarus application hb_project.

To run this application make sure you intall bluepy and tendo using pip:

> sudo pip install bluepy tendo

after this edit your autostart script by using this command:

> sudo nano /home/pi/.config/lxsession/LXDE-pi/autostart

then add the following two lines to the file: 

> @python /home/pi/HB_PORJECT/hb.py
> @/home/pi/HB_PROJECT/hb_project

Next time you start your raspberry pi the heartbeat recording scripts and GUI will automatically start. I tested this using a simple 3.5' TFT screen (https://www.dfrobot.com/index.php?route=product/product&product_id=1539). But it should work with other similar screens as well.
Other heart-beat sensors should also work provided they comply with the heart-beat bluetooth sensor standard.

To modify the heartbeat monitoring GUI you should first install Lazarus:

> sudo apt-get install Lazarus

Then open up the hb_project.lpi file within the Lazarus IDE.

