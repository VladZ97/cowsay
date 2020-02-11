#!/bin/bash
if ! wget http://gitlab/Vlad/cowsay/tree/release/${version} ; then
git branch release/${version}
echo 0 > v.txt
git add *
git commit -am "New branch version ${version} build passed"
git tag ${version}.0
docker build -t vovaz/cowsay:${version}.0 .
docker run -p "6969:6969" --name test --network jenkins_default -d vovaz/cowsay:${version}.0 6969
while ! wget test:6969; do sleep 1 
done
curl test:6969
docker rm -f test
docker login -u vovaz -p AaAa312QwEr
docker push vovaz/cowsay:${version}.0
else
echo "second"
git checkout release/${version}
expr $(git tag | sort -r | head -n1 | cut -d '.' -f3) + 1 > v.txt
git add *
git commit -am "branch version ${version} build passed"
git tag ${version}.$((git tag | sort -r | head -n1 | cut -d '.' -f3) + 1)
docker build -t vovaz/cowsay:${version}.$(expr $(git tag | sort -r | head -n1 | cut -d '.' -f3) + 1) .
docker run -p "6969:6969" --name test --network jenkins_default -d vovaz/cowsay:${version}.$(expr $(git tag | sort -r | head -n1 | cut -d '.' -f3) + 1)  6969
while ! wget test:6969; do sleep 1 
done
curl test:6969
docker rm -f test
docker login -u vovaz -p AaAa312QwEr
docker push vovaz/cowsay:${version}.$(expr $(git tag | sort -r | head -n1 | cut -d '.' -f3) + 1)
fi