//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FelipeCoin {
     // para que sea un erc20 debe tener las siguientes especificaciones https://eips.ethereum.org/EIPS/eip-20
     string public name;
     string public symbol;
     uint8 public decimals;
     uint256 public totalSupply;
     mapping (address => uint256) public balanceOf;
     mapping (address => mapping (address => uint256)) public allowance;

     constructor () public {
         name ="felipecoin";
         symbol = "FC";
         decimals = 10;
         totalSupply = 1000000 * (uint256(10)** decimals);
         balanceOf [msg.sender] = totalSupply;
         }
     //debemos agregar un evento obligatoriamente para que se refleje en la factura que la transaccion se realizo 
     event Transfer (address indexed _from, address indexed _to, uint256 _value);
     event Approval (address indexed owner, address indexed _spender, uint256 _value );

     function transfer(address _to, uint256 _value) public returns (bool success ){
         require (balanceOf [msg.sender] > _value);
         balanceOf [msg.sender] -= _value;
         balanceOf [_to] += _value;
         emit Transfer (msg.sender, _to, _value);
         return true;
         }
    // otro requisito para el erc20 es que una persona externa peuda manejar mis fondos y esta es la funcion: _spender es la cuenta que autorizamos 
     function approve(address _spender, uint256 _value) public returns (bool success){
         allowance [msg.sender] [_spender] = _value;
         emit Approval (msg.sender, _spender, _value);
         return true;
         }
         // ahora toca ahcer la funcion que le permite al _spender transferir los tokens 
     function transferFrom(address _from, address _to, uint256 _value) public returns(bool success){
         require (balanceOf [_from] > _value );
         // esta es la logica para colocar que el que esta aprovado a realziar la transaccion la haga (no entendi mucho)
         require (allowance [_from] [msg.sender] >= _value );
         balanceOf [_from] -= _value;
         balanceOf [_to] += _value;
         allowance [_from] [msg.sender] -= _value;
         emit Transfer (_from, _to, _value);
         return true;

         }
         }


