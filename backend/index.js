var express  = require('express');
var jade = require('jade');
var fs = require('fs');
var app = express();


app.get("/",function(req,res){
    var html = jade.renderFile("views/home.jade");
    
    res.send(html);
});


var server = app.listen(4000,function(){
    
});