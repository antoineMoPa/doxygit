var express  = require('express');
var fs = require('fs');
var templates = require('./lib/templates.js');
var app = express();
var bodyParser = require("body-parser");
var child_process = require("child_process");
var templater = templates();
var shortId = require('shortid');

app.use(bodyParser.urlencoded({ extended: false }));

app.get("/",function(req,res){
    var template = templater.get("views/home.jade")
    
    res.send(template.run());
});

app.post("/newdoc",function(req,res){
    var template = templater.get("views/newdoc.jade");
    var repo = req.body.repositoryURL;
    
    /* @TODO: validate my validation */
    if(repo.match(/^[a-zA-Z0-9\-]+@[a-zA-Z0-9\.\-\:\/]+$/)){
        createRepo(repo, success);
    } else if(repo.match(/^http(s)?:\/\/[a-zA-Z0-9\.\-\:\/]+$/)){    
        createRepo(repo, success);
    } else {
        res.send("fail")
    }
    
    function success(){
        res.send(template.run());        
    }
});

function createRepo(url, callback){
    // unique repo id
    var newShortId = shortId.generate()
    /*
      Build shell command that passes the shortid and the repo url
    */
    var command = '/usr/bin/ruby';
    var args = [
        "scripts/git-operations/create-git-repo.rb",
        newShortId,
        repo
    ];
    
    child_process.execFile(command, args, function (err, result) {
        callback();
    });    
}

var server = app.listen(4000,function(){
    
});