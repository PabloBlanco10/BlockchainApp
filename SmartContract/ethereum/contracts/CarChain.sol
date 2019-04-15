pragma solidity ^0.4.18;

contract CarChain {
    
    struct Car {
        uint id;
        string plate;
        uint userId;
        bool registered;
    }
    
    struct User{
        uint id;
        uint credit;
        uint carId;
        bool registered;
    }

    mapping(uint => User) public users;
    mapping(uint => Car) public cars;
    
    uint public minimumRentCredit;
    
    address manager;
    
    function CarChain() public {
        manager = msg.sender;
        minimumRentCredit = 1;
    }
    
    function registerNewUser(uint _id, uint _credit) public{
        //Check there is no User registered with this id
        require(_id != 0);
        require(users[_id].registered == false);
        
        User storage newUser = users[_id];
        newUser.id = _id;
        newUser.credit = _credit;
        newUser.carId = 0;
        newUser.registered = true;
    }
    
    function registerNewCar(uint _id, string _plate) public restricted{
        //Check there is no Car registered with this id
        require(_id != 0);
        require(cars[_id].registered == false);
        
        Car storage newCar = cars[_id];
        newCar.id = _id;
        newCar.plate = _plate;
        newCar.registered = true;
    }
    
    function rentCar(uint _carId, uint _userId) public {
        require(cars[_carId].registered == true);
        require(users[_userId].registered == true);
        require(cars[_carId].userId == 0);
        require(users[_userId].carId == 0);
        require(users[_userId].credit >= minimumRentCredit);
        
        User storage user = users[_userId];
        user.carId = _carId;
        user.credit = user.credit - minimumRentCredit;
        Car storage car = cars[_carId];
        car.userId = _userId;
    }
    
    function returnCar(uint _carId, uint _userId) public {
        require(cars[_carId].registered == true);
        require(users[_userId].registered == true);
        require(cars[_carId].userId != 0);
        require(users[_userId].carId != 0);

        User storage user = users[_userId];
        user.carId = 0;
        Car storage car = cars[_carId];
        car.userId = 0;
    }
    
    function getUserCredit(uint _id) public view returns (uint){
        return users[_id].credit;
    }
    
    modifier restricted(){
        require(msg.sender == manager);
        _;
    }
}