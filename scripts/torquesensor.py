#!/usr/bin/env python
import rospy
import serial
import numpy as np
import time
import os
from std_msgs.msg import Float64

class LoadSensor(object):
    def __init__(self, serial_port):
        self.serial_port = serial_port
        self.ser = serial.Serial(self.serial_port, 9600, parity ='E' )
        rospy.init_node('load_sensor', anonymous = True)
        self.pub = rospy.Publisher("load_sensor_data", Float64, queue_size = 1, latch = False)

    def read_data(self):
        flag = False
        self.received_data = self.ser.readline()
        if not len(self.received_data) == 16:
             self.read_data()
             rospy.logwarn('Data received incomplete')
        data = self.received_data[6:len(self.received_data)]
        data_m = []
        for i in range(1,len(data)):
            if not (data[i] == " " or data[i] =='\t' or data[i] =='\r' or data[i] =='\n'):
                data_m.append(data[i])
        load = "".join(data_m)
        return float(load)/10000 #N*m

def main():
    serial_port = "/dev/ttyUSB0"
    fs = 120 #Hz
    load_sensor = LoadSensor(serial_port)
    rate = rospy.Rate(fs)
    rospy.loginfo('Mining Data')
    while not rospy.is_shutdown():
        print("Entre")
        load = load_sensor.read_data()
        load_sensor.pub.publish(load)
        rate.sleep()
    load_sensor.ser.close()
    rospy.loginfo('Closed Port')

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt as e:
        sys.stdout.close()
        os.system('clear')
        print("Program finished\n")
        print e
        raise
