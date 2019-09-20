#!/usr/bin/env python
import serial
import time
import os
import random
import rospy
import numpy
from std_msgs.msg import Float64
from scipy.signal import butter

class LoadCellSensor(object):
    def __init__(self):
        '''Parameters Inicialization '''
        self.serial_port = rospy.get_param("port","/dev/ttyACM0")
        os.system("sudo chmod 777 " + self.serial_port) #Enabling port permissions
        self.port_parameters = { "br": rospy.get_param("baud_rate", 1000000) }
        self.ser = serial.Serial(self.serial_port, self.port_parameters["br"])
        self.pub_frontal = rospy.Publisher("frontal_loadcell_data", Float64, queue_size = 1, latch = False)
        self.pub_posterior = rospy.Publisher("posterior_loadcell_data", Float64, queue_size = 1, latch = False)
        self.pub_frontal_force = rospy.Publisher("frontal_loadcell_force", Float64, queue_size = 1, latch = False)
        self.pub_posterior_force = rospy.Publisher("posterior_loadcell_force", Float64, queue_size = 1, latch = False)
        ''' Node Configuration '''
        rospy.init_node('loadcell_sensor', anonymous = True)
        self.fs = 1000
        ''' Loadcell Configuration '''
        self.m1 = 664.6   #Posterior
        self.m2 = 691.3322    #Frontal
        self.vo1 = 0
        self.vo2 = 0

    def initial_value(self):
        ''' Calculating Initial Values '''
        n = 0
        mean_value1 = []
        mean_value2 = []
        while n<=100:
            value1,value2 = self.read_data();
            mean_value1 = numpy.append(mean_value1, value1)
            mean_value2 = numpy.append(mean_value2, value2)
            n += 1
        print(mean_value1[-50::])
        self.vo1 = numpy.mean(mean_value1[-50::], axis=0, dtype=numpy.float64)
        self.vo2 = numpy.mean(mean_value2[-100::], axis=0)
        rospy.loginfo("Initial Value Frontal: %s",self.vo2)
        rospy.loginfo("Initial Value Posterior: %s",self.vo1)

    def read_data(self):
        value1 = 0
        value2 = 0
        try:
            data = self.ser.readline()
            # print(data[19])
            value2 = float(data[5:15])
            #value1 = float(data)
            value1 = float(data[20:30])
            #value2 = float(data[8:15])
        except:
            rospy.logwarn("Data not received")
        return (value1,value2)

    def force(self,value,m,vo):
        f = (value - vo)/m
        return f


def main():
    loadcell_sensor = LoadCellSensor()
    rate = rospy.Rate(loadcell_sensor.fs)
    loadcell_sensor.initial_value()
    rospy.loginfo('Mining Data')
    while not rospy.is_shutdown():
        value1,value2 = loadcell_sensor.read_data()
        force1 = loadcell_sensor.force(value1,loadcell_sensor.m1,loadcell_sensor.vo1);
        #force2 = loadcell_sensor.force(value2,loadcell_sensor.m2,loadcell_sensor.vo2)
        loadcell_sensor.pub_posterior.publish(value1)
        loadcell_sensor.pub_frontal.publish(value2)
        loadcell_sensor.pub_posterior_force.publish(force1)
        #loadcell_sensor.pub_frontal_force.publish(force2)
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
