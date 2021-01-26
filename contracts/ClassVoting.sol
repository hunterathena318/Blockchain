// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract ClassVoting {
  struct Student {
    uint id;
    string name;
    uint age;
  }

  struct Location {
    uint long;
    uint lat;
    string  name;
  }
  uint public count;
  uint x;
  uint y;
  mapping(uint => Student) public students;
  mapping(uint => Location) public location;

  constructor() public {
  }

  function addStudent(string memory _name, uint _age ) private {
    count++;
    students[count] = Student( count, _name, _age);
  }

  function implementAddStudent() public {
    addStudent("student1",15);
    addStudent("student2",15);
  }

  function getUser(uint _id) public view returns (string memory, uint) {
//    Student memory student = students[_id];
//    Student storage st = students[-_id];
//    return (st.name, st.age);
    return(students[_id].name, students[_id].age);
  }

  function getBalance() public view returns(uint256) {
      return address(0xCFBb8878E8238cC104C1D4e6b0503A53A25ece68).balance;
  }

  function withdraw() public {
    msg.sender.transfer(address(this).balance);
  }
//
//  function deposit() public {
//
//  }

}
