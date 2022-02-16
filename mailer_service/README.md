# MailerService

Ambiente contendo:
- Elixir 1.8.1
- Mix 1.8.1
- Phoenix 1.5.13

## Uso

```bash
docker-compose run mailer_service bash
```
## Running Aplication

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`
  Now you can visit [`localhost:4444`](http://localhost:4444) from your browser.

#API ROUTES

##POST  

`CREATE A PRODUCT POST /registers/`
```
curl -d '{"email_params":"mzxw6ytboimzXW6ytBOimzXW6ytBOimzXW6ytBOi"}' -H "Content-Type: application/json" -X POST http://localhost:4444/send/
```