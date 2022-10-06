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
aws_account=$(aws sts get-caller-identity | jq -r .Account)

docker run -it --rm \
    -p 0.0.0.0:8081:3000 \
    -v $(pwd)/data:/aws-security-viz \
    -e AWS_ACCESS_KEY_ID=$aws_access_key_id \
    -e AWS_SECRET_ACCESS_KEY=$aws_secret_access_key \
    -e AWS_SESSION_TOKEN=$aws_session_token \
    wongcyrus/aws-security-viz:1.1
    
docker run -it --rm \
    -e AWS_ACCESS_KEY_ID=$aws_access_key_id \
    -e AWS_SECRET_ACCESS_KEY=$aws_secret_access_key \
    -e AWS_SESSION_TOKEN=$aws_session_token \
    -p 0.0.0.0:8080:8000 \
    -v $(pwd)/data:/data \
    -v $(pwd)/account-data:/opt/cloudmapper/account-data \
    wongcyrus/cloudmapper:1.1 /bin/bash -c \
"python cloudmapper.py configure add-account --config-file config.json --name student --id $aws_account; \
python cloudmapper.py collect --account student ;\
python cloudmapper.py report  --account student ;\
python cloudmapper.py prepare --account student ;\
python cloudmapper.py stats --account student; \
cp -r /opt/cloudmapper/web/* /data; \
cp -r /opt/cloudmapper/resource_stats.png /data; \
python cloudmapper.py webserver --public"    
