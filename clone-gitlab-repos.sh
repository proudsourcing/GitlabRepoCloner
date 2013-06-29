#!/bin/sh
# 29.06.2013
# tabsl

GLSERVER="HOSTNAME_GITLAB_SERVER"
GLURL="URL_GITLAB_SERVER"
GLREPOPATH="PATH_TO_GITLAB_REPOSITORIES"
LOCALREPOPATH="DESTINATION_PATH"

echo "create gitlab repository index file ..."
ssh root@$GLSERVER "find $GLREPOPATH -type d -name '*.git' | sed -r 's:'$GLREPOPATH'/::' > /root/gitlabrepos.txt"

echo "transfer gitlab repository index file ..."
scp root@$GLSERVER:/root/gitlabrepos.txt gitlabrepos.txt

cat gitlabrepos.txt | while read line; do echo "cloning git@$GLURL:$line ..."; git clone 'git@'$GLURL':'$line $LOCALREPOPATH'/'${line//.git/}; done;
