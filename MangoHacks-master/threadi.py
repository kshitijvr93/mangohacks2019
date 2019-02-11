import threading
import time


class ThreadingExample(object):
    """ Threading example class
    The run() method will be started and it will run in the background
    until the application exits.
    """

    def __init__(self, interval=1):
        """ Constructor
        :type interval: int
        :param interval: Check interval, in seconds
        """
        self.interval = interval
        self.val = 1
        thread = threading.Thread(target=self.run, args=())
        thread.daemon = True                            # Daemonize thread
        thread.start()                                  # Start the execution

    def run(self):
        """ Method that runs forever """
        while True:
            # Do something
            self.val +=1
            print('Doing something imporant in the background',self.val)

            time.sleep(self.interval)

example = ThreadingExample()
# time.sleep(3)
# print('Checkpoint')
# time.sleep(2)
# print('Bye')
# time.sleep(2)

while True:
    time.sleep(1)