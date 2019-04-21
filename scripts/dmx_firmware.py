#!/usr/bin/env python
#GENERAL LIBRARIES
import rospy
import time
import threading
#CUSTOM MODULES#

#MESSAGES#
#msg to get motor status list
from dynamixel_workbench_msgs.msg import DynamixelStatusList
#Mmsg to get joint states
from sensor_msgs.msg import JointState

#SERVICES#
#service to enable/disable torque
from dynamixel_workbench_msgs.srv import TorqueEnable
#service to send joint commands (position, speed)
from dynamixel_workbench_msgs.srv import JointCommand

#ACTIONS#



################################################################################
#TOPICS
################################################################################
#subscriber object to get motor states
class DmxMotorStatusSubscriber(object):
    def __init__(self, topic_name):
        #TODO: fetch from params
        self.topic_name = topic_name
        #create subscriber
        self.status_subscriber = rospy.Subscriber(topic_name, DynamixelStatusList, self.callback)
        #data variable
        self.data = []

    def callback(self, state):
        self.data = state.dynamixel_status
        #print self.data
        #self.data = [self.data[0].present_position, self.data[1].present_position, self.data[2].present_position]


class DmxJointStatesSubscriber(object):
    def __init__(self, topic_name):
        self.topic_name = topic_name
        #create subscriber
        self.joint_subscriber = rospy.Subscriber(topic_name, JointState, self.callback)
        #data variable
        self.data = []


    def callback(self, joint):
        self.data = joint.position
        #print self.data

################################################################################
#SERVICES
################################################################################

#object to create motor position/velocity client service
class DmxCommandClientService(object):
    def __init__(self, service_name = "/goal_position"):
        #get service name
        self.service_name = service_name


    def degree_to_step(self, val):
        return val

    def service_request_threaded(self, id, val):
        threading.Thread(target = self.service_request, args = (id,val)).start()

    def service_request(self, id, val):
        rospy.wait_for_service(self.service_name)
        try:
            goal_position = rospy.ServiceProxy(self.service_name, JointCommand)
            res = goal_position(id = id, value = val)
            time.sleep (0.001)
            return (res.result)

        except rospy.ServiceException, e:
            print "Service call failed: %s"%e

#stiffnesss handler object
class DmxStiffnessHandler(object):
    def __init__(self, service_name):
        #create service
        #TODO: get name as param
        self.service = service_name
        #get motor id_list
        #self.motor_id = rospy.get_param("dmx_id")

        #self.stiffness_srv = rospy.Service("enable_stiffness", TorqueEnable, self.set_stiffness)

    def service_request(self, id =1, val = False):
        rospy.wait_for_service(self.service)
        try:
             enable_torque = rospy.ServiceProxy(self.service, TorqueEnable)
             #send service
             res = enable_torque(id = id, value= val)
             time.sleep(0.001)
             return (res.result)

        except rospy.ServiceException, e:
             print "Service call failed: %s"%e


    def set_stiffness(self, req):
        val = req.torque_enable
        #call service for all motors
        res = self.torque_enable(self.motor_id["head"], val = val)
        print res
        res = self.torque_enable(self.motor_id["right_elbow"], val = val)
        print res
        res = self.torque_enable(self.motor_id["left_elbow"], val = val)
        print res
        res = self.torque_enable(self.motor_id["right_shoulder"], val = val)
        print res
        res = self.torque_enable(self.motor_id["left_shoulder"], val = val)
        print res

        return res



################################################################################
#ACTIONS
################################################################################


"""
class DmxGoalSpeedClientService(object):
    def __init__(self):
        #TODO: fetch from params
        self.service_name = "/goal_speed"
        #get head limits (?)
        self.head_range = rospy.get_param("head_limit")
        self.right_shoulder_range = rospy.get_param("right_shoulder_limit")
        self.right_elbow_range = rospy.get_param("right_elbow_limit")
        self.left_shoulder_range = rospy.get_param("left_shoulder_limit")
        self.left_elbow_range = rospy.get_param("left_elbow_limit")

        #create service client
        #self.position_srv = rospy.Publisher(topic_name, GoalPosition, queue_size = 1, latch = False)

    def degree_to_step(self, val):
        return val

    def service_request(self, id, val):
        rospy.wait_for_service(self.service_name)
        try:
            goal_speed = rospy.ServiceProxy(self.service_name, JointCommandCustom)
            res = goal_speed(id = id, value = val)
            time.sleep (0.001)
            return (res.result)

        except rospy.ServiceException, e:
            print "Service call failed: %s"%e


    def publish(self, id= {}, val= {}):
        #validate ranges
        if val["head"] > self.head_range["max"]:
            val["head"] =  self.head_range["max"]
        elif val["head"] < self.head_range["min"]:
            val["head"] = self.head_range["min"]
        #set msg lists
        id_list    = [ id["head"], id["right_shoulder"], id["right_elbow"], id["left_shoulder"], id["left_elbow"] ]
        value_list = [ val["head"], val["right_shoulder"], val["right_elbow"], val["left_shoulder"], val["left_elbow"]]
        #publish command
        self.position_publisher.publish(id = id_list, goal_position = value_list)
"""
