
1.  Get your IAM user setup in AWS
    
2.  Configure your credentials in Terminal using “aws --configure”
    
3.  Make sure your ~/.aws/credentials and ~/.aws/config files are correctly
    
    setup
    
4.  Set local environment variables
    
    1.  export AWS_REGION=ap-southeast-2 (or other regions you want to authenticate into)
        
    2.  export AWS_DEFAULT_REGION=ap-southeast-2 (need to match with the one above)
        
    3.  export AWS_PROFILE=default (profile name need to match the one in your ~/.aws/config file)
        
5.  Verify your authentication using “aws s3 ls”
    

a. if no error message, then you’re good to go!
