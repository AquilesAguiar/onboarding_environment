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
rails server
```

#API ROUTES

##GET

`INDEX GET register/`

###Response

{"data":[{"sku": 0,"name": "test,"description": "product test","price": 8.0,"qtd": 2.0}, ...]}
	
`PRODUCT GET /register/:sku`

###Response
	
{"data":{"sku": 5,"name": "test,"description": "product test","price": 8.0,"qtd": 2.0}}
		  
##POST  

`CREATE A PRODUCT POST /register/`
```
curl -d '{"data":{"sku": 5,"name": "test,"description": "product test","price": 8.0,"qtd": 2.0}}' -H "Content-Type: application/json" -X POST http://localhost:3000/api/register/
```
    	
##PUT

`UPDATE A PRODUCT POST /register/:sku`
```
curl -d '{"data":{"sku": 5,"name": "test,"description": "product test","price": 8.0,"qtd": 2.0}}' -H "Content-Type: application/json" -X PUT http://localhost:3000/api/register/:sku
```
	    
##DELETE

`DELETE /register/:sku`
```
curl -X DELETE http://localhost:3000/api/register/:sku
```


	
