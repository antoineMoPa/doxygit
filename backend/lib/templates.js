var express  = require('express');
var jade = require('jade');

module.exports = function templates(){
    return {
        get: get
    }
    
    function get(path){
        var html = jade.renderFile(path);
        return {
            run: run,
            html: html
        }
        function run(data){
            dude = "dede"
            return this.html;
        }
    }
}