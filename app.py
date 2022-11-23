#Import logging for standard logging
import logging

#Import os and line 4 to access .env file for environment variables
import os
from dotenv import load_dotenv

#import argparse

#parser = argparse.ArgumentParser()
#parser.add_argument("-l", "--log", dest="logLevel", choices=['DEBUG', 'INFO', 'WARNING', 'ERROR'], help="Set the logging level")

#args = parser.parse_args()
#if args.logLevel:
#    logging.basicConfig(level=getattr(logging, args.logLevel))

#Create and config logger
logging.basicConfig(filename='std.log', filemode='w', format='%(name)s - %(levelname)s - %(message)s')

logger=logging.getLogger() 

#Set threshold of logger to DEBUG 
logger.setLevel(logging.DEBUG) 

load_dotenv() 
 
#Print env_var from .env
print(os.environ['NAME'])  
#To local file
logger.info("Hello World!")
logger.info(os.environ['NAME'])
logger.info(os.environ['MESSAGE'])

#To the console
print("Hello world!")
