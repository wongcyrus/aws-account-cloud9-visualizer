# AWS Account Cloud9 Visualizer
Collection of tools to visualize AWS account. 

## In Cloud9 Terminal
```
git clone https://github.com/wongcyrus/aws-account-cloud9-visualizer
cd aws-account-cloud9-visualizer
```

To generate visualizations in your default region
```
./generate_visual.sh
```

To generate visualizations in specific regions
```
./generate_visual.sh -r ap-northeast-1,us-east-1
```

To generate visualizations for all regions
```
./generate_visual_global.sh -r ap-northeast-1,us-east-1
```


To remove previous results
```
./reset.sh 
```

Account Visualization will be saved in data folder and you can use Preview->Preview Running Application to review the Network visualizations of CloudMapper.
Right click navigator.html -> Preview to open aws-security-viz and you need to load aws.json by copy and paste.

## For more details: 

[How to visualize your AWS Account with AWS Cloud9?](https://www.linkedin.com/pulse/how-visualize-your-aws-account-cloud9-wong-chun-yin-cyrus-%25E9%25BB%2583%25E4%25BF%258A%25E5%25BD%25A5-/) 
