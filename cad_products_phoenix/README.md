# CadProductsPhoenix

Ambiente contendo:
- Elixir 1.8.1
- Mix 1.8.1
- Phoenix 1.5.13

## Uso

```bash
docker-compose run phoenix bash
```
## Running Aplication

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`
  Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

#API ROUTES

##GET

`INDEX GET registers/`

###Response

{"products":[{"id": "61b2132a6057a7010302be58", "sku": 0,"name": "test,"description": "product test","price": 8.0,"qtd": 2.0}, ...]}
	
`PRODUCT GET /registers/:id`

###Response
	
{"product":{"id": "61b2132a6057a7010302be58", "sku": 5,"name": "test,"description": "product test","price": 8.0,"qtd": 2.0}}

`REPORT GET /report/`

###Response
	
"barcode,description,name,price,qtd,sku\r\n,morango,pá,15.0,85,olha\r\n,morango,pá,15.0,85,slkjfoa\r\n,morango,pá,15.0,85,dlskjdfp\r\n"

##POST  

`CREATE A PRODUCT POST /registers/`
```
curl -d '{"register":{"sku": 5,"name": "test,"description": "product test","price": 8.0,"qtd": 2.0}}' -H "Content-Type: application/json" -X POST http://localhost:4000/registers/
```

`GENERATE A REPORT PRODUCT POST /report/`
```
curl -X POST http://localhost:4000/report/
```
    	
##PUT

`UPDATE A PRODUCT POST /registers/:id`
```
curl -d '{"register":{"sku": 5,"name": "test,"description": "product test","price": 8.0,"qtd": 2.0}}' -H "Content-Type: application/json" -X PUT http://localhost:4000/registers/:sku
```
	    
##DELETE

`DELETE /registers/:id`
```
curl -X DELETE http://localhost:4000/registers/:sku
```


	
