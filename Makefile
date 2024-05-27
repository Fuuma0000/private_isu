up:
	docker compose up -d	

down:
	docker compose down

restart:
	docker compose restart

ps:
	docker compose ps

logs:
	docker compose logs

logsf:
	docker compose logs -f

nginx:
	docker compose exec -it nginx bash

app:
	docker compose exec -it app bash

db:
	docker compose exec -it mysql bash

mysql:
	docker compose exec -it mysql mysql -uroot -p isuconp

bench:
	docker compose exec -it nginx /bin/sh -c "mv /var/log/nginx/access.log /var/log/nginx/access.log.$$(date +'%Y%m%d%H%M%S') && nginx -s reopen" && 	docker compose exec -it mysql /bin/sh -c "mv /var/log/mysql/slow-query.log /var/log/mysql/slow-query.log.$$(date +'%Y%m%d%H%M%S') && mysql -uroot -p isuconp -e 'FLUSH SLOW LOGS'"  &&  docker run --rm --network host -i private-isu-benchmarker /opt/go/bin/benchmarker -t http://localhost -u ./userdata

alp:
	cat logs/nginx/access.log | alp ltsv -m="^/posts/[0-9]+","^/image/[0-9]+\.(jpg|png|gif)","^/@[a-z]*" --reverse > logs/nginx/alp/$(shell date +'%Y%m%d%H%M%S').log

alps:
	cat logs/nginx/access.log | alp ltsv -m="^/posts/[0-9]+","^/image/[0-9]+\.(jpg|png|gif)","^/@[a-z]*" --reverse --sort=sum

alpa:
	cat logs/nginx/access.log | alp ltsv -m="^/posts/[0-9]+","^/image/[0-9]+\.(jpg|png|gif)","^/@[a-z]*" --reverse --sort=avg

pt:
	pt-query-digest logs/mysql/slow-query.log > logs/mysql/pt/$(shell date +'%Y%m%d%H%M%S').log

rotate:
	docker compose exec -it nginx /bin/sh -c "mv /var/log/nginx/access.log /var/log/nginx/access.log.$$(date +'%Y%m%d%H%M%S') && nginx -s reopen" && 	docker compose exec -it mysql /bin/sh -c "mv /var/log/mysql/slow-query.log /var/log/mysql/slow-query.log.$$(date +'%Y%m%d%H%M%S') && mysql -uroot -p isuconp -e 'FLUSH SLOW LOGS'"

top:
	docker compose exec -it app top

restart-app:
	docker compose build --no-cache app && docker compose up -d app

restart-nginx:
	docker compose build --no-cache nginx && docker compose up -d nginx
	
PHONY: bench
