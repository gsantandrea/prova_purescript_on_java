"use strict";

exports.log = function (s) {
    return function() {
        print(s);
    };
};