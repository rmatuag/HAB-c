$!/bin/bash

curl -s --user 'gautam@getafix.tk:test123' 'https://mind.zimbra.io/home/gautam@getafix.tk/Inbox/?fmt=sync&auth=sc' -c 'cookie-file'
allct=( $(zmmailbox -z -m gautam@getafix.tk gact | grep Id: | cut -f2 -d" ") )

for cid in "${allct[@]}"; do
	# Get random image
	curl -sL https://picsum.photos/200 -o default.png
	resp=$(curl -s -b cookie-file -X POST "https://mind.zimbra.io/service/upload?fmt=extended,raw" -H "Content-Type: multipart/form-data" -F file=@default.png)
	imid=$(echo $resp | cut -f3- -d"," | jq '.[].aid')
	curl -s 'https://mind.zimbra.io/service/soap/CreateContactRequest' -b cookie-file -H 'Content-Type: text/plain;charset=UTF-8' --data-binary '{"Body":{"ModifyContactRequest":{"_jsns":"urn:zimbraMail","cn":{"id":"'$cid'","a":[{"n":"image","aid":'${imid}'}]}}},"Header":{"context":{"_jsns":"urn:zimbra","authTokenControl":{"voidOnExpired":true}}}}' --compressed
done
