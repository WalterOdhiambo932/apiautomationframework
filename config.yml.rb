# api_automation_framework/config.yml (Example)

base_url: "https://api.example.com"
tests:
  - name: "Get Users"
    method: get
    endpoint: "/users"
    expected_status: 200
    schema: "schemas/users_schema.json"
    headers: {}
  - name: "Create User"
    method: post
    endpoint: "/users"
    payload: { "name": "John Doe", "email": "john.doe@example.com" }
    expected_status: 201
    expected_body: { "name": "John Doe", "email": "john.doe@example.com", "id": 1 }
    headers: {}
  - name: "Delete User"
    method: delete
    endpoint: "/users/1"
    expected_status: 204
    headers: {}