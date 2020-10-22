pragma solidity ^0.5.0;

contract Harmonygram {
  string public name = "Harmonygram" ;

  //store Images

  uint public imageCount = 0;
  struct Image {
    uint id;
    string hash;
    string description;
    uint tipAmount;
    address payable author;
  }

  event ImageCreated (
    uint id,
    string hash,
    string description,
    uint tipAmount,
    address payable author
  );

  event ImageTipped (
    uint id,
    string hash,
    string description,
    uint tipAmount,
    address payable author
  );



  mapping(uint => Image) public images;


  //Create Images
  function uploadImage(string memory _imgHash, string memory _description , address payable _author) public {
    //Make sure the image hash exists
    require(bytes(_imgHash).length > 0,"Image Hash Cannot be empty");

    //Make sure the image description exists.
    require(bytes(_description).length > 0 ,"Image Description cannot be empty");

    //Make sure valid user uploads the image.
    require(msg.sender != address(0x0),"Invalid User");


    //Increment Image Id
    imageCount++;
    
    //Add Image to Contract
    images[imageCount] = Image(imageCount, _imgHash, _description , 20, _author);

    //Trigger an Event
    emit ImageCreated(imageCount, _imgHash, _description , 20, _author);

  }


  //Tip Images
  function tipImageOwner(uint _id) public payable {
    //Make sure the id is valid
    require(_id > 0 && _id <= imageCount,"Invalid Id value");

    //Fetch the Image
    Image memory _image = images[_id];

    //Pay the author by sending them crypto
    _image.author.transfer(msg.value);

    //Increase the tip Amount 
    _image.tipAmount += msg.value;
    
    //Update the Image
    images[_id] = _image; 

    //Trigger an event
    emit ImageTipped(_id, _image.hash, _image.description, _image.tipAmount, _image.author);
  }

}