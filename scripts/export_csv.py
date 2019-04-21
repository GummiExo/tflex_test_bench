#!/usr/bin/python
import rospy
from tflex_test_bench.msg import IMUData
from std_msgs.msg import Bool
import time
import datetime
import sys
import os
import rosbag

class IMU_FSR_Data_Exporter(object):
    def __init__(self):
        rospy.init_node("export_imu_fsr_data",anonymous=True)
        # self.kill_flag = False
        # rospy.Subscriber("kill_gait_assistance", Bool, self.updateFlagExportData)

    def subscribers(self):
        now = datetime.datetime.now()
        home = os.path.expanduser("~")
        self.filename_imu = home + '/catkin_ws/src/t_flex/log/imu_data_'+str(now.month)+'-'+str(now.day)+'-'+str(now.hour)+'-'+str(now.minute)+'-'+str(now.second)+ '.bag'
        self.filename_fsr = home + '/catkin_ws/src/t_flex/log/fsr_data_'+str(now.month)+'-'+str(now.day)+'-'+str(now.hour)+'-'+str(now.minute)+'-'+str(now.second)+ '.bag'
        self.bag_imu = rosbag.Bag(self.filename_imu,'w')
        self.bag_fsr = rosbag.Bag(self.filename_fsr,'w')
        print("Bag files were created.")
        time.sleep(1)
        self.start_time = time.time()
        self.time_stamp = 0
        self.writing = True
        self.fsr_sub = rospy.Subscriber("/fsr_data", Insole, self.callback_fsr)
        self.imu_sub = rospy.Subscriber("/imu_data", IMUData, self.callback_imu)

    # def updateFlagExportData(self,kill_signal):
    #     self.kill_flag = kill_signal.data

    def callback_imu(self, msg):
        # Time stamp
        self.time_stamp = int(round((time.time() - self.start_time)*1000.0))

        # Reading and logging imu_data
        if self.writing:
            self.bag_imu.write('/imu_data',msg)
            print("Time: {} seconds".format(self.time_stamp/1000.0))

    def callback_fsr(self, msg):
        # Reading and logging fsr_data
        if self.writing:
            self.bag_fsr.write('/fsr_data',msg)


def main(exp):
    record = raw_input("Do you want to start recording IMU data? [Y/n] ")
    if record.lower() in ['y', 'yes']:
    # if exp.record:
        exp.subscribers()
        while not rospy.core.is_shutdown():
            rospy.rostime.wallsleep(1)
            if exp.time_stamp/1000.0 > 210.0:
                exp.writing = False
                exp.imu_sub.unregister()
                exp.fsr_sub.unregister()
                break
        try:
            time.sleep(0.5)
            rospy.loginfo("Closing bag with IMU data.")
            exp.bag_imu.close()
            time.sleep(0.5)
            rospy.loginfo("Closing bag with FSR data.")
            exp.bag_fsr.close()
            time.sleep(0.5)
            rospy.loginfo("")
            rospy.loginfo("Converting bag with IMU data into CSV.")
            os.system('rostopic echo -b '+ exp.filename_imu + ' -p /imu_data > ' + exp.filename_imu[:-4] + '.csv')
            rospy.loginfo("Removing bag with IMU data.")
            os.system('rm ' + exp.filename_imu)
            rospy.loginfo("Converting bag with FSR data into CSV.")
            os.system('rostopic echo -b '+ exp.filename_fsr + ' -p /fsr_data > ' + exp.filename_fsr[:-4] + '.csv')
            rospy.loginfo("Removing bag with FSR data.")
            os.system('rm ' + exp.filename_fsr)
            time.sleep(0.5)
            main(exp)
        except Exception as e:
            print (e)
    else:
        rospy.signal_shutdown("")

if __name__ == "__main__":
    try:
        time.sleep(5)
        exp = IMU_FSR_Data_Exporter()
        main(exp)
    except Exception as e:
        print e
