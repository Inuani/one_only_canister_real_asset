from glob import glob
import os
import argparse

parser = argparse.ArgumentParser(
                    prog='HTML to Motoko',
                    description='Convert an HTML project folder to Motoko',
                    epilog='Enjoy the program! :)')

parser.add_argument('-s', '--source', required=True, type=str, nargs='?', help='The source of the video or playlist, can be an url or a file with multiple urls')
parser.add_argument('-d', '--destination', required=True, type=str, nargs='?', help='if you want to download the video as mp4')

args = parser.parse_args()

# list of supported mimetypes, add more if needed
mimetypes = {
        "html": "text/html",
        "css": "text/css",
        "js": "text/javascript",
        "jpg": "image/jpeg",
        "jpeg": "image/jpeg",
        "png": "image/png",
        "svg": "image/svg+xml",
        "ico": "image/x-icon"
    }

# convert text file to motoko
def text_file_to_motoko(input, output):
    with open(input, "r") as file:
        index_html = file.read().replace('"', '\\"').split("\n")
    index_html =  'import Text "mo:base/Text";\nmodule { \n public func get_html() : Blob { return Text.encodeUtf8("'+ '"\n#"'.join(index_html) + '");\n };\n}'
    with open (output, "w") as file:
        file.write(index_html)

# convert byte file to motoko
def byte_file_to_motoko(input, output):
    with open(input, "rb") as file:
        index_html = file.read()
    index_html =  'import Blob "mo:base/Blob";\nmodule { \n public func get_html() : Blob { return Blob.fromArray('+ str(list(index_html)).replace(" ", "") + ');\n };\n}'
    with open (output, "w") as file:
        file.write(index_html)


def folder_to_motoko(src="html", dest="src/frontend", depth = 0):
    files = glob(f"{src}/*")
    os.makedirs(dest, exist_ok=True)
    res = []
    remove = []
    for file in files:
        if os.path.isfile(file):
            try:
                text_file_to_motoko(file, file.replace(src, dest).split(".")[0] + ".mo")
            except:
                byte_file_to_motoko(file, file.replace(src, dest).split(".")[0] + ".mo")
        else:
            res += folder_to_motoko(file, file.replace(src, dest), depth + 1)
            remove += [file]
    for file in remove:
        files.remove(file)
    files += res
    if depth == 0:
        return [file.replace(src + "/", "") for file in files]
    return files

def generate_html_mo(files, dest="src/frontend"):
    dest = dest + "/__html__.mo"
    
    code = """import Array "mo:base/Array";
import Text "mo:base/Text";
import Blob "mo:base/Blob";
"""

    for file in files:
        
        name = file.split(".")[0].replace("/", "_")
        path = file.split(".")[0]

        code += f'import {name} "{path}";\n'
    

    code += """module {
        public type StatusCode = Nat16;
        public type HeaderField = (Text, Text);
        public type Request = {
            url : Text;
            method : Method;
            body : Blob;
            headers : [HeaderField];
        };
        public type Method = Text;
        public type Response = {
            body : Blob;
            headers : [HeaderField];
            status_code : StatusCode;
        };

    public func get_html(request : Request) : Response {
        let url = request.url;
"""
    for file in files:
        name = file.split(".")[0].replace("/", "_")
        path = file.split(".")[0]
        mimetype = mimetypes[file.split(".")[1]]

        code += f"""
        if (url == "/{file}")
        {"{"}
            return ({"{"}
                body = {name}.get_html();
                headers = [("Content-Type", "{mimetype}")];
                status_code = 200;
            {"}"});
        {"}"};"""
            
    
    code += """
        return ({
            body = Blob.fromArray([]);
            headers = [("Content-Type", "text/html")];
            status_code = 404;
        });
    }
}"""
    
    code = code.replace('url == "/index.html"', 'url == "/" or url == "/index.html"')
    with open (dest, "w") as file:
        file.write(code)
    

def main():
    files = folder_to_motoko(args.source, args.destination)
    generate_html_mo(files, args.destination)


if __name__ == "__main__":
    main()