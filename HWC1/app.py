import logging
import os
from dotenv import load_dotenv

#Filemode 'w' for overwrite, 'a' to append
logging.basicConfig(
    level=logging.DEBUG,
    filename='std.log',
    filemode='a',
    format=' %(asctime)s - %(name)s - %(levelname)s - %(message)s'
    )

logger=logging.getLogger()
logger.setLevel(logging.DEBUG)

load_dotenv() 
 
#To std.log file
logger.warning("Hello World!")
logger.debug(os.environ['NAME'])
logger.info(os.environ['MESSAGE'])

#env_var from .env to console
print(os.environ['NAME'])

#To the console
print("Hello world!")