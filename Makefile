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
	docker run --rm --network host -i private-isu-benchmarker /opt/go/bin/benchmarker -t http://localhost -u ./userdata

alp:
	cat logs/nginx/access.log | alp ltsv -m="^/posts/[0-9]+","^/image/[0-9]+\.(jpg|png|gif)","^/@[a-z]*" --reverse

alps:
	cat logs/nginx/access.log | alp ltsv -m="^/posts/[0-9]+","^/image/[0-9]+\.(jpg|png|gif)","^/@[a-z]*" --reverse --sort=sum

alpa:
	cat logs/nginx/access.log | alp ltsv -m="^/posts/[0-9]+","^/image/[0-9]+\.(jpg|png|gif)","^/@[a-z]*" --reverse --sort=avg

pt:
	pt-query-digest logs/mysql/slow-query.log

PHONY: bench
