#! /bin/bash

echo "import logging
import time
from random import randint

logging.basicConfig(
    level=logging.DEBUG,
    filename='std.log',
    filemode='a',
    format=' %(asctime)s - %(name)s - %(levelname)s - %(message)s'
    )

logger=logging.getLogger()

logger.setLevel(logging.DEBUG)

while(True):
    delay = randint(30, 120) 
    logger.warning('Hello World!')
    logger.debug('Second log no inspiration!')
    logger.info('Useful information')
    time.sleep(delay)" >> /var/log/app.py

python /var/log/app.py