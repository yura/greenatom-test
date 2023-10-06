# greenatom-test

## Docker

### Сборка и запуск

1. (Опционально) Запуск контейнера с БД, если база не настроена

```sh
docker run -it --rm -p 5432:5432/tcp -v "pgdata:/var/lib/postgresql/data" -e POSTGRES_USER=greenatom -e POSTGRES_PASSWORD=greenatom123 -e POSTGRES_DB=greenatom postgres:15
```

2. Сборка контейнера с приложением
```sh
docker build -t greenatom-img .
```

3. Запуск контейнера с приложением
```sh
docker run -it --rm -p 3000:3000/tcp -e "RAILS_DB_HOST=172.17.0.2" -e "RAILS_DB_NAME=greenatom" -e "RAILS_DB_USER=greenatom" -e "RAILS_DB_PASS=greenatom123" greenatom-img
```

## Использование

```sh
# Создание пользователя
curl -X POST -H 'Content-Type: application/json' -d '{"name":"James Bond","email":"007@mail.ru"}' 'http://localhost:3000/users'

# Список пользователей
curl -H 'Content-Type: application/json' 'http://localhost:3000/users'
```
