# Navedex API

API Developed as a backend challenge.

## General Info

### Version

- Ruby 2.7.0
- Rails 6.0.3

### Important Notes

- Postman Collection's is on this repository as [navedex.postman_collection.json](https://github.com/Hey-Feres/navedex/blob/master/navedex.postman_collection.json)

### What has been completed
- [x] Implement a Ruby on Rails API
- [x] Write a documentation for the API
- [ ] Use a docker container
- [x] Write some tests
- [ ] Write UI client

### Getting Started

Run the following commands in your terminal

```bash
git clone https://github.com/Hey-Feres/navedex.git
cd navedex
bundle
rails db:create db:migrate db:seed
rails s
```

### About the tests

- Used gems
	- [Faker](https://github.com/faker-ruby/faker): used to generate fake data.
	- [FactoryBot](https://github.com/thoughtbot/factory_bot_rails): used to generate model data for tests.
	- [Rspec](https://github.com/rspec/rspec-rails): the main tool to write the tests.
	- [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers): used to reduce the rspec commands.
- Was written only request tests, model tests was avoided.
- To run the tests run ```rspec``` on your terminal

### About the authentication

- The User's signup and signin endpoints return auth headers (access-token, client, uid, expiry and token-type). These values must be passed as headers in the protected endpoints.
- The token <span style="color: red"> does not change </span> on each request.
- The protected endpoints are identified with a lock emoji (🔓)

## Endpoints Documentation

<details>
  <summary>Users</summary>

<details>
	<summary>Signup</summary>

<span style="color: white; background-color: blue; padding: 5px; border-radius: 5px"> POST </span>

Endpoint: 
	
``` json
/api/v1/auth
```
	
Headers:
	
``` json
Content-Type: application/json
```
	
Body Format:
	
``` json
{
  "email": "bruno@teste.com",
  "password": "123456",
  "password_confirmation": "123456"
}
```
</details>  

<details>
	<summary>Signin</summary>

<span style="color: white; background-color: blue; padding: 5px; border-radius: 5px"> POST </span>

Endpoint: 
	
``` json
/api/v1/auth/sign_in
```
	
Headers:
	
``` json
Content-Type: application/json
```
	
Body Format:
	
``` json
{
  "email": "bruno@teste.com",
  "password": "123456"
}
```
</details>  
</details>

---

<details>
  <summary> Navers </summary>

<!---   INDEX   -->

<details>
	<summary>🔓Index</summary>

<span style="color: white; background-color: green; padding: 5px; border-radius: 5px"> GET </span>

Endpoint
	
``` json
/api/v1/navers
```

Headers

|Name         |Type   |
|-------------|-------|
|access-token |String |
|client       |String |
|uid          |String |
|expiry       |String |
|token-type   |String |

URL Params

|Name       |Type   |Value Example  |
|-----------|-------|---------------|
|search_by  |String |name           |
|search_for |String |Bruno          |
|sort_by    |String |birthdate      |
|order_by   |String |asc            |
|length     |Integer|10             |
|page       |Integer|2              |

</details>  

<!---   SHOW   -->

<details>
	<summary>🔓Show</summary>

<span style="color: white; background-color: green; padding: 5px; border-radius: 5px"> GET </span>

Endpoint
	
``` json
/api/v1/navers/:id
```

Headers

|Name         |Type   |
|-------------|-------|
|access-token |String |
|client       |String |
|uid          |String |
|expiry       |String |
|token-type   |String |

</details>  

<!---	  CREATE   -->

<details>
	<summary>🔓Create</summary>

<span style="color: white; background-color: blue; padding: 5px; border-radius: 5px"> POST </span>

Endpoint
	
``` json
/api/v1/navers
```

Headers

|Name         |Type   |
|-------------|-------|
|access-token |String |
|client       |String |
|uid          |String |
|expiry       |String |
|token-type   |String |

Body

``` json
{
	"naver": {
		"name": "Bruno",
		"birthdate": "1999-09-23",
		"admission_date": "2021-01-01",
		"job_role": "Developer",
		"projects_ids": [1,2,3]
	}
}
```

Body Attributes

|Name                |Type   |Value Example  |
|--------------------|-------|---------------|
|name                |String |Bruno          |
|birthdate           |String |1999-09-23     |
|admission_date      |String |2021-01-01     |
|job_role            |String |Developer      |
|projects_ids     	 |Array  |[1,2,3,4]      |
|remove_projects_ids |Array  |[4]            |


</details>

<!---   UPDATE   -->

<details>
	<summary>🔓Update</summary>

<span style="color: white; background-color: purple; padding: 5px; border-radius: 5px"> PUT </span>

Endpoint
	
``` json
/api/v1/navers/:id
```

Headers

|Name         |Type   |
|-------------|-------|
|access-token |String |
|client       |String |
|uid          |String |
|expiry       |String |
|token-type   |String |

Body

``` json
{
	"naver": {
		"name": "Bruno",
		"birthdate": "1999-09-23",
		"admission_date": "2021-01-01",
		"job_role": "Developer",
		"projects_ids": [18,19,20],
		"remove_projects_ids": [1,2]
	}
}
```

Body Attributes

|Name                |Type   |Value Example  |
|--------------------|-------|---------------|
|name                |String |Bruno          |
|birthdate           |String |1999-09-23     |
|admission_date      |String |2021-01-01     |
|job_role            |String |Developer      |
|projects_ids     	 |Array  |[1,2,3,4]      |
|remove_projects_ids |Array  |[4]            |


</details>

<!---	  DESTROY   -->

<details>
	<summary>🔓Destroy</summary>

<span style="color: white; background-color: red; padding: 5px; border-radius: 5px"> DELETE </span>

Endpoint
	
``` json
/api/v1/navers/:id
```

Headers

|Name         |Type   |
|-------------|-------|
|access-token |String |
|client       |String |
|uid          |String |
|expiry       |String |
|token-type   |String |

</details>

</details>

---

<details>
  <summary> Projects </summary>

<!---   INDEX   -->

<details>
	<summary>🔓Index</summary>

<span style="color: white; background-color: green; padding: 5px; border-radius: 5px"> GET </span>

Endpoint
	
``` json
/api/v1/projects
```

Headers

|Name         |Type   |
|-------------|-------|
|access-token |String |
|client       |String |
|uid          |String |
|expiry       |String |
|token-type   |String |

URL Params

|Name       |Type   |Value Example   |
|-----------|-------|----------------|
|search_by  |String |name            |
|search_for |String |Awesome Project |
|sort_by    |String |name            |
|order_by   |String |asc             |
|length     |Integer|10              |
|page       |Integer|2               |

</details>  

<!---   SHOW   -->

<details>
	<summary>🔓Show</summary>

<span style="color: white; background-color: green; padding: 5px; border-radius: 5px"> GET </span>

Endpoint
	
``` json
/api/v1/projects/:id
```

Headers

|Name         |Type   |
|-------------|-------|
|access-token |String |
|client       |String |
|uid          |String |
|expiry       |String |
|token-type   |String |

</details>  

<!---	  CREATE   -->

<details>
	<summary>🔓Create</summary>

<span style="color: white; background-color: blue; padding: 5px; border-radius: 5px"> POST </span>

Endpoint
	
``` json
/api/v1/projects
```

Headers

|Name         |Type   |
|-------------|-------|
|access-token |String |
|client       |String |
|uid          |String |
|expiry       |String |
|token-type   |String |

Body

``` json
{
	"project": {
		"name": "Awesome Project",
		"navers_ids": [1,2,3,4,5]
	}
}
```

Body Attributes

|Name                |Type   |Value Example   |
|--------------------|-------|----------------|
|name                |String |Awesome Project |
|navers_ids     	 	 |Array  |[1,2,3,4]       |
|remove_navers_ids   |Array  |[4]             |


</details>

<!---   UPDATE   -->

<details>
	<summary>🔓Update</summary>

<span style="color: white; background-color: purple; padding: 5px; border-radius: 5px"> PUT </span>

Endpoint
	
``` json
/api/v1/projects/:id
```

Headers

|Name         |Type   |
|-------------|-------|
|access-token |String |
|client       |String |
|uid          |String |
|expiry       |String |
|token-type   |String |

Body

``` json
{
	"project": {
		"name": "Awesome Project",
		"navers_ids": [1,2,3,4,5]
	}
}
```

Body Attributes

|Name                |Type   |Value Example   |
|--------------------|-------|----------------|
|name                |String |Awesome Project |
|navers_ids     	 	 |Array  |[1,2,3,4]       |
|remove_navers_ids   |Array  |[4]             |


</details>

<!---	  DESTROY   -->

<details>
	<summary>🔓Destroy</summary>

<span style="color: white; background-color: red; padding: 5px; border-radius: 5px"> DELETE </span>

Endpoint
	
``` json
/api/v1/projects/:id
```

Headers

|Name         |Type   |
|-------------|-------|
|access-token |String |
|client       |String |
|uid          |String |
|expiry       |String |
|token-type   |String |

</details>

</details>
