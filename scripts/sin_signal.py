#!/usr/bin/env python2
# -*- coding: utf-8 -*-
import rospy
import time
import os
import math
import numpy
from dynamixel_workbench_msgs.msg import DynamixelStatusList
from tflex_test_bench.msg import IMUData
from geometry_msgs.msg import Vector3
from std_msgs.msg import Int16, Float64
from sensor_msgs.msg import Imu

class Controller(object):
    def __init__(self):
        rospy.init_node('tflex_test_bench_topics_synchronization', anonymous = True)
        self.pub_sin_signal_motor1 = rospy.Publisher("/tilt_controller/command", Float64, queue_size = 1, latch = False) 
        self.t = [i*0.01 for i in range(100000)]
        self.sin = []
        for i in range(len(self.t)):
            self.sin.append(math.sin(20*math.pi*self.t[i]))
        self.i = 0

    def process(self):
        self.pub_sin_signal_motor1.publish(self.sin[self.i])
        self.i+=1
        if self.i == len(self.sin):
            self.i = 0
        

def main():

    c = Controller()
    rate = rospy.Rate(100)
    while not (rospy.is_shutdown()):
        c.process()
        rate.sleep()
    rospy.on_shutdown(c.process)
    rospy.loginfo("Synchronization Finished")

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt as e:
        print (e)
