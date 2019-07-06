#!/usr/bin/env python
import serial
import time
import os
import random
import rospy
from std_msgs.msg import Float64

class LoadSensor(object):
    def __init__(self):
        '''Parameters Inicialization '''
        self.serial_port = rospy.get_param("port","/dev/ttyUSB1")
        os.system("sudo chmod 777 " + self.serial_port) #Enabling port permissions
        self.port_parameters = {
                                 "br": rospy.get_param("baud_rate", 9600),
                                 "bs": rospy.get_param("byte_size", 8),
                                 "p": rospy.get_param("parity", 'E'),
                                 "sb": rospy.get_param("stop_bits", 1),
                                 "adc_f": rospy.get_param("adc_frequency",960)}
        self.ser = serial.Serial(self.serial_port, self.port_parameters["br"], bytesize=self.port_parameters["bs"], parity=self.port_parameters["p"] , stopbits=self.port_parameters["sb"])
        self.num_decoding = {
                            "0x7e": 0, "0x3e":0, "0x9f":0, "0x6e":0, "0xee":0,
                            "0x9d":1, "0x3a":1, "0x9d":1, "0x67":1,
                            "0x36":2, "0x33":2, "0x9b":2,
                            "0x32":3, "0x99":3, "0xe6":3,
                            "0x2e":4, "0x97":4,
                            "0x2a":5, "0x95":5, "0xe5":5, "0xb9":5, "0xae":5,
                            "0x26":6, "0x93":6, "0x72":6,
                            "0x22":7, "0x91": 7, "0x64":7,  "0xa6":7,
                            "0x1e":8, "0x8f":8, "0xcc":8,"0x4c":8,
                            "0x8d":9, "0x1a":9,  "0xe3":9, "0x5c":9}
        self.sign_decoding = {"0xf9":1, "0x79": -1}
        ''' Publisher '''
        self.pub = rospy.Publisher("load_data", Float64, queue_size = 1, latch = False)
        ''' Node Configuration '''
        rospy.init_node('load_sensor', anonymous = True)
        self.fs = 100

    def read_data(self):
        try:
            data_header = self.ser.read(1)
            if (hex(ord(data_header)) == '0x3f'):
                data = map(hex, map(ord, self.ser.read(14)))
                if "0x3f" in data:
                    time.sleep(1/(self.port_parameters["adc_f"]))
                    self.read_data()
                else:
                    sign = self.sign_decoding.get(data[3], 1)
                    try:
                        load = sum([ sign*self.num_decoding[data[i]]*(10.0**(6-i)) for i in range(5,10)])
                        return load
                    except:
                        rospy.logwarn("Unrecognized Data: ",data);
                        print("x", "    ", data2)
            else:
                time.sleep(1/(self.port_parameters["adc_f"]))
                self.read_data()
        except:
            rospy.logwarn("Data not received")


def main():
    load_sensor = LoadSensor()
    rate = rospy.Rate(load_sensor.fs)
    rospy.loginfo('Mining Data')
    while not rospy.is_shutdown():
        load = load_sensor.read_data()
        #load = random.random() + random.randrange(0, 10)
        if (load != 0.0):
            load_sensor.pub.publish(load)
        rate.sleep()
    load_sensor.ser.close()
    rospy.loginfo('Closed Port')

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt as e:
        os.system('clear')
        print("Program finished\n")
        print e
        raise
