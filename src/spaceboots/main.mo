import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Error "mo:base/Error";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Frontend "frontend/__html__";
import Scan "scan";
import Http "mo:certified-cache/Http";

shared ({ caller = creator }) actor class Boot() = this {

    type HttpRequest = Frontend.Request;
    type HttpResponse = Frontend.Response;

    stable var scan_count : Nat = 0;

    var name : Text = "Boot";

    public func http_request_update(request : Frontend.Request) : async Frontend.Response {
        let counter = Scan.scan(request.url, scan_count);
        if (counter <= 0) {
            return {
                body = Text.encodeUtf8("Invalid Scan Count: " # Nat.toText(scan_count));
                headers = [("Content-Type", "text/plain")];
                status_code = 200;
                streaming_strategy = null;
                upgrade = ?false;
            };
        };
        scan_count := counter;
        let new_request = {
            url = "/";
            method = request.method;
            body = request.body;
            headers = request.headers;
        };

        return (Frontend.get_html(new_request));
    };

    
    public query func http_request(request : Http.HttpRequest) : async Http.HttpResponse {

        if (request.url == "/oceanspaceboots.jpg") {
        let res = Frontend.get_html(request);
        return {
            body = res.body;
            headers = res.headers;
            status_code = res.status_code;
            streaming_strategy = null;
            upgrade = ?false;
        };
    };

        let counter = Scan.scan(request.url, scan_count);

        Debug.print("Valid: " # Nat.toText(counter)# " Scan Count: " # Nat.toText(scan_count));
        let new_request = {
            url = if (counter > 0) {
                "/"
            } else {
                "/invalid.html"
            };
            method = request.method;
            body = request.body;
            headers = request.headers;
        };

        let res = Frontend.get_html(new_request);

        return {
            body = res.body;
            headers = res.headers;
            status_code = res.status_code;
            streaming_strategy = null;
            upgrade = if (counter > 0) { ?true } else { ?false };
        };
    };

};
