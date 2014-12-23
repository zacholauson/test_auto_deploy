#! /bin/bash

SHA1=$1

EB_BUCKET=test_auto_deploy-bucket
DOCKERRUN_FILE=$SHA1-Dockerrun.aws.json

sed "s/<TAG>/$SHA1/" < Dockerrun.aws.json.template > $DOCKERRUN_FILE

aws s3 cp $DOCKERRUN_FILE s3://$EB_BUCKET/$DOCKERRUN_FILE

aws elasticbeanstalk create-application-version --application-name test_auto_deploy --auto-create true \
  --version-label $SHA1 --source-bundle S3Bucket=$EB_BUCKET,S3Key=$DOCKERRUN_FILE

aws elasticbeanstalk update-environment --environment-name dev-env \
    --version-label $SHA1
