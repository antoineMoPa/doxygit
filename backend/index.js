var express  = require('express');
var fs = require('fs');
var templates = require('./lib/templates.js');
var app = express();

var templater = templates();

app.get("/",function(req,res){
    var template = templater.get("views/home.jade")
    
    res.send(template.run());
});


var server = app.listen(4000,function(){
    
});