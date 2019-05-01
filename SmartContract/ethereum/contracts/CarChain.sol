pragma solidity ^0.4.18;

contract CarChain {
    
    struct Car {
        string plate;
        string userId;
        bool registered;
    }
    
    struct User{
        string id;
        uint credit;
        string carPlate;
        bool registered;
    }

    mapping(string => User) users;
    mapping(string => Car) cars;
    
    address manager;
    
    uint public minimumRentCredit;
    
    uint public registeredUsers;
    uint public registeredCars;
    
    uint public rentedCars;
    uint public availableCars;
    
    function CarChain() public {
        manager = msg.sender;
        minimumRentCredit = 1;
        registeredUsers = 0;
        registeredCars = 0;
        rentedCars = 0;
        availableCars = 0;
    }
    
    function registerNewUser(string _userId) public{
        require(!users[_userId].registered);
        
        User storage newUser = users[_userId];
        newUser.id = _userId;
        newUser.credit = 0;
        newUser.registered = true;
        newUser.carPlate = "-";
        registeredUsers++;
    }
    
    function registerNewCar(string _plate) public restricted{
        //Check there is no Car registered with this id
        require(!cars[_plate].registered);
        
        Car storage newCar = cars[_plate];
        newCar.plate = _plate;
        newCar.registered = true;
        newCar.userId = "-";
        registeredCars++;
        updateAvailableCars();
    }
    
    function rentCar(string _plate, string _userId) public {
        require(cars[_plate].registered);
        require(users[_userId].registered);
        require(users[_userId].credit >= minimumRentCredit);
        require(keccak256(cars[_plate].userId) == keccak256("-"));
        require(keccak256(users[_userId].carPlate) == keccak256("-"));

        User storage user = users[_userId];
        user.credit -= minimumRentCredit;
        user.carPlate = _plate;
        Car storage car = cars[_plate];
        car.userId = _userId;
        rentedCars++;
        updateAvailableCars();
    }
    
    function returnCar(string _plate, string _userId) public {
        require(cars[_plate].registered);
        require(users[_userId].registered);
        require(keccak256(cars[_plate].userId) == keccak256(_userId));
        require(keccak256(users[_userId].carPlate) == keccak256(_plate));

        User storage user = users[_userId];
        user.carPlate = "-";
        Car storage car = cars[_plate];
        car.userId = "-";
        
        rentedCars--;
        updateAvailableCars();
    }
    
    function getUserCredit(string _userId) public view returns (uint){
        return users[_userId].credit;
    }
    
    function getUserCar(string _userId) public view returns (string){
        return users[_userId].carPlate;
    }
    
    function updateAvailableCars() private {
        availableCars = registeredCars - rentedCars;
    }
    
    function addCredit(string _userId, uint _credit) public {
        require(users[_userId].registered);
        User storage user = users[_userId];
        user.credit += _credit;
    }
    
    modifier restricted(){
        require(msg.sender == manager);
        _;
    }
}