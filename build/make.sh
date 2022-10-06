wget https://gist.githubusercontent.com/wongcyrus/a4e726b961260395efa7811cab0b4516/raw/2049301120a969ddc4ee51e868a00a6e175bf66b/resize.sh
chmod +x resize.sh
sh ./resize.sh
git clone https://github.com/duo-labs/cloudmapper.git
cd cloudmapper
docker build -t cloudmapper .
cd ..
git clone https://github.com/anaynayak/aws-security-viz.git
cp Dockerfile aws-security-viz/Dockerfile
cp generateSecurityGroup.sh aws-security-viz/
cd aws-security-viz
docker build -t aws-security-viz .
cd ..

rm -rf cloudmapper
rm -rf aws-security-viz
rm resize.sh

docker tag cloudmapper wongcyrus/cloudmapper:1.1
docker tag aws-security-viz wongcyrus/aws-security-viz:1.1
docker push wongcyrus/cloudmapper:1.1
docker push wongcyrus/aws-security-viz:1.1




