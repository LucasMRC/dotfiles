function docker_clean
	set PORT "$argv"
	docker ps | awk -v pattern=$PORT '$0 ~ pattern {print $NF}' | xargs docker rm -f &> /dev/null
	echo "Cleared port $PORT"
end
