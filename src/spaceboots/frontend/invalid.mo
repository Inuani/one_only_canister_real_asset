import Text "mo:base/Text";
module { 
 public func get_html() : Blob { return Text.encodeUtf8(""
#"<h1>"
#"    Invalid scan"
#"</h1>");
 };
}