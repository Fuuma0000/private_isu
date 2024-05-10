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
	docker compose exec -it mysql mysql -uroot -prooot isuconp

bench:
	docker run --rm --network host -i private-isu-benchmarker /opt/go/bin/benchmarker -t http://localhost -u ./userdata

PHONY: bench
