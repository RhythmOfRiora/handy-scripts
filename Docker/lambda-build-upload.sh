# Upload a lambda to S3 and update function code.
# Change the workspace to the absolute path of the lambda directory on your local machine.
#!/bin/bash -xe
set -eux

# Enable debugging, proceed with the job.
set -x

echo "Docker Building lambda.zip"

WORKSPACE=/Users/<YOUR USER HERE>/<directory>/<lambda_dir>
cd ${WORKSPACE}

mkdir share
docker build -t lambda_location_dir -f Dockerfile-Simple-Python.build .
echo "Docker Run"
docker run -v ${WORKSPACE}/share:/share lambda_location_dir /bin/bash -c "cd /code && zip -r lambda.zip * && cp lambda.zip /share"
echo "Bundled Moving lambda.zip to Upload"
aws s3 cp ${WORKSPACE}/share/lambda.zip s3://<bucket_name>/lambda.zip

echo "Upload Complete for lambda.zip in <region> now rolling lambda function"
aws lambda update-function-code --function-name=<function_name> --s3-bucket=<bucket_name> --s3-key="lambda.zip" --region=<region>
echo "Done"