pragma solidity ^0.4.11;
//hadcoins ICO

//version of compiler

contract hadcoin_ico{
    
    //introducing the amximum number of hadcoins available for sale 
    uint public max_hadcoins = 1000000;
    
    //introducing the USD to hadcoin conversation rate 
    uint public usd_to_hadcoins = 1000;
    
    //introduving the total number of hadcoins that have been bought by the investors
    uint public total_hadcoins_bought = 0; 
    
    //mapping from the investor address to its equity in hadcoins and USD 
    mapping(address => uint) equity_hadcoins;
    mapping(address => uint) equity_usd;
    
    //checking if an investor can buy hadcoins
    modifier can_buy_hadcoins(uint usd_invested) {
        require(usd_invested*usd_to_hadcoins + total_hadcoins_bought <= max_hadcoins);
        _;
    }
    
    //getting the equity in hadcoins of an investor
    function equity_in_hadcoins(address investor) external constant returns (uint ) {
        return equity_hadcoins[investor];
    }
    
    //getting the equity in usd of an investor
    function equity_in_usd(address investor) external constant returns (uint ) {
        return equity_usd[investor];
    }
    
    //Buying hadcoins
    function buy_hadcoins(address investor, uint usd_invested) external can_buy_hadcoins(usd_invested) {
        uint hadcoins_bought = usd_invested*usd_to_hadcoins;
        equity_hadcoins[investor] += hadcoins_bought;
        equity_usd[investor] = equity_hadcoins[investor]/1000;
        total_hadcoins_bought += hadcoins_bought;
    }
    
    //sell hadcoins
    function sell_hadcoins(address investor, uint hadcoins_sold) external {
        equity_hadcoins[investor] -= hadcoins_sold;
        equity_usd[investor] = equity_hadcoins[investor]/1000;
        total_hadcoins_bought -= hadcoins_sold;
    }
    
    
}
