#!/usr/bin/env python2
# -*- coding: utf-8 -*-
import rospy
import time
import os
import math
import numpy
import scipy.signal
from dynamixel_workbench_msgs.msg import DynamixelStatusList
from tflex_test_bench.msg import IMUData
from geometry_msgs.msg import Vector3
from std_msgs.msg import Int16, Float64
from sensor_msgs.msg import Imu

class Controller(object):
    def __init__(self):
        rospy.init_node('tflex_test_bench_topics_synchronization', anonymous = True)
        self.pub_cmd_motor1 = rospy.Publisher("/tilt1_controller/command", Float64, queue_size = 1, latch = False)
        self.pub_cmd_motor2 = rospy.Publisher("/tilt2_controller/command", Float64, queue_size = 1, latch = False)
        self.pub_singal_norm_motor1 = rospy.Publisher("/goal_position_motor1", Int16, queue_size = 1, latch = False)
        self.t = [i*0.01 for i in range(12000)]
        self.sin = []
        f_sin = 1 #Hz
        for i in range(len(self.t)):
            self.sin.append(math.sin(f_sin*2*math.pi*self.t[i]))
        self.i = 0
        self.unit_rad = 2*math.pi/4095
        ''' Chirp Signal '''
        f0 = 0
        f1 = 10
        t1 = 30
        self.t = [i*0.01 for i in range(t1*100)]
        self.chirp_signal = scipy.signal.chirp(self.t, f0, t1, f1, method='linear', phi=0, vertex_zero=True)
        #print(len(self.chirp_signal))

    def sin_signal(self):
        factor_motor = 0.5
        self.pub_cmd_motor1.publish(-factor_motor*self.sin[self.i] + factor_motor)
        #self.pub_singal_norm_motor1.publish(self.sin[self.i] + 3295)
        self.i+=1
        if self.i == len(self.sin):
            self.i = 0

    def step_signal(self):
        f = 1
        max_range = 0.25
        self.pub_cmd_motor1.publish(-max_range)
        #self.pub_cmd_motor2.publish(max_range) #Stiffness
        self.pub_cmd_motor2.publish(0) #Flexion-Extension
        time.sleep(1/f) # Period
        self.pub_cmd_motor1.publish(0)
        #self.pub_cmd_motor2.publish(0) #Stiffness
        self.pub_cmd_motor2.publish(max_range) #Flexion-Extension
        time.sleep(1/f) # Period

    def chirp_publisher(self):
        factor_motor1 = 0.25
        self.pub_cmd_motor1.publish(factor_motor1*self.chirp_signal[self.i]-factor_motor1)
        #self.pub_cmd_motor2.publish(-factor_motor1*self.chirp_signal[self.i]+factor_motor1) #Stiffness
        self.pub_cmd_motor2.publish(factor_motor1*self.chirp_signal[self.i]+factor_motor1) #Flexion-Extension
        print(self.chirp_signal[self.i])
        self.i+=1
        if self.i == len(self.chirp_signal):
            self.i = 0


def main():

    c = Controller()
    trial = 0 # Step Response
    trial = 1 # Chirp Response
    rate = rospy.Rate(100)
    time.sleep(1)
    i = 0
    while not (rospy.is_shutdown()):
        ''' Sin Signal '''
        # c.sin_signal()
        # rate.sleep()
        if trial == 0:
            ''' Step Signal '''
            c.step_signal()
            i= i+1
            if (i == 10):
                break;
        if trial == 1:
            ''' Chirp Signal '''
            c.chirp_publisher()
            rate.sleep()
            if c.i == 0:
               break
    c.pub_cmd_motor1.publish(0)
    c.pub_cmd_motor2.publish(0)
    rospy.loginfo("Synchronization Finished")

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt as e:
        print (e)
