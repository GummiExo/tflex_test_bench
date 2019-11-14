#!/usr/bin/env python2
# -*- coding: utf-8 -*-
import rospy
import time
import os
import math
import numpy
import scipy.signal
from dynamixel_controllers.srv import SetKGain
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
        self.j = 0
        self.unit_rad = 2*math.pi/4095
        ''' Chirp Signal '''
        f0 = 0
        f1 = 10
        t1 = 30
        self.t = [i*0.01 for i in range(t1*100)]
        self.chirp_signal = scipy.signal.chirp(self.t, f0, t1, f1, method='linear', phi=0, vertex_zero=True)
        ''' Modeling Signal '''
        self.angle_rads = 0.2
        self.modeling_signal = [i*math.radians(0.088) for i in range(0,int(self.angle_rads/math.radians(0.088))+1)]
        self.modeling_signal = self.modeling_signal + list(reversed(self.modeling_signal))

    def sin_signal(self):
        factor_motor = 0.5
        self.pub_cmd_motor1.publish(-factor_motor*self.sin[self.i] + factor_motor)
        #self.pub_singal_norm_motor1.publish(self.sin[self.i] + 3295)
        self.i+=1
        if self.i == len(self.sin):
            self.i = 0

    def step_signal(self):
        f = 0.5
        max_range = 0.2
        self.pub_cmd_motor1.publish(-max_range)
        #self.pub_cmd_motor2.publish(max_range) #Stiffness
        self.pub_cmd_motor2.publish(0) #Flexion-Extension
        time.sleep(1/f) # Period
        self.pub_cmd_motor1.publish(0)
        #self.pub_cmd_motor2.publish(0) #Stiffness
        self.pub_cmd_motor2.publish(max_range) #Flexion-Extension
        time.sleep(1/f) # Period

    def chirp_publisher(self):
        #factor_motor = 0.2/2
        #factor_motor = 0.2
        factor_motor = 0.2/4
        self.pub_cmd_motor1.publish(factor_motor*self.chirp_signal[self.i]-factor_motor)
        #self.pub_cmd_motor2.publish(-factor_motor*self.chirp_signal[self.i]+factor_motor) #Stiffness
        self.pub_cmd_motor2.publish(factor_motor*self.chirp_signal[self.i]+factor_motor) #Flexion-Extension
        print(self.chirp_signal[self.i])
        self.i+=1
        if self.i == len(self.chirp_signal):
            self.i = 0

    def modeling(self):
        #Frontal Motor
        self.pub_cmd_motor1.publish(-self.modeling_signal[self.i])
        #self.pub_cmd_motor2.publish(self.modeling_signal[i])
        for j in range(0,len(self.modeling_signal)):
            self.pub_cmd_motor2.publish(self.modeling_signal[j])
            #self.pub_cmd_motor1.publish(-self.modeling_signal[j])
            time.sleep(0.01)
        self.i+=1
        if self.i == len(self.modeling_signal):
            self.i = 0

def set_pid_values(pretension_value):
    if pretension_value == 5:
        pid_service(id=1,p=30,i=25,d=0) #Frontal Motor
        time.sleep(0.1)
        pid_service(id=2,p=40,i=17,d=0) #Posterior Motor
    elif pretension_value == 10:
        pid_service(id=1,p=35,i=40,d=0) #Frontal Motor
        time.sleep(0.1)
        pid_service(id=2,p=36,i=36,d=0) #Posterior Motor
    elif pretension_value == 20:
        pid_service(id=1,p=32,i=55,d=0) #Frontal Motor
        time.sleep(0.1)
        pid_service(id=2,p=25,i=58,d=0) #Posterior Motor
    else:
        rospy.logerr("")

def pid_service(id,p,i,d):
    ''' PID services '''
    p_service = 'tilt' + str(id) + '_controller/set_p_gain'
    i_service = 'tilt' + str(id) + '_controller/set_i_gain'
    d_service = 'tilt' + str(id) + '_controller/set_d_gain'
    ans = call_service(service=p_service, type=SetKGain, val = p)
    time.sleep(0.05)
    ans1 = call_service(service=i_service, type=SetKGain, val = i)
    time.sleep(0.05)
    ans2 = call_service(service=d_service, type=SetKGain, val = d)
    time.sleep(0.05)
    if ans and ans1 and ans2:
        rospy.loginfo("Successfull Gains Set (P: " + str(p) + " I: " + str(i) + " D: " + str(d))
    else:
        rospy.logerr("Gains set are not complete")

def call_service(service,type,val):
    rospy.wait_for_service(service)
    try:
        srv =  rospy.ServiceProxy(service, type)
        ans = srv(val)
        return ans
    except rospy.ServiceException, e:
         rospy.loginfo("Service call failed: %s"%e)


def main():

    c = Controller()
    pretension_value = 10 #N
    set_pid_values(pretension_value)
    #trial = 0 # Step Response
    #trial = 1 # Chirp Response
    #trial = 2 # Model Response
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
            if (i == 20):
                break;
        elif trial == 1:
            ''' Chirp Signal '''
            c.chirp_publisher()
            rate.sleep()
            if c.i == 0:
               break
        elif trial == 2:
            ''' Model Signal '''
            c.modeling()
            rate.sleep()
            if c.i == 0:
               break
        else:
            break;
    c.pub_cmd_motor1.publish(0)
    c.pub_cmd_motor2.publish(0)
    rospy.loginfo("Synchronization Finished")

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt as e:
        print (e)
