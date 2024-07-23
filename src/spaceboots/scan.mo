import Sha "sha";
import Cmac "cmac";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Char "mo:base/Char";
import Nat64 "mo:base/Nat64";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Debug "mo:base/Debug";

module {

    public func hexToNat(hexString: Text) : Nat {
        var result : Nat = 0;
        for (char in Text.toIter(hexString)) {
            if (Char.toNat32(char) >= Char.toNat32('0') and Char.toNat32(char) <= Char.toNat32( '9')) {
                result := result * 16 + (Nat32.toNat(Char.toNat32(char)) - 48);
            }
            else if (Char.toNat32(char) >= Char.toNat32('A') and Char.toNat32(char) <= Char.toNat32( 'F')) {
                result := result * 16 + (Nat32.toNat(Char.toNat32(char)) - 55);
            }
            else if (Char.toNat32(char) >= Char.toNat32('a') and Char.toNat32(char) <= Char.toNat32('f')) {
                result := result * 16 + (Nat32.toNat(Char.toNat32(char)) - 87);
            }
            else {
                assert(false);
            }
        };
        return result;
    };

      public func subText(value : Text, indexStart : Nat, indexEnd : Nat) : Text {
    if (indexStart == 0 and indexEnd >= value.size()) {
        return value;
    }
    else if (indexStart >= value.size()) {
        return "";
    };
    
    var indexEndValid = indexEnd;
    if (indexEnd > value.size()) {
        indexEndValid := value.size();
    };

    var result : Text = "";
    var iter = Iter.toArray<Char>(Text.toIter(value));
    for (index in Iter.range(indexStart, indexEndValid - 1)) {
        result := result # Char.toText(iter[index]);
    };

    result;
  };

    public func scan(url : Text, scan_count : Nat) : Nat {
        Debug.print("1");

        let full_query = Iter.toArray(Text.split(url, #char '?'));
        if (full_query.size() != 2) {
            return 0;
        };
         Debug.print("1");

        let queries = Iter.toArray(Text.split(full_query[1], #char '&'));

        if (queries.size() != 3) {
            return 0;
        };
         Debug.print("1");

        let cmac_query = Iter.toArray(Text.split(queries[2], #char '='));
        let counter_query = Iter.toArray(Text.split(queries[1], #char '='));

        if (cmac_query.size() != 2 or counter_query.size() != 2 or cmac_query[0] != "cmac" or counter_query[0] != "ctr") {
            return 0;
        };
         Debug.print("1");

        var counter = hexToNat(counter_query[1]);

        // counter = to_hex(counter);
        let cmacs = Cmac.get_cmacs();

        let sha = Sha.sha256(Array.map(Text.toArray(cmac_query[1]), func (c : Char) : Nat8 { Nat8.fromNat(Nat32.toNat(Char.toNat32(c)))}));
    


        if (counter >= cmacs.size() or counter <= scan_count) {
            return 0;
        };
         Debug.print("1");
    
        var res = counter;

        for (i in Iter.range(0, sha.size() - 1)) {
            if (Nat8.toNat(sha[i]) != hexToNat(subText(cmacs[counter - 1], i * 2, i * 2 + 2))) {
                res := 0;
            };
        };
         Debug.print(Nat.toText(res));

        return res;
    };

};
