#!/usr/bin/env bash

# Config for jenkins
if [ -n "$JENKINS_UID" ]; then

  mkdir /.composer && chmod -R 777 /.composer

  useradd -G root -u $JENKINS_UID jenkins
  usermod -a -G www-data jenkins

  chown -R www-data:www-data /.composer

  # Authorize SSH Host
  mkdir -p /home/jenkins/.ssh && \
      chmod 777 /home/jenkins/.ssh && \
      ssh-keyscan git.cssdev.lv > /home/jenkins/.ssh/known_hosts

  # Add the keys from environment and set permissions
  echo "$SSH_PRV_KEY" > /home/jenkins/.ssh/id_rsa && \
      echo "$SSH_PUB_KEY" > /home/jenkins/.ssh/id_rsa.pub && \
      chmod 777 /home/jenkins/.ssh/id_rsa && \
      chmod 777 /home/jenkins/.ssh/id_rsa.pub

  mkdir -p /home/jenkins/.composer && chmod -R 777 /home/jenkins/.composer

fi
