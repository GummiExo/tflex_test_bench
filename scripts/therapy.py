#!/usr/bin/env python2
# -*- coding: utf-8 -*-

import rospy
import time
import dmx_firmware
from dynamixel_workbench_msgs.srv import JointCommand, TorqueEnable
from std_msgs.msg import Bool
import os
import sys

class TherapyController(object):
    def __init__(self):
        self.repeats, self.frecuency, self.speed = int(sys.argv[1]), float(sys.argv[2]), float(sys.argv[3])
        ''' Max Speed Value: 1024 '''
        self.speed = self.speed*1024/10
        home = os.path.expanduser('~')
        os.chdir(home + '/catkin_ws/src/tflex_test_bench/yaml')
        f = open("calibrationAngle.yaml", "r+")
        params = [f.readline().strip().split()[1] for i in range(4)]
        print(params)
        rospy.init_node('tflex_test_bench_therapy', anonymous = True)
        self.ValueToPubUp1 = float(params[0])
        self.ValueToPubDown1 = float(params[1])
        self.ValueToPubUp2 = float(params[2])
        self.ValueToPubDown2 = float(params[3])
        set_motor_speed(self.speed)
        rospy.Subscriber("/tflex_test_bench/kill_therapy", Bool, self.updateFlagTherapy)
        self.kill_therapy = False

    def updateFlagTherapy(self, flag):
        self.kill_therapy = flag.data

    def automatic_movement(self):
        rospy.loginfo("------------------------ THERAPY STARTED ------------------------")
        for n in range (0,self.repeats):
            if not self.kill_therapy:
                ''' Position Publisher Motor ID 1 and Motor ID 2'''
                # set_position(self.ValueToPubUp1,self.ValueToPubDown2)
                self.motor_position_command(val_motor1 = self.ValueToPubUp1, val_motor2 = self.ValueToPubDown2)
                time.sleep(1/self.frecuency)
                # set_position(self.ValueToPubDown1,self.ValueToPubUp2)
                self.motor_position_command(val_motor1 = self.ValueToPubDown1, val_motor2 = self.ValueToPubUp2)
                time.sleep(1/self.frecuency)
            else:
                break
        rospy.loginfo("------------------------ THERAPY FINISHED -----------------------")

    def process(self):
        self.automatic_movement()
        release_motors()

    def motor_position_command(self, val_motor1 = 0, val_motor2 = 0):
        #create service handler for motor1
        service = dmx_firmware.DmxCommandClientService(service_name = '/tflex_test_bench_motors/goal_position')
        service.service_request_threaded(id = 1,val = val_motor1)
        service.service_request_threaded(id = 2, val = val_motor2)

def release_motors():
    val = False
    service = '/tflex_test_bench_motors/torque_enable'
    rospy.wait_for_service(service)
    try:
         enable_torque = rospy.ServiceProxy(service, TorqueEnable)
         ''' Torque Disabled Motor ID 1 '''
         resp1 = enable_torque(id=1,value=val)
         time.sleep(0.001)
         ''' Torque Disabled Motor ID 2 '''
         resp2 = enable_torque(id=2,value=val)
         time.sleep(0.001)
         return (resp1.result & resp2.result)
    except rospy.ServiceException, e:
         print "Service call failed: %s"%e

def set_motor_speed(speed):
    val = speed
    service = '/tflex_test_bench_motors/goal_speed'
    rospy.wait_for_service(service)
    try:
         motor_speed = rospy.ServiceProxy(service, JointCommand)
         ''' Set Speed Motor ID 1 '''
         resp1 = motor_speed(id=1,value=val)
         time.sleep(0.001)
         ''' Set Speed Motor ID 2 '''
         resp2 = motor_speed(id=2,value=val)
         time.sleep(0.001)
         return (resp1.result & resp2.result)
    except rospy.ServiceException:
         print ("Service call failed: %s"%e)

def main():
    c = TherapyController()
    rospy.on_shutdown(release_motors)
    while not (rospy.is_shutdown()):
        c.process()
        break
    rospy.loginfo("Controller Finished")

if __name__ == '__main__':
    try:
        main()
    except Exception as e:
        print(e)
