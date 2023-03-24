#! /bin/bash

echo "import logging
import time
import random

logging.basicConfig(
    level=logging.DEBUG,
    filename='std.log',
    filemode='a',
    format=' %(asctime)s - %(name)s - %(levelname)s - %(message)s'
    )

logger=logging.getLogger()

logger.setLevel(logging.DEBUG)

while(True):
    delay = random.randint(1,10)
    msg1 = ('Hello world!')
    msg2 = ('Another log no inspiration!')
    msg3 = ('Useful information')
    msg_list = [msg1, msg2, msg3]
    message = random.choice(msg_list)
    logger.info(message)
    time.sleep(delay)" >> /var/log/app.py

cd /var/log
python app.py