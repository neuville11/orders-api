
#### Instructions for running on local environment:

1. Clone the repo

2. Navigate to the root directory

3. Run bundle install to ensure all the needed gems are installed:
    ```
    $ bundle install
    ```
3. Run Yarn Install
    ```
    $ yarn install --check-files
    ```
3. Migrate the DB
    ```
    $ rails db:migrate
    ```
3. Run Rails Server
    ```
    $ rails server
    ```
3. Create a User, send a request with at least email, password and password_confirmation fields in the body
    ```
    url:    https://localhost:3000/auth/

    header: Content-Type: application/json
    body:
            {
               "email": "test@email.com",
               "password": "password",
              "password_confirmation": "password"
            }
    ```
3. You will receive an :ok response with your credentials and token. Please send it in the headers for authentication in all future requests: you will need:
    ```
     - uid
     - access-token
     - client
    ```
