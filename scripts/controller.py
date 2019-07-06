#!/usr/bin/env python2
# -*- coding: utf-8 -*-
import time
import os
import sys
import dmx_firmware
import rospy
from dynamixel_workbench_msgs.srv import JointCommand, TorqueEnable
from dynamixel_workbench_msgs.msg import MotorCommand
from std_msgs.msg import Bool, Float64, Int8, Int16

class Controller(object):
    def __init__(self):
        '''Parameters Inicialization '''
        home = os.path.expanduser('~')
        os.chdir(home + '/catkin_ws/src/tflex_test_bench/yaml')
        f = open("calibrationAngle.yaml", "r+")
        params = [f.readline().strip().split()[1] for i in range(4)]
        print(params)
        self.ValueToPubUp1 = float(params[0])
        self.ValueToPubDown1 = float(params[1])
        self.ValueToPubUp2 = float(params[2])
        self.ValueToPubDown2 = float(params[3])
        f = open("calibrationStiffness.yaml", "r+")
        params = [f.readline().strip().split()[1] for i in range(2)]
        print(params)
        self.ValueStiffness1 = float(params[0])
        self.ValueStiffness2 = float(params[1])
        f = open("motor_position_values.yaml", "r+")
        params = [f.readline().strip().split()[1] for i in range(4)]
        self.min_value_motor1 = float(params[0])
        self.max_value_motor1 = float(params[1])
        self.min_value_motor2 = float(params[2])
        self.max_value_motor2 = float(params[3])
        self.speed = 10*1024/10 #Max Speed Value: 1024
        self.frecuency = 0.8 #Hz
        set_motor_speed(self.speed)
        self.option_controller = 4
        self.position_topic = MotorCommand()
        ''' Subscribers '''
        rospy.Subscriber("/tflex_test_bench/option_controller", Int8, self.updateOptionController)
        rospy.Subscriber("/tflex_test_bench/update_speed", Float64, self.updateSpeed)
        rospy.Subscriber("/tflex_test_bench/update_frequency", Float64, self.updateFrequency)
        rospy.Subscriber("/tflex_test_bench/goal_position_motor1", Int16, self.updatePositionMotor1)
        rospy.Subscriber("/tflex_test_bench/goal_position_motor2", Int16, self.updatePositionMotor2)
        ''' Publishers '''
        self.pub_position = rospy.Publisher("tflex_test_bench_motors/goal_position",MotorCommand, queue_size = 1, latch = False)
        ''' Node Configuration '''
        rospy.init_node('tflex_test_bench_controller', anonymous = True)

    def updateOptionController(self, option):
        self.option_controller = option.data
        print(self.option_controller)

    def updateSpeed(self, speed):
        self.speed = speed.data
        set_motor_speed(self.speed)

    def updateFrequency(self, frequency):
        self.frequency = frecuency.data

    def updatePositionMotor1(self,pos):
         # Validation Motor id 1
        pos_pub = pos.data
        if pos_pub > self.max_value_motor1:
            pos_pub = self.max_value_motor1
        if pos_pub < self.min_value_motor1:
            pos_pub = self.min_value_motor1
        self.position_topic.id = 1
        self.position_topic.value = pos_pub
        self.pub_position.publish(self.position_topic)
        #set_motor_position(position = pos_pub, id_motor = 1) #Set position using services

    def updatePositionMotor2(self,pos):
        # Validation Motor id 2
        pos_pub = pos.data
        if pos_pub > self.max_value_motor2:
            pos_pub = self.max_value_motor2
        if pos_pub < self.min_value_motor2:
            pos_pub = self.min_value_motor2
        self.position_topic.id = 2
        self.position_topic.value = pos_pub
        self.pub_position.publish(self.position_topic)
        #set_motor_position(position = pos, id_motor = 2) #Set position using services

    def automatic_movement(self):
        #rospy.loginfo("------------------------ AUTO-MOVEMENT STARTED ------------------------")
        if (self.option_controller == 1):
            ''' Position Publisher Motor ID 1 and Motor ID 2'''
            # set_position(self.ValueToPubUp1,self.ValueToPubDown2)
            self.motor_position_command(val_motor1 = self.ValueToPubUp1, val_motor2 = self.ValueToPubDown2)
            time.sleep(1/self.frecuency)
            # set_position(self.ValueToPubDown1,self.ValueToPubUp2)
            self.motor_position_command(val_motor1 = self.ValueToPubDown1, val_motor2 = self.ValueToPubUp2)
            time.sleep(1/self.frecuency)
        else:
            return
        #rospy.loginfo("------------------------ AUTO-MOVEMENT FINISHED -----------------------")

    def increase_stiffness(self):
        #rospy.loginfo("------------------------ INCREASE-SITFFNESS STARTED ------------------------")
        if (self.option_controller == 2):
            ''' Position Publisher Motor ID 1 and Motor ID 2'''
            self.motor_position_command(val_motor1 = self.ValueStiffness1, val_motor2 = self.ValueStiffness2)
            time.sleep(1/self.frecuency)
            self.motor_position_command(val_motor1 = self.ValueToPubDown1, val_motor2 = self.ValueToPubDown2)
            time.sleep(1/self.frecuency)
        else:
            return
        #rospy.loginfo("------------------------ INCREASE-STIFFNESS FINISHED -----------------------")

    def angle_controller(self):
        if (self.option_controller == 3):
            ''' Position Publisher Motor ID 1 and Motor ID 2'''
            print("Entre")
            self.motor_position_command(val_motor1 = self.ValueToPubDown1, val_motor2 = self.ValueToPubDown2)
            release_motors()
            set_motor_position(position = self.max_value_motor1, id_motor = 1)
            time.sleep(1/self.frecuency)
            self.motor_position_command(val_motor1 = self.ValueToPubDown1, val_motor2 = self.ValueToPubDown2)
            release_motors()
            set_motor_position(position = self.min_value_motor2, id_motor = 2)
            time.sleep(1/self.frecuency)
        else:
            return

    def process(self):
        if (self.option_controller == 1):
            self.automatic_movement()
            return 1
        elif (self.option_controller == 2):
            self.increase_stiffness()
            return 1
        elif (self.option_controller == 3):
            self.angle_controller()
            return 1
        elif (self.option_controller == 4):
            time.sleep(0.001)
            return 1
        else:
            release_motors()
            return 0

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

def set_motor_position(position,id_motor):
    val = position
    service = '/tflex_test_bench_motors/goal_position'
    rospy.wait_for_service(service)
    try:
         motor_position = rospy.ServiceProxy(service, JointCommand)
         ''' Set Speed Motor ID 1 '''
         resp1 = motor_position(id=id_motor,value=val)
         return (resp1.result)
    except rospy.ServiceException:
         print ("Service call failed: %s"%e)

def main():
    c = Controller()
    rospy.on_shutdown(release_motors)
    rospy.loginfo("Tests:\n1.Angle Test\n2.Stiffness Test\n3.Exit")
    while not (rospy.is_shutdown()):
        resp = c.process()
        if (resp == 0):
            break
    release_motors()
    rospy.loginfo("Controller Finished")

if __name__ == '__main__':
    try:
        main()
    except Exception as e:
        print(e)
