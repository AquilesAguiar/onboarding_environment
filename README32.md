# Phoenix

Ambiente contendo:
- Elixir 1.8.1
- Mix 1.8.1
- Phoenix 1.5.13

## Uso

```bash
docker-compose run phoenix bash
```
## Running Aplication
```
mix phx.server
```

#API ROUTES

##GET

`INDEX GET registers/`

###Response

{"products":[{"id": "61b2132a6057a7010302be58", "sku": 0,"name": "test,"description": "product test","price": 8.0,"qtd": 2.0}, ...]}
	
`PRODUCT GET /registers/:id`

###Response
	
{"product":{"id": "61b2132a6057a7010302be58", "sku": 5,"name": "test,"description": "product test","price": 8.0,"qtd": 2.0}}
		  
##POST  

`CREATE A PRODUCT POST /registers/`
```
curl -d '{"register":{"sku": 5,"name": "test,"description": "product test","price": 8.0,"qtd": 2.0}}' -H "Content-Type: application/json" -X POST http://localhost:3000/registers/
```
    	
##PUT

`UPDATE A PRODUCT POST /registers/:id`
```
curl -d '{"register":{"sku": 5,"name": "test,"description": "product test","price": 8.0,"qtd": 2.0}}' -H "Content-Type: application/json" -X PUT http://localhost:3000/registers/:sku
```
	    
##DELETE

`DELETE /registers/:id`
```
curl -X DELETE http://localhost:3000/registers/:sku
```


	
