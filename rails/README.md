# Rails

Ambiente contendo:
- Ruby 2.2.7
- Rails 4

## Uso

```bash
docker-compose run rails bash
```
## Running Aplication
```
rails server
```

#API ROUTES

##GET

`INDEX GET /`

###Response
[{"sku": 0,"name": "test,"description": "product test","price": 8.0,"qtd": 2.0}, ...]
	
`PRODUCT GET /product/:sku`

###Response
	
{"sku": 5,"name": "test,"description": "product test","price": 8.0,"qtd": 2.0}
		  
##POST  

`CREATE A PRODUCT POST /create/`

    	curl -i -H 'Accept: application/json' -d 'sku=1&name=new&description=test&price=9&qtd=1' http://localhost:3000/create
    	
##PUT

`UPDATE A PRODUCT POST /update/:sku`
	    curl -i -H 'Accept: application/json' -X PUT -d 'name=banana' http://localhost:3000/update/1
	    
##DELETE

`DELETE /destroy/:sku`

curl -i -H 'Accept: application/json' -X DELETE http://localhost:3000/destroy/1/


	
