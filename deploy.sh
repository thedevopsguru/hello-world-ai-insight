#!/usr/bin/env bash

# Below script will look for task defnition template in /var/lib/jenkins/template.json path
# The template.json file is provided in this repository

dockerRepo=`aws ecr describe-repositories --repository-name ai-insight-demo --region ap-south-1 | grep repositoryUri | cut -d "\"" -f 4`
dockerTag=`aws ecr list-images --repository-name ai-insight-demo --region ap-south-1 | grep imageTag | head -n 1 | cut -d "\"" -f 4`
#sed -e "s;DOCKER_IMAGE_NAME;${repositoryURI};g" template.json > taskDefinition.json
#sed -e "s;DOCKER_IMAGE_NAME;${dockerRepo};g" template.json > taskDefinition.json
echo "I am here"
echo $DOCKER_IMAGE_NAME
aws ecs register-task-definition --family ai-insight-jenkins --cli-input-json file://taskDefinition.json --region ap-south-1
revision=`aws ecs describe-task-definition --task-definition ai-insight-jenkins --region ap-south-1 | grep "revision" | tr -s " " | cut -d " " -f 3`
aws ecs update-service --cluster ai-insight-cluster --service ai-insight-service --task-definition ai-insight-jenkins:${revision} --desired-count 1
