#!/usr/bin/env python2

import rospy
import cv2
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError

class CameraViewer:

    def __init__(self):
        rospy.init_node('camera_viewer', anonymous=True)
        self.bridge = CvBridge()
        self.image_sub = rospy.Subscriber('/grayscale', Image, self.image_callback)

    def image_callback(self, data):
        print("image received")
        rospy.loginfo("Image received")  # Added for debugging
        try:
            cv_image = self.bridge.imgmsg_to_cv2(data, 'mono8')
        except CvBridgeError as e:
            print(e)
            return

        cv2.imshow("Grayscale Video Feed", cv_image)
        cv2.waitKey(1)

if __name__ == '__main__':
    print("Starting camera_viewer node")
    cv = CameraViewer()
    try:
        rospy.spin()
    except KeyboardInterrupt:
        print("Shutting down")
    cv2.destroyAllWindows()
