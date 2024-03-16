
### How to create service?

```bash
$ curl -i -s -X POST http://localhost:8001/services \
  --data name=fake_service \
  --data url='http://httpbin.org'
HTTP/1.1 201 Created
Date: Sat, 16 Mar 2024 18:20:51 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
Access-Control-Allow-Origin: *
Access-Control-Allow-Credentials: true
Content-Length: 373
X-Kong-Admin-Latency: 15
Server: kong/3.6.1

{"client_certificate":null,"path":null,"connect_timeout":60000,"read_timeout":60000,"write_timeout":60000,"host":"httpbin.org","tags":null,"ca_certificates":null,"tls_verify":null,"tls_verify_depth":null,"protocol":"http","retries":5,"enabled":true,"created_at":1710613251,"updated_at":1710613251,"port":80,"id":"77f2e7f9-f023-4fed-a501-2e199242b671","name":"fake_service"}
```

You can check this service running:

```bash
$ curl -X GET http://localhost:8001/services/fake_service  | jq .
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   373  100   373    0     0  58045      0 --:--:-- --:--:-- --:--:-- 62166
{
  "client_certificate": null,
  "path": null,
  "connect_timeout": 60000,
  "read_timeout": 60000,
  "write_timeout": 60000,
  "host": "httpbin.org",
  "tags": null,
  "ca_certificates": null,
  "tls_verify": null,
  "tls_verify_depth": null,
  "protocol": "http",
  "retries": 5,
  "enabled": true,
  "created_at": 1710613251,
  "updated_at": 1710613251,
  "port": 80,
  "id": "77f2e7f9-f023-4fed-a501-2e199242b671",
  "name": "fake_service"
}
```

### How to create routes?

```bash
$ curl -i -X POST http://localhost:8001/services/fake_service/routes \
  --data 'paths[]=/fake_service' \
  --data 'protocols[]=http' \
  --data 'methods[]=GET' \
  --data name=fake_service_route
HTTP/1.1 201 Created
Date: Sat, 16 Mar 2024 18:22:43 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
Access-Control-Allow-Origin: *
Access-Control-Allow-Credentials: true
Content-Length: 493
X-Kong-Admin-Latency: 22
Server: kong/3.6.1

{"strip_path":true,"hosts":null,"destinations":null,"methods":["GET"],"headers":null,"snis":null,"request_buffering":true,"response_buffering":true,"tags":null,"https_redirect_status_code":426,"id":"6b7721c6-49e0-4986-bacb-4de887676ae6","protocols":["http"],"preserve_host":false,"path_handling":"v0","regex_priority":0,"service":{"id":"77f2e7f9-f023-4fed-a501-2e199242b671"},"updated_at":1710613363,"paths":["/fake_service"],"name":"fake_service_route","created_at":1710613363,"sources":null}
```

You can check this route running the following command:

```bash
$ curl -X GET http://localhost:8001/services/fake_service/routes/fake_service_route | jq .
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   493  100   493    0     0  43162      0 --:--:-- --:--:-- --:--:-- 44818
{
  "strip_path": true,
  "hosts": null,
  "destinations": null,
  "methods": [
    "GET"
  ],
  "headers": null,
  "snis": null,
  "request_buffering": true,
  "response_buffering": true,
  "tags": null,
  "https_redirect_status_code": 426,
  "id": "6b7721c6-49e0-4986-bacb-4de887676ae6",
  "protocols": [
    "http"
  ],
  "preserve_host": false,
  "path_handling": "v0",
  "regex_priority": 0,
  "service": {
    "id": "77f2e7f9-f023-4fed-a501-2e199242b671"
  },
  "updated_at": 1710613363,
  "paths": [
    "/fake_service"
  ],
  "name": "fake_service_route",
  "created_at": 1710613363,
  "sources": null
}
```

Finally, you can now access to the FAKE SERVICE API. You only need to put `http://localhost:8000/fake_service` upfront. For example:

```bash
$ curl -X GET http://localhost:8000/fake_service/get | jq .
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   456  100   456    0     0    216      0  0:00:02  0:00:02 --:--:--   217
{
  "args": {},
  "headers": {
    "Accept": "*/*",
    "Host": "httpbin.org",
    "User-Agent": "curl/7.81.0",
    "X-Amzn-Trace-Id": "Root=1-65f5e694-77b660aa691c64b50f97dd69",
    "X-Forwarded-Host": "localhost",
    "X-Forwarded-Path": "/fake_service/get",
    "X-Forwarded-Prefix": "/fake_service",
    "X-Kong-Request-Id": "c787b8073489392d15d0497f3ac2a15b"
  },
  "origin": "172.26.0.1, 189.124.186.200",
  "url": "http://localhost/get"
}
```

### Setting up Rate limiting

To enable globally, run the following command:

```bash
$ curl -i -X POST http://localhost:8001/plugins \
  --data name=rate-limiting \
  --data config.minute=5 \
  --data config.policy=local
HTTP/1.1 201 Created
Date: Sat, 16 Mar 2024 19:50:10 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
Access-Control-Allow-Origin: *
Access-Control-Allow-Credentials: true
Content-Length: 862
X-Kong-Admin-Latency: 22
Server: kong/3.6.1

{"id":"51db7406-38db-480a-88d6-b3d63a817e75","protocols":["grpc","grpcs","http","https"],"updated_at":1710618610,"route":null,"consumer":null,"enabled":true,"service":null,"instance_name":null,"created_at":1710618610,"name":"rate-limiting","config":{"redis_password":null,"error_code":429,"error_message":"API rate limit exceeded","sync_rate":-1,"path":null,"redis":{"password":null,"username":null,"ssl_verify":false,"server_name":null,"database":0,"host":null,"port":6379,"ssl":false,"timeout":2000},"redis_timeout":2000,"redis_server_name":null,"limit_by":"consumer","redis_database":0,"redis_ssl_verify":false,"redis_ssl":false,"redis_username":null,"redis_port":6379,"redis_host":null,"second":null,"minute":5,"hour":null,"day":null,"fault_tolerant":true,"year":null,"hide_client_headers":false,"policy":"local","month":null,"header_name":null},"tags":null}
```

To enable by service:

```bash
$ curl -i -X POST http://localhost:8001/services/fake_service/plugins \
  --data name=rate-limiting \
  --data config.minute=5 \
  --data config.policy=local
HTTP/1.1 201 Created
Date: Sat, 16 Mar 2024 19:59:57 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
Access-Control-Allow-Origin: *
Access-Control-Allow-Credentials: true
Content-Length: 903
X-Kong-Admin-Latency: 19
Server: kong/3.6.1

{"id":"c6b21f58-2e81-42ef-a316-4cb2fb65052d","protocols":["grpc","grpcs","http","https"],"updated_at":1710619197,"route":null,"consumer":null,"enabled":true,"service":{"id":"77f2e7f9-f023-4fed-a501-2e199242b671"},"instance_name":null,"created_at":1710619197,"name":"rate-limiting","config":{"redis_password":null,"error_code":429,"error_message":"API rate limit exceeded","sync_rate":-1,"path":null,"redis":{"password":null,"username":null,"ssl_verify":false,"server_name":null,"database":0,"host":null,"port":6379,"ssl":false,"timeout":2000},"redis_timeout":2000,"redis_server_name":null,"limit_by":"consumer","redis_database":0,"redis_ssl_verify":false,"redis_ssl":false,"redis_username":null,"redis_port":6379,"redis_host":null,"second":null,"minute":5,"hour":null,"day":null,"fault_tolerant":true,"year":null,"hide_client_headers":false,"policy":"local","month":null,"header_name":null},"tags":null}
```

### How to enable Proxy Caching?

To enable globally:

```bash
$ curl -i -X POST http://localhost:8001/plugins \
  --data "name=proxy-cache" \
  --data "config.request_method=GET" \
  --data "config.response_code=200" \
  --data "config.content_type=application/json; charset=utf-8" \
  --data "config.cache_ttl=25" \
  --data "config.strategy=memory"
HTTP/1.1 201 Created
Date: Sat, 16 Mar 2024 20:09:18 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
Access-Control-Allow-Origin: *
Access-Control-Allow-Credentials: true
Content-Length: 622
X-Kong-Admin-Latency: 17
Server: kong/3.6.1

{"id":"9d0d47ff-a7d3-44a3-b042-05150163349c","protocols":["grpc","grpcs","http","https"],"updated_at":1710619758,"route":null,"consumer":null,"enabled":true,"service":null,"instance_name":null,"created_at":1710619758,"name":"proxy-cache","config":{"response_code":[200],"response_headers":{"age":true,"X-Cache-Key":true,"X-Cache-Status":true},"storage_ttl":null,"content_type":["application/json; charset=utf-8"],"memory":{"dictionary_name":"kong_db_cache"},"vary_headers":null,"request_method":["GET"],"strategy":"memory","cache_ttl":25,"cache_control":false,"vary_query_params":null,"ignore_uri_case":false},"tags":null}
```

You may check using the following command:

```bash
$ curl -i -s -XGET http://localhost:8000/fake_service/anything | grep X-Cache
X-Cache-Key: f55870bbd03ee565cfd141c95d67999b9200ee896b4347dbe2e42f8424c5825b
X-Cache-Status: Bypass
```

The `Bypass` means it is been cached.

