# greenatom-test

### Сборка и запуск

```sh
docker-compose up
# для нового приложения необходимо создать базу и накатить миграционные процедуры
docker-compose exec app rails db:migrate
```

## Использование

```sh
# Создание пользователя
curl -X POST -H 'Content-Type: application/json' -d '{"name":"James Bond","email":"007@mail.ru"}' 'http://localhost:3000/users'

# Список пользователей
curl -H 'Content-Type: application/json' 'http://localhost:3000/users'
```
