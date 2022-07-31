import Person "person";
import Debug "mo:base/Debug";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Cycles "mo:base/ExperimentalCycles";
import Trie "mo:base/Trie";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";

actor {
  // CRUD with Trie
  type Person = {
    ID: Nat;
    Name: Text;
    Birthday: Text;
    Phone: Text;
    Sex: Bool;
  };

  // aplication state
  stable var persons : Trie.Trie<Nat, Person> = Trie.empty();
  stable var next : Nat = 0;

  // create key
  private func key(x : Nat) : Trie.Key<Nat>{
    return{
      key = x;
      hash = Hash.hash(x);
    };
  };
  
};