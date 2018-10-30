#########################################
            Pablo Blanco Peris
    https://github.com/PabloBlanco10
        pablo_bp94@hotmail.com
#########################################


#########################################
Installation & execution manual (Mac OSX)
#########################################


Requeriments:
    -   File main.go
    -   File .env with Port: Example : ADDR=8081

    -   Go installed
        - If not: https://golang.org/dl/

    -   Go Frameworks needed - Execute in Terminal   
        - $go get github.com/davecgh/go-spew/spew   - Spew allows to view structs and slices cleanly formatted in console.
        - $go get github.com/gorilla/mux            - Gorilla/mux is a popular package for writing web handlers
        - $go get github.com/joho/godotenv          - Godotenv lets read from a .env file like our http ports


Instructions to execute:
    1.- Open Terminal
    2.- $go run main.go
    3.- We can check the blockchain at Chrome (for example) --> http://localhost:8081/
    3.- With Postman we can make some POSTS to add blocks to the blockchain
