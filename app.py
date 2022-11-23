import logging
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-l", "--log", dest="logLevel", choices=['DEBUG', 'INFO', 'WARNING', 'ERROR'], help="Set the logging level")

args = parser.parse_args()
if args.logLevel:
    logging.basicConfig(level=getattr(logging, args.logLevel))
    

#Create and config logger
logging.basicConfig(filename='std.log', filemode='w', format='%(name)s - %(levelname)s - %(message)s')


logger=logging.getLogger() 

#Set threshold of logger to DEBUG 
logger.setLevel(logging.DEBUG) 

#To local file
logger.info("Hello World! and more")

#To the console
print("Hello world!")
