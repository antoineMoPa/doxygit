var express  = require('express');
var jade = require('jade');

module.exports = function templates(){
    return {
        get: get
    }
    function get(path,data){
        var html = jade.renderFile(path,data);
        return {
            run: run,
            html: html
        }
        function run(data){
            return this.html;
        }
    }
}
