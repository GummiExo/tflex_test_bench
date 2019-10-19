#!/usr/bin/env python
import serial
import time
import os
import random
import rospy
import numpy
from std_msgs.msg import Float64,Int16
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
        self.m1 = 2756.88   #Posterior
        self.m2 = 349.87    #Frontal
        self.vo1 = 0
        self.vo2 = 0

    def initial_value(self):
        ''' Calculating Initial Values '''
        n = 0
        mean_value_posterior = []
        mean_value_frontal = []
        while n<=200:
            value_posterior,value_frontal = self.read_data();
            if value_posterior != 0.0:
                mean_value_posterior = numpy.append(mean_value_posterior, value_posterior)
            if value_frontal != 0.0:
                mean_value_frontal = numpy.append(mean_value_frontal, value_frontal)
            n += 1
        print("Frontal")
        print(mean_value_frontal)
        print("Posterior")
        print(mean_value_posterior)
        self.vo1 = numpy.mean(mean_value_posterior[0:10], axis=0, dtype=numpy.float64)
        self.vo2 = numpy.mean(mean_value_frontal[-50::], axis=0, dtype=numpy.float64)
        rospy.loginfo("Initial Value Frontal: %s",self.vo2)
        rospy.loginfo("Initial Value Posterior: %s",self.vo1)

    def read_data(self):
        value_posterior = 0
        value_frontal = 0
        try:
            data = self.ser.readline()
            pos_data = data.find('\t')
            # print(data[0:6])
            # print(data[11:17])
            if pos_data == 10:
                pos_frontal = 3
            else:
                pos_frontal = 0
            value_frontal = float(data[pos_frontal:pos_data-1])
            value_posterior = float(data[pos_data::])
        except:
            rospy.logwarn("Data not received")
        return (value_posterior,value_frontal)

    def force(self,value,m,vo):
        f = (value - vo)/m
        return f


def main():
    loadcell_sensor = LoadCellSensor()
    rate = rospy.Rate(loadcell_sensor.fs)
    loadcell_sensor.initial_value()
    rospy.loginfo('Mining Data')
    while not rospy.is_shutdown():
        value_posterior,value_frontal = loadcell_sensor.read_data()
        force1 = loadcell_sensor.force(value_posterior,loadcell_sensor.m1,loadcell_sensor.vo1);
        force2 = loadcell_sensor.force(value_frontal,loadcell_sensor.m2,loadcell_sensor.vo2)
        if value_posterior != 0:
            loadcell_sensor.pub_posterior.publish(value_posterior)
            loadcell_sensor.pub_posterior_force.publish(force1)
        if value_frontal != 0:
            loadcell_sensor.pub_frontal.publish(value_frontal)
            loadcell_sensor.pub_frontal_force.publish(force2)
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
