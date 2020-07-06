linux=$(uname -a)

if [[ $linux == *"Ubuntu"* ]]
then
    echo "Ubuntu Linux"
    sudo apt-get install -y jq
else
    echo "Amazon Linux"
    sudo yum install -y jq
fi

aws_access_key_id=$(aws configure get default.aws_access_key_id)
aws_secret_access_key=$(aws configure get default.aws_secret_access_key)
aws_session_token=$(aws configure get default.aws_session_token)
region=$(aws configure get region)
aws_account=$(aws sts get-caller-identity | jq -r .Account)

docker run -it --rm \
    -p 0.0.0.0:8081:3000 \
    -v $(pwd)/data:/aws-security-viz \
    -e AWS_ACCESS_KEY_ID=$aws_access_key_id \
    -e AWS_SECRET_ACCESS_KEY=$aws_secret_access_key \
    -e AWS_SESSION_TOKEN=$aws_session_token \
    wongcyrus/aws-security-viz:1.0
    
docker run -it --rm \
    -e AWS_ACCESS_KEY_ID=$aws_access_key_id \
    -e AWS_SECRET_ACCESS_KEY=$aws_secret_access_key \
    -e AWS_SESSION_TOKEN=$aws_session_token \
    -p 0.0.0.0:8080:8000 \
    -v $(pwd)/data:/data \
     wongcyrus/cloudmapper:1.0 /bin/bash -c \
"python cloudmapper.py configure add-account --config-file config.json --name student --id $aws_account; \
python cloudmapper.py collect --account student --regions $region; \
python cloudmapper.py prepare --account student --regions $region; \
cp /opt/cloudmapper/web/data.json /data; \
python cloudmapper.py webserver --public"    
