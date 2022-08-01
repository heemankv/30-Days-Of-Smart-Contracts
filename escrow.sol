// Following alogg this tutorial
// https://www.codementor.io/@edzynda/code-an-escrow-smart-contract-in-solidity-14piv60xb6

pragma solidity ^0.6.0;

contract Escrow {
  enum State { AWAITING_PAYMENT, AWAITING_DELIVERY , COMPLETE}
  State public currState;

  address public buyer; // Will get the work, will send the payment
  address payable public seller;  // Will give work, Will receive payment

  modifier onlyBuyer() {
    require(msg.sender == buyer, "Only Buyer can call this method");
  }
  constructor(address _buyer, address payable _seller) public {
      buyer = _buyer;
      seller = _seller;
  }

  function deposit() onlyBuyer external payable {
    require(currState == State.AWAITING_DELIVERY, " Already paid");
    currState = State.AWAITING_DELIVERY;
  }

  function confirmDelivery() onlyBuyer external {
        require(currState == State.AWAITING_DELIVERY, "Cannot confirm delivery");
        seller.transfer(address(this).balance);
        currState = State.COMPLETE;
  }

}