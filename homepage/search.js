// Credits: Twily
var $=function(id) { return document.getElementById(id); };
var search=[ // Search engines
    ["",    "https://www.duckduckgo.com/&q="],                           // DDG
    ["!g",  "https://www.google.com/#q="],                               // Google
    ["!i",  "https://www.google.com/search?tbm=isch&q="],                // Google Images
    ["!y",  "https://www.youtube.com/results?search_query="],            // YouTube
    ["!w",  "http://en.wikipedia.org/w/index.php?search="],              // Wikipedia
    ["!m",  "http://www.imdb.com/find?q="],                              // IMDb
    ["!u",  "http://www.urbandictionary.com/define.php?term="],          // Urban Dictionary
    ["!n",  "http://www.nyaa.se/?page=search&cats=0_0&filter=0&term="],  // Nyaa
    ["!a",  "https://aur.archlinux.org/packages/?O=0&K="],               // AUR
];
var ss="";
function init() {
    for(var i=0;i<search.length;i++) if(search[i][0]=="") ss=search[i][1];
    if(ss=="") alert("Error: Missing default search engine!");
    build();
    $('q').value="";
    $('q').focus();
}
function handleQuery(e,q) { // Handle search query
    var key=e.keyCode || e.which;
    if(key==13) { // enter
        if(q.lastIndexOf("!")!=-1) {
            var x=q.lastIndexOf("!"),found=false;
            for(var i=0;i<search.length;i++) {
                if(search[i][0]==q.substr(x)) { // Find "!?"
                    found=true; window.location=search[i][1]+q.substr(0,x).replace(/&/g,"%26");
                }
            }
            if(!found) { // Invalid "!?", use default
                window.location=ss+q.substr(0,x).replace(/&/g,"%26");
            }
        } else { // "!?" where not specified, use default
            window.location=ss+q.replace(/&/g,"%26");
        }
    }
}

