_IP=$( hostname -I | awk {'print $1'} )
_NTL="10.5"
_NPS="10.3"
_PATH="/root"

if [ -z "$1" ]; then
  echo "Where is domain service?"
  exit 1
else
  if [[ "$_IP" == "$_NTL"*  ]]; then
        cat $_PATH/$1/namespace-ntl.yml
  elif [[ "$_IP" == "$_NPS"*  ]]; then
        cat $_PATH/$1/namespace-nps.yml
  fi
  cat $_PATH/$1/configmap.yml
  cat $_PATH/$1/deployment.yml
fi
