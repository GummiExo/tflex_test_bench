#!/usr/bin/env python2
# -*- coding: utf-8 -*-
import rospy
import time
import os
import math
from dynamixel_workbench_msgs.msg import DynamixelStatusList
from tflex_test_bench.msg import IMUData
from geometry_msgs.msg import Vector3
from std_msgs.msg import Int16, Float64
from sensor_msgs.msg import Imu

class TopicsSynchronization(object):
    def __init__(self):
        rospy.init_node('tflex_test_bench_topics_synchronization', anonymous = True)
        rospy.Subscriber("/tflex_test_bench_motors/dynamixel_status",DynamixelStatusList, self.updateMotorState)
        rospy.Subscriber("/load_data", Float64, self.updateLoad)
        rospy.Subscriber("/imu_data", IMUData, self.updateIMU)
        rospy.Subscriber("/imu_data/euler_angles", Vector3, self.updateEulerAngles)
        rospy.Subscriber("/tflex_test_bench/goal_position_motor1", Int16, self.updateGoalPositionMotor1)
        self.pub_load_motor_positions = rospy.Publisher("/motor_positions_load_data", Vector3, queue_size = 1, latch = False)
        self.pub_plot_axis = rospy.Publisher("/angle_torque", Vector3, queue_size = 1, latch = False)
        self.pub_torques = rospy.Publisher("/torque_motor_loadsensor_data", Vector3, queue_size = 1, latch = False)
        self.pub_current = rospy.Publisher("/current_motor_loadsensor_data", Vector3, queue_size = 1, latch = False)
        self.pub_imu = rospy.Publisher("/imu_syn", Imu, queue_size = 1, latch = False)
        self.pub_positions1 = rospy.Publisher("/present_positions_goal_position_1", Vector3, queue_size = 1, latch = False)
        self.pub_sin_signal_motor1 = rospy.Publisher("/tflex_test_bench/goal_position_motor1", Int16, queue_size = 1, latch = False) 
        home = os.path.expanduser('~')
        os.chdir(home + '/catkin_ws/src/tflex_test_bench/yaml')
        f = open("motor_position_values.yaml", "r+")
        params = [f.readline().strip().split()[1] for i in range(4)]
        self.initial_value_motor1 = float(params[0])
        #self.max_value_motor1 = float(params[1])
        #self.min_value_motor2 = float(params[2])
        self.initial_value_motor2 = float(params[3])         
        self.CALIBRATE = False
        self.data1 = Vector3()
        self.data2 = Vector3()  
        self.data3 = Vector3()
        self.data4 = Vector3()
        self.data_plot1 = Vector3()
        self.imu_msg = Imu()
        self.Motor1State = None
        self.Motor2State = None
        self.load_data = None
        self.imu_data_gyro_x = None
        self.imu_data_gyro_y = None
        self.imu_data_gyro_z = None
        self.imu_data_accel_x = None
        self.imu_data_accel_y = None
        self.imu_data_accel_z = None
        self.imu_data_euler_x = None
        self.imu_data_euler_y = None
        self.imu_data_euler_z = None
        self.goal_position_motor1 = 0
        self.initial_time = time.time()
        self.isMotorAngleUpdated = False
        self.isGoalPosition1Updated = False

    def updateMotorState(self, motor_info):
        if len(motor_info.dynamixel_status) < 2:
            self.isMotorAngleUpdated = False
            rospy.loginfo("Incomplete Motor Data")
        else:
            self.Motor1State = motor_info.dynamixel_status[0]
            self.Motor2State = motor_info.dynamixel_status[1]
            self.isMotorAngleUpdated = True

    def updateLoad(self, load):
        self.load_data = load.data

    def updateIMU(self, imu):
        self.imu_data_gyro_x = imu.gyro_x
        self.imu_data_gyro_y = imu.gyro_y
        self.imu_data_gyro_z = imu.gyro_z
        self.imu_data_accel_x = imu.accel_x
        self.imu_data_accel_y = imu.accel_y
        self.imu_data_accel_z = imu.accel_z

    def updateEulerAngles(self, euler):
        self.imu_data_euler_x = euler.x
        self.imu_data_euler_y = euler.y
        self.imu_data_euler_z = euler.z

    def updateGoalPositionMotor1(self, position):
        self.goal_position_motor1 = position.data
        self.isGoalPosition1Updated = True

    def process(self):
        #if not (self.Motor1State.present_position == 0 or self.Motor2State.present_position == 0):
        sin = 820*math.sin(math.pi/4*(time.time() - self.initial_time )) + 3270  
        self.pub_sin_signal_motor1.publish(sin)
        if (self.isGoalPosition1Updated and self.isMotorAngleUpdated):
            self.data1.x = self.Motor1State.present_position
            self.data1.y = self.Motor2State.present_position
            self.data4.x = self.Motor1State.present_position
            self.data4.y = self.goal_position_motor1
            self.pub_positions1.publish(self.data4)
            self.isGoalPosition1Updated = False
            self.isMotorAngleUpdated = False
            
        else:
            return 0

            
            #self.data1.z = self.load_data
            #if(self.load_data < 0):
                #self.data_plot1.x = (self.Motor1State.present_position - self.initial_value_motor1)*360/4096
                #self.data_plot1.y = 0
            #else:
                #self.data_plot1.x = 0
                #self.data_plot1.x = (self.initial_value_motor2 - self.Motor2State.present_position)*360/4096
            #print("M1:" + str(self.data_plot1.x))
            #print("M2:" + str(self.data_plot1.y))
            #self.data_plot1.z = self.load_data
            #self.data2.x = self.Motor1State.present_load
            #self.data2.y = self.Motor2State.present_load
            #self.data2.z = self.load_data
            #try:
                #self.imu_msg.orientation.x = self.imu_data_euler_x
                #self.imu_msg.orientation.y = self.imu_data_euler_y
                #self.imu_msg.orientation.z = self.imu_data_euler_z
                #self.imu_msg.angular_velocity.x = self.imu_data_gyro_x
                #self.imu_msg.angular_velocity.y = self.imu_data_gyro_y 
                #self.imu_msg.angular_velocity.z = self.imu_data_gyro_z
                #self.imu_msg.linear_acceleration.x = self.imu_data_accel_x
                #self.imu_msg.linear_acceleration.y = self.imu_data_accel_y 
                #self.imu_msg.linear_acceleration.z = self.imu_data_accel_z
                #self.pub_imu.publish(self.imu_msg)
            #except:
                #rospy.loginfo("IMU is not connected")
            #self.data3.x = self.Motor1State.present_current
            #self.data3.y = self.Motor2State.present_current
            #self.data3.z = self.load_data
            
            
            
            
            #self.pub_load_motor_positions.publish(self.data1)
            #self.pub_torques.publish(self.data2)
            #self.pub_plot_axis.publish(self.data_plot1)
            #self.pub_current.publish(self.data3)
            
            
            return(0)

def main():

    c = TopicsSynchronization()
    rate = rospy.Rate(100)
    while not (rospy.is_shutdown()):
        if not (c.Motor1State == None or c.Motor2State == None):
            c.process()
            rate.sleep()
    rospy.on_shutdown(c.process)
    rospy.loginfo("Synchronization Finished")

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt as e:
        print (e)
