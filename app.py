#Import logging for standard logging
import logging

#Import os and line 6 to access .env file for environment variables
import os
from dotenv import load_dotenv

#Create and config logger
#Change filemode from 'w' to 'a' if you want to append rather than overwrite
logging.basicConfig(
    level=logging.DEBUG,
    filename='std.log',
    filemode='w',
    format=' %(asctime)s - %(name)s - %(levelname)s - %(message)s'
    )

logger=logging.getLogger()

#Set threshold of logger to DEBUG 
logger.setLevel(logging.DEBUG)

load_dotenv() 
 
#To local file
logger.warning("Hello World!")
logger.debug(os.environ['NAME'])
logger.info(os.environ['MESSAGE'])

#Print env_var from .env
print(os.environ['NAME'])

#To the console
print("Hello world!")