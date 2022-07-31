import Text "mo:base/Text";
import Nat "mo:base/Nat";
import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import Trie "mo:base/Trie";
import List "mo:base/List";
import Result "mo:base/Result";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";

import Person "person"

// import Debug "mo:base/Debug";
// import HTTP "http";

// import Time "mo:base/Time";

actor {
  public type Person = {
      ID : Nat;
      Name : Text;
      Birthday : Text;
      Phone : Text;
      Sex : Bool;
  }
    
  // stable var entries : [( Principal, Person)] = [];

  var Customer_List = HashMap.HashMap<Principal, Person>(0, Principal.equal, Principal.hash);
  
  type FavorResult = {#ok : Text; #dup : Text};
  // type FavorResult<T,E> = Result.Result<T, E>;

  // Function 1:  Read Account function
  public query func read_Account() : async ?Person {
        return(users.get(Customer_List));
  };

<<<<<<< HEAD
  // Function 3: Update Account function
  public shared({caller}) func updateAccount(user : Profile) : async Result.Result<Text,Text> {
        switch(users.get(caller)){
            case(null) return #err("There is no user profile for principal : " # Principal.toText(caller));
            case(?user) {
                users.put(caller, user);
                return #ok("Profile modified for user with principal : " # Principal.toText(caller));
            };
        };
    };
=======
  //createAccount
  public shared(caller) func createAccount ( ID : Nat, Name : Text, Birthday : Text, Phone : Text, Sex : Bool; ) : async () {
    var person: Person = {
      ID,
      Name,
      Birthday,
      Phone,
      Sex
    };
    switch (Customer_List.get(caller.caller)) {
      case null {
        Customer_List.put(caller.caller, Person);
      };
    }
  };

>>>>>>> 3040b5288e297a7377f3b7e1ad012cfa281f334e

  // dfx canister call day_3_backend add_favorite_number '(5)'
  public shared(caller) func add_favorite_number ( n : Nat ) : async FavorResult {
    switch (favoriteNumber.get(caller.caller)) {
      case null {
        favoriteNumber.put(caller.caller, n);
        return #ok ("You've successfully registered your number");
      };
      case (_) {#dup ("You've already registered your number")}
    }
  };
  // dfx canister call day_3_backend show_favorite_number '()'
  public shared(caller) func show_favorite_number () : async ?Nat {
    favoriteNumber.get(caller.caller)
  };
  // dfx canister call day_3_backend update_favorite_number '(8)'
  public shared(caller) func update_favorite_number ( n : Nat ) : async () {
    favoriteNumber.put(caller.caller, n);
  };

  // dfx canister call day_3_backend delete_favorite_number '()'
  public shared(caller) func delete_favorite_number () : async ?Nat {
    favoriteNumber.remove(caller.caller);
  };

  system func preupgrade() {
    entries := Iter.toArray(favoriteNumber.entries());
  }; 

}