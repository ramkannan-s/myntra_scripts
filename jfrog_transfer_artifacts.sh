runtask() {
curl -s -H "Authorization: Bearer cmVmdGtuOjAxOjE3MDIwNTU5NzA6d1ZXQ29Cem1kcFFlZFdiWTcyRzRQYnUzSGJJ" -X POST -k -H 'Content-Type: text/plain' http://localhost:8082/artifactory/api/search/aql --data "items.find({\"repo\": \"$1\"}).include(\"repo\",\"path\",\"name\",\"size\")" | jq '.results[]|(.path +"/"+ .name+","+(.size|tostring))' | sed  's/\.\///' > a
curl -s -H "Authorization: Bearer cmVmdGtuOjAxOjE3MDIwNTE0MTE6QThGQ1E5UGpHcnhMaHlFUm9sdmpvY0FoTkdH" -X POST -k -H 'Content-Type: text/plain' http://localhost:8084/artifactory/api/search/aql --data "items.find({\"repo\": \"$1\"}).include(\"repo\",\"path\",\"name\",\"size\")" | jq '.results[]|(.path +"/"+ .name+","+(.size|tostring))' | sed  's/\.\///' > b
join -v1  <(sort a) <(sort b) | sed -re 's/,[[:digit:]]+"$/"/g' |sed 's/"//g' > c
#cat c | xargs -I {} echo "jf rt dl \"$1/{}\" . --server-id local ; jf rt u \"{}\" \"$1/{}\" --server-id local1 ; rm -f \"{}\" "
while IFS= read -r line
do
  echo "jf rt dl \"$1/$line\" . --server-id local ; jf rt u \"$line\" \"$1/$line\" --server-id local1 ; rm -f \"$line\" "
  #jf rt dl \"$1/$line\" . --server-id local ; jf rt u \"$line\" \"$1/$line\" --server-id local1 ; rm -f \"$line\" 
done < "c"
}

for cnt in $(jf rt curl -X GET /api/repositories --server-id  local | jq -r '.[] | .key');
 do
     runtask $cnt
 done
