var express  = require('express');
var fs = require('fs');
var jade = require('jade');
var app = express();
var bodyParser = require("body-parser");
var child_process = require("child_process");
var path = require('path');
var shortId = require('shortid');

var CONFIG = require("./config");

function renderHTML(){
    var data = {CONFIG: CONFIG}
    var html = jade.renderFile("views/home.jade",data);
    fs.writeFile("../www/index.html",html,function(){
	console.log("Done rendering index.html");
    });
}

renderHTML();

app.use(bodyParser.urlencoded({ extended: false }));

app.get("/",function(req,res){
    res.send("Welcome to the doxygit API !")
});

app.post("/newdoc",function(req,res){
    var repo = req.body.repositoryURL;
    console.log("REPO: "+repo)
    /* @TODO: validate my validation */
    if(repo.match(/^[a-zA-Z0-9\-]+@[a-zA-Z0-9\.\-\:\/]+$/)){
        createRepo(repo, success);
    } else if(repo.match(/^http(s)?:\/\/[a-zA-Z0-9\.\-\:\/]+$/)){    
        createRepo(repo, success);
    } else {
        res.send("fail");
    }
    function success(shortId){
        //change location in header and serve html directly?
        redirect_url = CONFIG.staticURL;
        redirect_url += "/data/" + shortId
        res.redirect(301, redirect_url);
    }
});

function createRepo(repo, callback){
    // unique repo id
    var newShortId = shortId.generate();
    /*
      Build shell command that passes the shortid and the repo url
    */
    var command = 'ruby';
    var args = [
        "scripts/basic-setup.rb",
        newShortId,
        repo
    ];
    
    child_process.execFile(command, args, function (err, result) {
        //todo check err value
        console.log(result);
        callback(newShortId);
    });    
}

var server = app.listen(CONFIG.port, function(){
    console.log("Listening to " + CONFIG.nodeURL)
});
