#!/usr/bin/env python
import serial
import time
import os
import random
import rospy
from std_msgs.msg import Float64

class LoadCellSensor(object):
    def __init__(self):
        '''Parameters Inicialization '''
        self.serial_port = rospy.get_param("port","/dev/ttyACM0")
        os.system("sudo chmod 777 " + self.serial_port) #Enabling port permissions
        self.port_parameters = { "br": rospy.get_param("baud_rate", 115200) }
        self.ser = serial.Serial(self.serial_port, self.port_parameters["br"])
        self.pub_frontal = rospy.Publisher("frontal_loadcell_data", Float64, queue_size = 1, latch = False)
        self.pub_posterior = rospy.Publisher("posterior_loadcell_data", Float64, queue_size = 1, latch = False)
        ''' Node Configuration '''
        rospy.init_node('loadcell_sensor', anonymous = True)
        self.fs = 1000

    def read_data(self):
        voltage1 = 0
        voltage2 = 0
        try:
            data = self.ser.readline()
            voltage1 = float(data[0:6])
            voltage2 = float(data[8:16])
            #print(voltage1,voltage2)
        except:
            rospy.logwarn("Data not received")

        return (voltage1,voltage2)


def main():
    loadcell_sensor = LoadCellSensor()
    rate = rospy.Rate(loadcell_sensor.fs)
    rospy.loginfo('Mining Data')
    while not rospy.is_shutdown():
        voltage1,voltage2 = loadcell_sensor.read_data()
        loadcell_sensor.pub_posterior.publish(voltage1)
        loadcell_sensor.pub_frontal.publish(voltage2)
        rate.sleep()
    loadcell_sensor.ser.close()
    rospy.loginfo('Closed Port')

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt as e:
        os.system('clear')
        print("Program finished\n")
        print e
        raise
