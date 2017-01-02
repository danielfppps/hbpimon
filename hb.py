import struct
import bluepy.btle as btle
import sys
from time import sleep
from tendo import singleton

me = singleton.SingleInstance() 

heartrate_uuid = btle.UUID(0x2a37)

class heartMonitor:
    def __init__(self, mac):
        try:
            self.p = btle.Peripheral(mac)
            self.p.setDelegate(heartDelegate())
        except:
            self.p = 0
            print "Not connected"

    def startMonitor(self):
        try:
            self.p.writeCharacteristic(0x12, struct.pack('<bb', 0x01, 0x00), False)
            self.p.writeCharacteristic(0x11, '\x04', False)
        except:
            e = sys.exc_info()[0]
            print("HeartMonitor Error: %s" % e)
            try:
                self.p.disconnect()
            except:
                return 0

    def getHeartbeat(self):
        try:
            self.p.waitForNotifications(1.0)
            return self.p.delegate.getlastbeat()
        except:
            return 0

    def stopMonitor(self):
        self.p.writeCharacteristic(0x11, '\x00', False)


class heartDelegate(btle.DefaultDelegate):
    message = 0

    def __init__(self):
        btle.DefaultDelegate.__init__(self)

    def handleNotification(self, cHandle, data):
        if(data[0] == '\x14'):
            self.message = "Connection Lost"
        if(data[0] == '\x16'):
            self.message = str(struct.unpack("B", data[1])[0])
        if(data[0] == '\x06'):
            self.message = "Booting"

    def getlastbeat(self):
        return self.message

hrm = heartMonitor("00:22:D0:2C:13:7E")
hrm.startMonitor()

while True:
    sleep(1) # Need this to slow the changes down
    try:
        hb = int(hrm.getHeartbeat())
        with open('hb.txt', 'w') as f:
            f.write('{}'.format(hb))
    except:
        hrm = heartMonitor("00:22:D0:2C:13:7E")
        hrm.startMonitor()
        continue
    
