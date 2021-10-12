if ! which aws;
then
  echo "installing aws"
  # install awscli
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip -o -qq awscliv2.zip
  sudo ./aws/install

  # configure awscli
  mkdir -p ~/.aws
  touch ~/.aws/config
  echo "[default]" >> ~/.aws/config
  echo "region = us-east-1" >> ~/.aws/config
  echo "output = json" >> ~/.aws/config
else
  echo "aws already installed"
fi